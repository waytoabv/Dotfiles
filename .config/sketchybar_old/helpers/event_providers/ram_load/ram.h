#include <mach/mach.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/sysctl.h>

struct ram {
  host_t host;
  vm_size_t page_size;
  
  uint64_t total_ram;      // Total physical RAM in bytes
  uint64_t active_ram;     // Active RAM in bytes
  uint64_t wired_ram;      // Wired RAM in bytes
  uint64_t compressed_ram; // Compressed RAM in bytes
  uint64_t available_ram;  // Available RAM in bytes
  
  int ram_usage;          // RAM usage percentage
};

static inline void ram_init(struct ram* ram) {
  ram->host = mach_host_self();
  
  // Get the page size
  kern_return_t error = host_page_size(ram->host, &ram->page_size);
  if (error != KERN_SUCCESS) {
    // printf("Error: Could not get page size.\n");
    return;
  }
}

static inline void ram_update(struct ram* ram) {
  // Get memory statistics
  vm_statistics64_data_t vm_stats;
  mach_msg_type_number_t count = HOST_VM_INFO64_COUNT;
  
  kern_return_t error = host_statistics64(ram->host,
                                         HOST_VM_INFO64,
                                         (host_info_t)&vm_stats,
                                         &count);
  
  if (error != KERN_SUCCESS) {
    // printf("Error: Could not read RAM statistics.\n");
    return;
  }
  
  // Get total RAM using sysctl
  int mib[2];
  size_t length;
  mib[0] = CTL_HW;
  mib[1] = HW_MEMSIZE;
  length = sizeof(ram->total_ram);
  if (sysctl(mib, 2, &ram->total_ram, &length, NULL, 0) != 0) {
    // printf("Error: Could not get total RAM size.\n");
    return;
  }
  
  // Calculate memory usage
  uint64_t free_memory = vm_stats.free_count * ram->page_size;
  ram->active_ram = vm_stats.active_count * ram->page_size;
  ram->wired_ram = vm_stats.wire_count * ram->page_size;
  ram->compressed_ram = vm_stats.compressor_page_count * ram->page_size;
  ram->available_ram = free_memory;
  
  // Calculate memory pressure based on multiple factors
  if (ram->total_ram > 0) {
    // Calculate the ratio of used memory (active + wired + compressed) to total RAM
    uint64_t used_memory = ram->active_ram + ram->wired_ram + ram->compressed_ram;
    double memory_ratio = (double)used_memory / (double)ram->total_ram;
    
    // Calculate pressure based on the ratio, with some adjustment for compressed memory
    // This is a simplified version of macOS's memory pressure calculation
    double pressure = memory_ratio * 100.0;
    
    // If we have significant compressed memory, increase the pressure slightly
    if (ram->compressed_ram > 0) {
      double compressed_ratio = (double)ram->compressed_ram / (double)ram->total_ram;
      pressure += (compressed_ratio * 20.0); // Add up to 20% for compressed memory
    }
    
    // Cap the pressure at 100%
    ram->ram_usage = (int)(pressure > 100.0 ? 100.0 : pressure);
  } else {
    ram->ram_usage = 0;
  }
}
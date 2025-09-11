#include <mach/mach.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/sysctl.h>

struct swap {
  host_t host;
  vm_size_t page_size;
  
  uint64_t total_swap;      // Total swap space in bytes
  uint64_t used_swap;       // Used swap space in bytes
  uint64_t free_swap;       // Free swap space in bytes
  int swap_usage;          // Swap usage percentage
};

static inline void swap_init(struct swap* swap) {
  swap->host = mach_host_self();
  
  // Get the page size
  kern_return_t error = host_page_size(swap->host, &swap->page_size);
  if (error != KERN_SUCCESS) {
    // printf("Error: Could not get page size.\n");
    return;
  }
}

static inline void swap_update(struct swap* swap) {
  // Get swap statistics
  vm_statistics64_data_t vm_stats;
  mach_msg_type_number_t count = HOST_VM_INFO64_COUNT;
  
  kern_return_t error = host_statistics64(swap->host,
                                         HOST_VM_INFO64,
                                         (host_info_t)&vm_stats,
                                         &count);
  
  if (error != KERN_SUCCESS) {
    // printf("Error: Could not read swap statistics.\n");
    return;
  }
  
  // Get total swap using sysctl
  int mib[2];
  size_t length;
  mib[0] = CTL_VM;
  mib[1] = VM_SWAPUSAGE;
  struct xsw_usage swap_usage;
  length = sizeof(swap_usage);
  
  if (sysctl(mib, 2, &swap_usage, &length, NULL, 0) != 0) {
    // printf("Error: Could not get swap usage.\n");
    return;
  }
  
  swap->total_swap = swap_usage.xsu_total;
  swap->used_swap = swap_usage.xsu_used;
  swap->free_swap = swap_usage.xsu_avail;
  
  // Calculate swap usage percentage
  if (swap->total_swap > 0) {
    double usage_ratio = (double)swap->used_swap / (double)swap->total_swap;
    swap->swap_usage = (int)(usage_ratio * 100.0);
  } else {
    swap->swap_usage = 0;
  }
} 
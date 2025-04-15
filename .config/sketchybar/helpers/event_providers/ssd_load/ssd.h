#include <mach/mach.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/sysctl.h>
#include <sys/statvfs.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

struct ssd {
  char* mount_point;
  uint64_t total_space;    // Total space in bytes
  uint64_t free_space;     // Free space in bytes
  uint64_t used_space;     // Used space in bytes
  int usage_percentage;    // Usage percentage
};

static inline void parse_df_output(const char* output, uint64_t* total, uint64_t* used, uint64_t* free_space) {
  // printf("Raw df output:\n%s\n", output);
  
  char* line = strdup(output);
  char* saveptr;
  char* token = strtok_r(line, "\n", &saveptr);
  
  // Skip header line
  token = strtok_r(NULL, "\n", &saveptr);
  if (token) {
    // Parse the line - df output format is: Filesystem Size Used Avail Capacity iused ifree %iused Mounted
    char* fields[9];
    int i = 0;
    char* field = strtok_r(token, " ", &saveptr);
    while (field && i < 9) {
      fields[i++] = field;
      field = strtok_r(NULL, " ", &saveptr);
    }
    
    if (i >= 4) {
      // printf("Parsed fields:\n");
      // printf("  Size: %s\n", fields[1]);
      // printf("  Used: %s\n", fields[2]);
      // printf("  Avail: %s\n", fields[3]);
      
      // Convert from KB to bytes
      *total = strtoull(fields[1], NULL, 10) * 1024;
      *free_space = strtoull(fields[3], NULL, 10) * 1024;
      *used = *total - *free_space;  // Calculate used space as total - free
    }
  }
  
  free(line);
}

static inline void ssd_init(struct ssd* ssd) {
  // Default to root filesystem
  ssd->mount_point = "/";
}

static inline void ssd_update(struct ssd* ssd) {
  FILE* fp = popen("df -k /", "r");
  if (!fp) {
    // printf("Error: Could not execute df command.\n");
    return;
  }
  
  char output[1024];
  size_t bytes_read = fread(output, 1, sizeof(output) - 1, fp);
  output[bytes_read] = '\0';
  pclose(fp);
  
  parse_df_output(output, &ssd->total_space, &ssd->used_space, &ssd->free_space);
  
  // Calculate usage percentage similar to Rust implementation
  if (ssd->total_space > 0) {
    double usage_ratio = (double)ssd->used_space / (double)ssd->total_space;
    ssd->usage_percentage = (int)round(usage_ratio * 100.0);
  } else {
    ssd->usage_percentage = 0;
  }
} 
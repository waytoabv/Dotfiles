#include "ssd.h"
#include "../sketchybar.h"

int main (int argc, char** argv) {
  float update_freq;
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    // printf("Usage: %s \"<event-name>\" \"<event-freq>\"\n", argv[0]);
    exit(1);
  }

  alarm(0);
  struct ssd ssd;
  ssd_init(&ssd);

  // Setup the event in sketchybar
  char event_message[512];
  snprintf(event_message, 512, "--add event '%s'", argv[1]);
  sketchybar(event_message);

  char trigger_message[512];
  for (;;) {
    // Acquire new info
    ssd_update(&ssd);

    // Format values in GB (using 1000^3 for GB as macOS does)
    float total_gb = (float)ssd.total_space / (1000.0 * 1000.0 * 1000.0);
    float used_gb = (float)ssd.used_space / (1000.0 * 1000.0 * 1000.0);
    float free_gb = (float)ssd.free_space / (1000.0 * 1000.0 * 1000.0);

    // Prepare the event message with detailed SSD information
    snprintf(trigger_message,
             512,
             "--trigger '%s' pressure='%d' used_gb='%.2f' free_gb='%.2f' total_gb='%.2f'",
             argv[1],
             ssd.usage_percentage,
             used_gb,
             free_gb,
             total_gb);

    // Trigger the event
    sketchybar(trigger_message);

    // Wait
    usleep(update_freq * 1000000);
  }
  return 0;
} 
#include "swap.h"
#include "../sketchybar.h"

int main (int argc, char** argv) {
  float update_freq;
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    // printf("Usage: %s \"<event-name>\" \"<event-freq>\"\n", argv[0]);
    exit(1);
  }

  alarm(0);
  struct swap swap;
  swap_init(&swap);

  // Setup the event in sketchybar
  char event_message[512];
  snprintf(event_message, 512, "--add event '%s'", argv[1]);
  sketchybar(event_message);

  char trigger_message[512];
  for (;;) {
    // Acquire new info
    swap_update(&swap);

    // Format swap values in GB for better readability
    float total_gb = (float)swap.total_swap / (1024.0 * 1024.0 * 1024.0);
    float used_gb = (float)swap.used_swap / (1024.0 * 1024.0 * 1024.0);
    float free_gb = (float)swap.free_swap / (1024.0 * 1024.0 * 1024.0);

    // Prepare the event message with detailed swap information
    snprintf(trigger_message,
             512,
             "--trigger '%s' pressure='%d' used_gb='%.2f' free_gb='%.2f' total_gb='%.2f'",
             argv[1],
             swap.swap_usage,
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
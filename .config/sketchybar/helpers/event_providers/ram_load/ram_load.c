#include "ram.h"
#include "../sketchybar.h"

int main (int argc, char** argv) {
  float update_freq;
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    // printf("Usage: %s \"<event-name>\" \"<event-freq>\"\n", argv[0]);
    exit(1);
  }

  alarm(0);
  struct ram ram;
  ram_init(&ram);

  // Setup the event in sketchybar
  char event_message[512];
  snprintf(event_message, 512, "--add event '%s'", argv[1]);
  sketchybar(event_message);

  char trigger_message[512];
  for (;;) {
	// Acquire new info
	ram_update(&ram);

	// Format RAM values in GB for better readability
	float total_gb = (float)ram.total_ram / (1024.0 * 1024.0 * 1024.0);
	float active_gb = (float)ram.active_ram / (1024.0 * 1024.0 * 1024.0);
	float wired_gb = (float)ram.wired_ram / (1024.0 * 1024.0 * 1024.0);
	float compressed_gb = (float)ram.compressed_ram / (1024.0 * 1024.0 * 1024.0);
	float available_gb = (float)ram.available_ram / (1024.0 * 1024.0 * 1024.0);

	// Prepare the event message with detailed RAM information
	snprintf(trigger_message,
			 512,
			 "--trigger '%s' pressure='%d' active='%.2f' wired='%.2f' available='%.2f' compressed='%.2f' total='%.2f'",
			 argv[1],
			 ram.ram_usage,
			 active_gb,
			 wired_gb,
			 available_gb,
			 compressed_gb,
			 total_gb);

	// Trigger the event
	sketchybar(trigger_message);

	// Wait
	usleep(update_freq * 1000000);
  }
  return 0;
}
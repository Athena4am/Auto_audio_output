# HDMI Audio Switch Script (Bash)

A small **Bash script** that automatically switches the system audio output to **HDMI** using `pactl` (PulseAudio / PipeWire).

The script performs the following steps:

1. Changes the audio card profile to **HDMI stereo**.
2. Waits briefly for the system to register the change.
3. Searches for the available **HDMI sink**.
4. Sets it as the **default audio output**.

---

# Script

```bash
#!/bin/bash

CARD="alsa_card.pci-0000_00_1f.3"

pactl set-card-profile $CARD output:hdmi-stereo

sleep 1

HDMI_SINK=$(pactl list short sinks | grep -i hdmi | awk '{print $2}')

if [ -n "$HDMI_SINK" ]; then
    pactl set-default-sink "$HDMI_SINK"
    echo "HDMI enabled successfully: $HDMI_SINK"
else
    echo "Error: HDMI could not be enabled."
fi
```

---

# How it works

### 1. Select the audio card

```bash
CARD="alsa_card.pci-0000_00_1f.3"
```

Defines the audio card that will be used.
You can list available cards with:

```bash
pactl list cards short
```

---

### 2. Switch the profile to HDMI

```bash
pactl set-card-profile $CARD output:hdmi-stereo
```

This activates the HDMI stereo profile for the selected sound card.

---

### 3. Wait for the system to update

```bash
sleep 1
```

The script pauses for one second to allow the system to detect the HDMI sink.

---

### 4. Find the HDMI sink

```bash
HDMI_SINK=$(pactl list short sinks | grep -i hdmi | awk '{print $2}')
```

This command:

* lists available sinks
* filters those containing `hdmi`
* extracts the device name

---

### 5. Set HDMI as the default output

```bash
pactl set-default-sink "$HDMI_SINK"
```

If an HDMI sink is found, it becomes the system's default audio output.

---

# Requirements

* Linux
* `pactl`
* PulseAudio or PipeWire

---

# Usage

Give the script execution permission:

```bash
chmod +x script.sh
```

Run the script:

```bash
./script.sh
```

---

# License

MIT

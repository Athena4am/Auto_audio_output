#!/bin/bash

CARD="alsa_card.pci-0000_00_1f.3"

pactl set-card-profile $CARD output:hdmi-stereo

sleep 1

HDMI_SINK=$(pactl list short sinks | grep -i hdmi | awk '{print $2}')

if [ -n "$HDMI_SINK" ]; then
    pactl set-default-sink "$HDMI_SINK"
    echo "HDMI activado correctamente: $HDMI_SINK"
else
    echo "Error: HDMI no se pudo activar."
fi

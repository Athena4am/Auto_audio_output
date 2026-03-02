#!/bin/bash

CARD="alsa_card.pci-0000_00_1f.3"

# 1️⃣ Forzar perfil HDMI primero
pactl set-card-profile $CARD output:hdmi-stereo

# Esperar medio segundo para que cree el sink
sleep 1

# 2️⃣ Buscar el sink HDMI ya creado
HDMI_SINK=$(pactl list short sinks | grep -i hdmi | awk '{print $2}')

if [ -n "$HDMI_SINK" ]; then
    pactl set-default-sink "$HDMI_SINK"
    echo "HDMI activado correctamente: $HDMI_SINK"
else
    echo "Error: HDMI no se pudo activar."
fi

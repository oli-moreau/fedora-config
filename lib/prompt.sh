#!/bin/bash

center_text() {
    spaces=$(((width - ${#1}) / 2))
    printf "%*s%s%*s\n" $spaces "" "${1}" $spaces
}

config_start() {
  width=$(tput cols)
  echo "$(printf '=%.0s' $(seq 1 $width))"
    center_text "Start of configuration"
  echo "$(printf '=%.0s' $(seq 1 $width))"
}

config_end() {
  width=$(tput cols)
  echo "$(printf '=%.0s' $(seq 1 $width))"
    center_text "End of configuration"
  echo "$(printf '=%.0s' $(seq 1 $width))"
}
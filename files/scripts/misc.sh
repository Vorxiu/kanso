#!/usr/bin/env bash
set -euo pipefail

# create /nix mount point (read-only in the image layer)
mkdir -p /nix

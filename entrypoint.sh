#!/bin/sh

# Get the current architecture
ARCH=$(arch)

# Decide which binary to execute based on the architecture
case "$ARCH" in
  arm64|aarch64)
    # Execute the ARM64 binary
    exec /pb/pocketbase_arm64 serve --http=0.0.0.0:8080 "$@"
    ;;
  x86_64)
    # Execute the x86_64 binary
    exec /pb/pocketbase_x86 serve --http=0.0.0.0:8080 "$@"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac
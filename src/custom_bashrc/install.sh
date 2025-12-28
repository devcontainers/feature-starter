#!/bin/sh
set -e

echo "Customizing bashrc..."
cat .bashrc > /root/.bashrc && chmod +x /root/.bashrc
echo "Done."

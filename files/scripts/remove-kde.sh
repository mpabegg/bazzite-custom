#!/usr/bin/env bash

set -ouex pipefail

dnf5 remove -y xwaylandvideobridge

# Gets the mandatory packages installed in kde-desktop and removes them.
dnf5 group info kde-desktop | \
    sed -n '/^Mandatory packages\s*:/,/^\(Default\|Optional\) packages\s*:/ {
        /^\(Default\|Optional\) packages\s*:/q  # Quit if we hit Default/Optional header
        s/^.*:[[:space:]]*//p
    }' | \
    xargs dnf5 remove -y

dnf5 clean all && \
rm -rf /var/cache/dnf/*

systemctl disable display-manager && systemctl enable cosmic-greeter.service -f

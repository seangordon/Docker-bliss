#!/bin/bash
#
# Script to restart bliss after an update
# Only needed for the Docker build, to stop the container exiting after an update
# We redirect the bundle storage to a persistent volume, and 
# disable the bliss launcher options so that this script controls restarting bliss
# after an upgrade.
export VMARGS="-Dbliss_working_directory=/config -Dorg.osgi.framework.storage=/config/felix-cache"
export BLISS_OSGI_BUNDLE_STORAGE=/config/felix-cache
export BLISS_LAUNCHER_PROPERTY=''

while [ true ]
do
    sh /bliss/bin/bliss.sh
    if [ "$?" = "0" ]; then
        echo "bliss.sh exited, restarting..."
        sleep 2
    else
        echo "bliss.sh exited with a non-zero value, exiting..."
        exit 1
    fi
done

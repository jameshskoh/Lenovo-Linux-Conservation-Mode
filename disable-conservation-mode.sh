#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
    echo "Error: missing root privilege."
    exit 1
fi

FILEPATH="/etc/tlp.d/99-conservation-mode.conf"
SUBSTRING='STOP_CHARGE_THRESH_BAT0'
RESULT='STOP_CHARGE_THRESH_BAT0="0"'

readonly FILEPATH
readonly SUBSTRING
readonly RESULT

if test -f $FILEPATH
then
    # search record in existing file
    echo "Configuration found at $FILEPATH"

    if grep -q "$SUBSTRING" $FILEPATH
    then
        # overwrite existing config
        echo "Overwriting config with $RESULT"
        sed -i.bak "s/.*$SUBSTRING.*/$RESULT/" $FILEPATH

        echo "Previous configuration backed up."
    else
        # append config
        cp $FILEPATH "$FILEPATH.bak"
        echo "Previous configuration backed up."

        echo "Appending config with $RESULT"
        echo $RESULT >> $FILEPATH
    fi

else
    # create new config file
    echo "Configuration not found."
    echo "Creating new configuration at $FILEPATH"

    echo ""
    echo $RESULT > $FILEPATH
fi

tlp start
tlp-stat -b --cdiff

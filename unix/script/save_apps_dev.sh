#!/bin/bash

#==============================================================================
# save apps and dev directories
#==============================================================================

SAVE_DATE=$(date +%Y%m%d_%H%M%S)

SAVE_DIR=/cygdrive/h/dev/save_$SAVE_DATE

mkdir $SAVE_DIR

# zip apps dir
zip -r apps.zip /cygdrive/c/work/apps --symlinks
mv -v apps.zip $SAVE_DIR

# remove target dir before zip
find /cygdrive/c/work/dev -type d -name "target" -exec rm -r {} \;

# zip dev dir
zip -r dev.zip /cygdrive/c/work/dev
mv -v dev.zip $SAVE_DIR

# zip idea conf
zip -r $SAVE_DIR/idea2016.3-conf.zip /cygdrive/c/Users/chdomas/.IdeaIC2016.3/config

# copy Mobaxterm ini file
cp -v "/cygdrive/c/Users/chdomas/Données d'applications/MobaXterm/MobaXterm.ini" $SAVE_DIR

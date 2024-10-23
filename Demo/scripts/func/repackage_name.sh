#!/bin/sh
set -e
WORKING_DIR=$PWD/android
OLD_PACKAGE=$1
NEW_PACKAGE=$2
# search and replace in files
PACKAGE_NAME_ESCAPED="${NEW_PACKAGE//./\.}"
OLD_PACKAGE_NAME_ESCAPED="${OLD_PACKAGE//./\.}"
LC_ALL=C find $WORKING_DIR/app/src -type f -exec sed -i "" "s/$OLD_PACKAGE_NAME_ESCAPED/$PACKAGE_NAME_ESCAPED/g" {} +
perl -pi -e "s/${OLD_PACKAGE_NAME_ESCAPED}/${PACKAGE_NAME_ESCAPED}/g" $WORKING_DIR/app/build.gradle
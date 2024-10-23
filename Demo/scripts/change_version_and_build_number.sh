source scripts/func/config.sh

export LANG=en_US.UTF-8
TAG_NAME=$(git describe --tags)
VERSION=($(grep -oE $(get_regex_version) <<<"$TAG_NAME"))
VERSION_ENV=${VERSION[0]}
VERSION_MAJOR=${VERSION[1]}
VERSION_MINOR=${VERSION[2]}
VERSION_PATCHES=${VERSION[3]}
VERSION_BUILD_NUMBER=${VERSION[4]}
VERSION_FULL=${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCHES}

echo "Version Full: ${VERSION_FULL}"
echo "Version Build Number: ${VERSION_BUILD_NUMBER}"

set_version_app $VERSION_FULL $VERSION_BUILD_NUMBER
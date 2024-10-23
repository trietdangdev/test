# /bin/bash -l
source scripts/func/config.sh
source scripts/func/build_action/build_config.sh
export LANG=en_US.UTF-8

ENV=$1
git fetch --tags -f
TAG_NAME=""
# FETCH TO GET PRO TAG
# PRO TAG VERSION
TAG_PRO="$(git tag -l --sort=-version:refname 'pro-*' | head -n 1)"
VERSION_PRO=($(grep -oE $(get_regex_version) <<<"$TAG_PRO"))
VERSION_PRO_PATCH=${VERSION_PRO[3]}

if [ $ENV != "pro" ]; then
    # FETCH TO GET CURRENT BUILD TAG
    # STG TAG VERSION
    TAG_BUILD="$(git tag -l --sort=-version:refname $ENV-* | head -n 1)"
    VERSION_BUILD=($(grep -oE $(get_regex_version) <<<"$TAG_BUILD"))
    VERSION_BUILD_PATCH=${VERSION_BUILD[3]}
    echo "CURRENT TAG: ${TAG_BUILD}"
    if [ $VERSION_PRO_PATCH = $VERSION_BUILD_PATCH ]; then
        echo "NEW PRO BUILD TAG FOUND: ${TAG_PRO}"
        SKIP=""$(fc_convert_tag $TAG_BUILD)
        BUMP=""$(fc_convert_tag $TAG_BUILD true)
        TAG_NAME=$(fc_prompt_option $SKIP $BUMP)
    else
        SKIP=$(fc_convert_tag $TAG_BUILD)
        TAG_NAME=$(fc_prompt_confirm $SKIP)
    fi
else
    echo "CURRENT TAG: ${TAG_PRO}"
    SKIP_PRO=$(fc_convert_tag $TAG_PRO)
    BUMP_PRO=$(fc_convert_tag $TAG_PRO true)
    TAG_NAME=$(fc_prompt_option $SKIP_PRO $BUMP_PRO)
fi

if [ ! -z "$TAG_NAME" -a "$TAG_NAME" != " " ]; then
    echo "NEW TAG: ${TAG_NAME}"
    cd scripts && chmod +x tag.sh && ./tag.sh $TAG_NAME
fi

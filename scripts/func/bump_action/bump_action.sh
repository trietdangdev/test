# /bin/bash -l
source scripts/func/config.sh
source scripts/func/bump_action/bump_config.sh
export LANG=en_US.UTF-8

ENV=$1
git fetch --tags -f
TAG_NAME=""
echo "Select Bump Version Environment: "
prompt="Select Option: "
options=("Development" "Staging" "Production")
PS3="$prompt"
select opt in "${options[@]}" "Thoat"; do
    case "$REPLY" in
    1) echo "Select Bump $opt" && ENV="dev" && break ;;
    2) echo "Select Bump $opt" && ENV="stg" && break ;;
    2) echo "Select Bump $opt" && ENV="pro" && break ;;
    $((${#options[@]} + 1)))
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Sai lua chon. chon lai."
        continue
        ;;
    esac
done

# FETCH CURRENT TAG BY ENVIRONMENT
TAG_BUILD=$(fc_get_current_tag $ENV)
VERSION_BUILD=($(grep -oE $(get_regex_version) <<<"$TAG_BUILD"))
VERSION_BUILD_NUMBER=${VERSION_BUILD[4]}
# CURRENT TAG
echo "CURRENT TAG: ${TAG_BUILD}"
BUMP=$(fc_bump_tag $ENV $VERSION_BUILD_NUMBER)
# BUMP TO TAG
echo "BUMP TO TAG: ${BUMP}"
TAG_NAME=$(fc_bump_confirm $BUMP)
# CREATE TAG
if [ ! -z "$TAG_NAME" -a "$TAG_NAME" != " " ]; then
    echo "NEW TAG: ${TAG_NAME}"
    cd scripts && chmod +x tag.sh && ./tag.sh $TAG_NAME
fi
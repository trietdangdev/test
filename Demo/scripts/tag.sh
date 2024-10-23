# /bin/bash -l
source func/config.sh
export LANG=en_US.UTF-8

TAG_NAME=$1
TICKET=$(get_id_lc_task)

check_format_tag $TAG_NAME

{
  git tag -a $TAG_NAME -m "New release for $TAG_NAME" &&
    git push origin $TAG_NAME
} || {
  git tag -d $TAG_NAME
}
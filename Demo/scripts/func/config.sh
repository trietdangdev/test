#!/bin/sh
TAG_NAME=$1

check_format_tag() {
  if [[ "$TAG_NAME" =~ [a-z]{3}-([0-9]{1,3}(\.|\+)){3}[0-9]{1,3} ]]; then
      echo "INFO: Tag name $TAG_NAME is the right format tag name for building the new version."
  else
      echo "ERROR: Tag name $TAG_NAME is NOT the right format tag name for building the new version."
      exit 1
  fi
}

get_regex_version() {
  echo '[a-z]{3}|[0-9]{1,3}'
}

set_version_app() {
  perl -i -pe "s/^\s*versionCode\s*\d*$/'        versionCode ${2}'/e" android/app/build.gradle
  perl -i -pe "s/^\s*versionName\s*\"\d*.\d*.\d*\"$/'        versionName \"${1}\"'/e" android/app/build.gradle

  perl -i -pe "s/^\s*CURRENT_PROJECT_VERSION\s*=\s*\d*.\d*.\d*;$/'        CURRENT_PROJECT_VERSION = $2;'/e" ios/liberty_cm.xcodeproj/project.pbxproj
  perl -i -pe "s/^\s*MARKETING_VERSION\s*=\s*\d*.\d*.\d*;$/'        MARKETING_VERSION = $1;'/e" ios/liberty_cm.xcodeproj/project.pbxproj
}

split_version() {
  TAG=$1
  VERSION_TYPE=$2
  VERSION=($(grep -oE $(get_regex_version) <<<"$TAG"))
  VERSION_ENV=${VERSION[0]}
  VERSION_MAJOR=${VERSION[1]}
  VERSION_MINOR=${VERSION[2]}
  VERSION_PATCHES=${VERSION[3]}
  VERSION_BUILD_NUMBER=${VERSION[4]}
  VERSION_FULL=${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCHES}

  case $VERSION_TYPE in
  full)
    echo "${VERSION_FULL}"
    ;;
  all)
    echo ${VERSION}
    ;;
  env)
    echo "${VERSION_ENV}"
    ;;
  major)
    echo ${VERSION_MAJOR}
    ;;
  minor)
    echo ${VERSION_MINOR}
    ;;
  patch)
    echo ${VERSION_PATCHES}
    ;;
  build)
    echo ${VERSION_BUILD_NUMBER}
    ;;
  next_build)
    echo ${VERSION_BUILD_NUMBER}
    ;;
  esac
}

get_id_lc_task() {
  CURRENT_BRANCH=$(git branch --show-current)
  TAG_NAME=$(git describe --tags)
  TAG_ENV_NAME_TAIL_2=$(git tag -l -n "stg-*" --sort=creatordate --format "%(refname:short)" | tail -2)
  eval "TAG_ENV_NAME_TAIL_2=($TAG_ENV_NAME_TAIL_2)"
  LOGS=$(git log --oneline ${CURRENT_BRANCH}...${TAG_ENV_NAME_TAIL_2[1]} ^${TAG_ENV_NAME_TAIL_2[1]})
  # LOGS=$(git log --oneline ${TAG_ENV_NAME_TAIL_2[0]}...${TAG_ENV_NAME_TAIL_2[1]} ^${TAG_ENV_NAME_TAIL_2[0]})
  LOGS=$(echo $LOGS | grep --only-matching --extended-regexp 'EX-[0-9]*')
  LOGS=$(echo "$LOGS" | awk '{for (i=1;i<=NF;i++) if (!a[$i]++) printf("%s, ",$i)}')
  LOGS="${LOGS//EX-0, /}"
  # Trim string
  LOGS="${LOGS%"${LOGS##*[![:space:]]}"}"
  # echo $LOGS
  # Remove commas if it is the last character
  if [[ "${LOGS: -1}" == "," ]]; then
    # Remove the comma
    LOGS="${LOGS%,}"
  fi
  echo $LOGS
}

get_message_information() {
  TAG_SOURCE=$REF_NAME
  VERSION=($(grep -oE '[a-z]{3,4}|[0-9]{1,3}' <<<"$TAG_NAME"))
  VERSION_APPNAME="${VERSION[0]}-${VERSION[1]}"
  VERSION_ENV=$(split_version $TAG_SOURCE env)
  VERSION_MAJOR=$(split_version $TAG_SOURCE major)
  VERSION_MINOR=$(split_version $TAG_SOURCE minor)
  VERSION_PATCHE=$(split_version $TAG_SOURCE patche)
  VERSION_BUILD_NUMBER=$(split_version $TAG_SOURCE build)
  VERSION_FULL=$(split_version $TAG_SOURCE full)
  LINK_ACTION="https://github.com/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"
  # AUTHOR=$GITHUB_TRIGGERING_ACTOR
  AUTHOR=$TRIGGERING_ACTOR
  if [ -z "$AUTHOR" ]; then
    AUTHOR=$(git show -s --format='%an')
  fi
  MESSAGE_INFO="\n- App: Belink HRM.\n"
  MESSAGE_INFO+="- Môi trường: $VERSION_ENV.\n"
  MESSAGE_INFO+="- Phiên bản: $VERSION_FULL ($VERSION_BUILD_NUMBER).\n"
  MESSAGE_INFO+="- Người build: ${AUTHOR}.\n"
  MESSAGE_INFO+="- Link action: $LINK_ACTION.\n"
  echo $MESSAGE_INFO
}

get_tag_source() {
  if [[ "$GITHUB_REF_NAME" =~ (dev|stg|prd)-[0-9]*\.[0-9]*\.[0-9]\+[0-9]* ]]; then
    echo $GITHUB_REF_NAME
  elif [[ "$REF_NAME" =~ (dev|stg|prd)-[0-9]*\.[0-9]*\.[0-9]\+[0-9]* ]]; then
    echo $REF_NAME
  else
    SILENT_LOGS=$(git fetch --tags --force)
    git describe --tags
  fi
}
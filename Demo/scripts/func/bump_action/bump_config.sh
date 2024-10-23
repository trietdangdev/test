source scripts/func/config.sh

fc_get_current_tag() {
  ENV=${1}
  git fetch --tags -f
  TAG_BUILD="$(git tag --sort=-version:refname -l $ENV-* | head -n 1)"
  echo "${TAG_BUILD}"
}

fc_bump_tag () {
  ENV=${1}
  BUILD_NUMBER=${2}
  read -p "INPUT BUMP MAJOR: " major
  read -p "INPUT BUMP MINOR: " minor
  read -p "INPUT BUMP PATCH: " patch
  if [[ "$ENV" = "pro" ]]; then
    BUILD_NUMBER=$((BUILD_NUMBER + 1))
    echo "${ENV}-${major}.${minor}.${patch}+${BUILD_NUMBER}"
  else
    read -p "INPUT BUMP BUILD NUMBER: " number
    echo "${ENV}-${major}.${minor}.${patch}+${number}"
  fi
}

fc_bump_confirm() {
  prompt="Confirm Bump To Tag: ${1} ? "
  options=("Confirm")

  PS3="$prompt"
  select opt in "${options[@]}" "Thoat"; do
      case "$REPLY" in
      1) echo "${1}" && break ;;
        $((${#options[@]} + 1)))
          exit 0
          ;;
        *)
        echo "Sai lua chon. chon lai."
        continue
        ;;
      esac
  done
}
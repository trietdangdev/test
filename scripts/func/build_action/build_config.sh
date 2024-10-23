source scripts/func/config.sh

fc_convert_tag() {
    local isBump="${2:-false}"
    VERSION_BUILD=($(grep -oE $(get_regex_version) <<<"${1}"))
    VERSION_ENV=${VERSION_BUILD[0]}
    VERSION_MAJOR=${VERSION_BUILD[1]}
    VERSION_MINOR=${VERSION_BUILD[2]}
    VERSION_PATCH=${VERSION_BUILD[3]}
    VERSION_NUMBER=${VERSION_BUILD[4]}
    if "$isBump" ; then
        VERSION_PATCH=$((VERSION_PATCH + 1))
        VERSION_NUMBER=$([ ${VERSION_ENV} == 'pro' ] && echo $((VERSION_NUMBER + 1)) || echo $((1)))
    else
        VERSION_NUMBER=$((VERSION_NUMBER + 1))
    fi
    echo "${VERSION_ENV}-${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}+${VERSION_NUMBER}"
}

fc_prompt_option() {
    prompt="Select Build Option: "
    options=("SKIP VERSION (${1})" "BUMP VERSION (${2})")

    PS3="$prompt"
    select opt in "${options[@]}" "Thoat"; do
    case "$REPLY" in
    1) echo ${1} && break ;;
    2) echo ${2} && break ;;
    $((${#options[@]} + 1)))
        exit 1
        ;;
    *)
        echo "Sai lua chon. chon lai."
        continue
        ;;
    esac
    done
}

fc_prompt_confirm() {
  prompt="Confirm Build Tag: ${1} ? "
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
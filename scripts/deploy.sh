# /bin/bash -l
source scripts/func/config.sh
export LANG=en_US.UTF-8

PATH_BUILD_ACTION="scripts/func/build_action/build_action.sh"
PATH_CUSTOM_BUMP_ACTION="scripts/func/bump_action/bump_action.sh"

title="Select Build Environment:"
prompt="Select Option: "
options=("Development" "Staging" "Production" "Bump Version")

echo "$title"
PS3="$prompt "
select opt in "${options[@]}" "Thoat"; do
  case "$REPLY" in
  1) echo "Select Build $opt" && bash $PATH_BUILD_ACTION "dev" && break ;;
  2) echo "Select Build $opt" && bash $PATH_BUILD_ACTION "stg" && break ;;
  3) echo "Select Build $opt" && bash $PATH_BUILD_ACTION "pro" && break ;;
  4) echo "Select $opt" && bash $PATH_CUSTOM_BUMP_ACTION && break ;;
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

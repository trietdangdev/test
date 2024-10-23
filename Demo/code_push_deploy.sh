read -p "Enter description release: " description

project_file="ios/liberty_cm.xcodeproj/project.pbxproj"
  # Check if the file exists
  if [ -f "$project_file" ]; then
      # Use awk to search for MARKETING_VERSION and extract the value
      marketing_version=$(cat $project_file | grep -m1 'MARKETING_VERSION' | cut -d'=' -f2 | tr -d ';' | tr -d ' ')
      echo "$marketing_version"
  else
      echo "File not found: $project_file"
      exit 1
fi
appcenter codepush release-react -a liberty-technology/belink-hrm-ios -d Staging --description "$description" -t $marketing_version
appcenter codepush release-react -a liberty-technology/belink-hrm-android -d Staging --description "$description"

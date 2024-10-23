cd ./scripts

CODE_PUSH_DEPLOYMENT_KEY_OLD='<key>CodePushDeploymentKey<\/key>'
CODE_PUSH_IMPORT_OLD='#import <CodePush\/CodePush.h>'
CODE_PUSH_CONFIG_OLD='CodePush bundleURL'
CODE_PUSH_DEPLOYMENT_VALUE_OLD="<string>iXbWtZKYRvlMzfJjP8SJK2mryN5XWp9XcCaMC<\/string>"
APP_INDEX_FILE_OLD="../src/index.tsx"

CODE_PUSH_IMPORT_ANDROID_OLD='import com.microsoft.codepush.react.CodePush;'
CODE_PUSH_CONFIG='[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"'

CODE_PUSH_ANDROID_SETTING_INCLUDE='include ':app', ':react-native-code-push''
CODE_PUSH_ANDROID_SETTING_PROJECT='project(':react-native-code-push').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-code-push/android/app')'
CODE_PUSH_ANDROID_APPLY='apply from: file("../../node_modules/react-native-code-push/android/codepush.gradle")'

APP_INDEX_FILE="./data/app/index.tsx"
IMPORT_CODE_PUSH_FILE="import AppCodePush from '@modules\/devTool\/screens\/CodePush'"
IMPORT_DEV_SETING="import {DevSetting} from '..\/screens\/Account\/containers\/DevSetting'"
IMPORT_DEV_SETING_NEW=""

# file
INFO_PLIST_FILE='../ios/liberty_cm/Info.plist'
APP_DELEGATE_FILE='../ios/liberty_cm/AppDelegate.mm'
MAIN_APPLICATION_FILE='../android/app/src/main/java/com/liberty_cm/MainApplication.java'
SETTING_FILE='../android/settings.gradle'
GRADLE_APP_FILE='../android/app/build.gradle'
MAIN_STACK_NAV='../src/navigation/MainNavigation.tsx'
GROUP_MENU_FILE='../src/modules/account/components/GroupMenu.tsx'

sed "/$CODE_PUSH_IMPORT_ANDROID_OLD/d" "$MAIN_APPLICATION_FILE" > temp_file && mv temp_file "$MAIN_APPLICATION_FILE"
sed "/$IMPORT_CODE_PUSH_FILE/d" "$MAIN_STACK_NAV" > temp_file && mv temp_file "$MAIN_STACK_NAV"

sed "/$IMPORT_DEV_SETING/d" "$GROUP_MENU_FILE" > temp_file && mv temp_file "$GROUP_MENU_FILE"

# ios
sed "/$CODE_PUSH_DEPLOYMENT_VALUE_OLD/d" "$INFO_PLIST_FILE" > temp_file && mv temp_file "$INFO_PLIST_FILE"
sed "/$CODE_PUSH_DEPLOYMENT_KEY_OLD/d" "$INFO_PLIST_FILE" > temp_file && mv temp_file "$INFO_PLIST_FILE"

sed "/$CODE_PUSH_IMPORT_OLD/d" "$APP_DELEGATE_FILE" > temp_file && mv temp_file "$APP_DELEGATE_FILE"
perl -pi -e "s/${CODE_PUSH_CONFIG_OLD}/${CODE_PUSH_CONFIG}/g" $APP_DELEGATE_FILE

# android

SEARCH_TEXT='CodePush.getJSBundleFile'
LINE_FIND=$(grep -n "$SEARCH_TEXT" "$MAIN_APPLICATION_FILE" | cut -d':' -f1)

LINE_NUMBER_0=$((LINE_FIND - 2))
LINE_NUMBER_1=$((LINE_FIND - 1))
LINE_NUMBER_2=$((LINE_FIND + 1))

awk -v line_number="$LINE_NUMBER_2" 'NR!=line_number' "$MAIN_APPLICATION_FILE" > "$MAIN_APPLICATION_FILE.tmp" && mv "$MAIN_APPLICATION_FILE.tmp" "$MAIN_APPLICATION_FILE"
awk -v line_number="$LINE_FIND" 'NR!=line_number' "$MAIN_APPLICATION_FILE" > "$MAIN_APPLICATION_FILE.tmp" && mv "$MAIN_APPLICATION_FILE.tmp" "$MAIN_APPLICATION_FILE"
awk -v line_number="$LINE_NUMBER_1" 'NR!=line_number' "$MAIN_APPLICATION_FILE" > "$MAIN_APPLICATION_FILE.tmp" && mv "$MAIN_APPLICATION_FILE.tmp" "$MAIN_APPLICATION_FILE"
awk -v line_number="$LINE_NUMBER_0" 'NR!=line_number' "$MAIN_APPLICATION_FILE" > "$MAIN_APPLICATION_FILE.tmp" && mv "$MAIN_APPLICATION_FILE.tmp" "$MAIN_APPLICATION_FILE"


SEARCH_TEXT_CODE_PUSH='node_modules/react-native-code-push/android/app'
LINE_FIND_SETTING_CODE_PUSH=$(grep -n "$SEARCH_TEXT_CODE_PUSH" "$SETTING_FILE" | cut -d':' -f1)
LINE_FIND_SETTING_CODE_PUSH_1=$((LINE_FIND_SETTING_CODE_PUSH - 1))
awk -v line_number="$LINE_FIND_SETTING_CODE_PUSH" 'NR!=line_number' "$SETTING_FILE" > "$SETTING_FILE.tmp" && mv "$SETTING_FILE.tmp" "$SETTING_FILE"
awk -v line_number="$LINE_FIND_SETTING_CODE_PUSH_1" 'NR!=line_number' "$SETTING_FILE" > "$SETTING_FILE.tmp" && mv "$SETTING_FILE.tmp" "$SETTING_FILE"

SEARCH_TEXT_CODE_PUSH_APP_GRADLE='react-native-code-push/android/codepush.gradle'
LINE_FIND_APP_CODE_PUSH=$(grep -n "$SEARCH_TEXT_CODE_PUSH_APP_GRADLE" "$GRADLE_APP_FILE" | cut -d':' -f1)
awk -v line_number="$LINE_FIND_APP_CODE_PUSH" 'NR!=line_number' "$GRADLE_APP_FILE" > "$GRADLE_APP_FILE.tmp" && mv "$GRADLE_APP_FILE.tmp" "$GRADLE_APP_FILE"

cp $APP_INDEX_FILE $APP_INDEX_FILE_OLD

SEARCH_TEXT_APP_CODE_PUSH='AppCodePush'
LINE_FIND_APP_CODE_PUSH=$(grep -n "$SEARCH_TEXT_APP_CODE_PUSH" "$MAIN_STACK_NAV" | cut -d':' -f1)
LINE_FIND_APP_CODE_PUSH_0=$((LINE_FIND_APP_CODE_PUSH - 3))
LINE_FIND_APP_CODE_PUSH_1=$((LINE_FIND_APP_CODE_PUSH - 2))
LINE_FIND_APP_CODE_PUSH_2=$((LINE_FIND_APP_CODE_PUSH - 1))
LINE_FIND_APP_CODE_PUSH_3=$((LINE_FIND_APP_CODE_PUSH + 1))

awk -v line_number="$LINE_FIND_APP_CODE_PUSH_3" 'NR!=line_number' "$MAIN_STACK_NAV" > "$MAIN_STACK_NAV.tmp" && mv "$MAIN_STACK_NAV.tmp" "$MAIN_STACK_NAV"
awk -v line_number="$LINE_FIND_APP_CODE_PUSH" 'NR!=line_number' "$MAIN_STACK_NAV" > "$MAIN_STACK_NAV.tmp" && mv "$MAIN_STACK_NAV.tmp" "$MAIN_STACK_NAV"
awk -v line_number="$LINE_FIND_APP_CODE_PUSH_2" 'NR!=line_number' "$MAIN_STACK_NAV" > "$MAIN_STACK_NAV.tmp" && mv "$MAIN_STACK_NAV.tmp" "$MAIN_STACK_NAV"
awk -v line_number="$LINE_FIND_APP_CODE_PUSH_1" 'NR!=line_number' "$MAIN_STACK_NAV" > "$MAIN_STACK_NAV.tmp" && mv "$MAIN_STACK_NAV.tmp" "$MAIN_STACK_NAV"
awk -v line_number="$LINE_FIND_APP_CODE_PUSH_0" 'NR!=line_number' "$MAIN_STACK_NAV" > "$MAIN_STACK_NAV.tmp" && mv "$MAIN_STACK_NAV.tmp" "$MAIN_STACK_NAV"


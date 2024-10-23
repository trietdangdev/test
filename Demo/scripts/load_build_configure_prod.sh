echo 'run load_build_configure_prod.sh'

APP_ENV_FILE_OLD='src/constant/dynamic.constants.ts'

APP_ICON_OLD='src/assets/logo/app-icon.png'
APP_ICON_BACKGROUND_OLD='src/assets/logo/app-icon-background.png'

# android old information
GOOGLE_SERVICES_JSON_FILE_OLD='android/app/google-services.json'
RELEASE_KEYSTORE_OLD='android/app/prod-release.keystore'

# ios old information
GOOGLE_SERVICES_INFO_PLIST_FILE_OLD='ios/GoogleService-Info.plist'
API_KEY_OLD='scripts/data/apikey/AuthKey.json'

APP_ICON='scripts/data/icons/pro-app-icon.png'
APP_ICON_BACKGROUND='scripts/data/icons/pro-app-icon-background.png'
APP_ENV_FILE='scripts/data/env/dynamic.constants.ts.prod'

# Android information need to change
GOOGLE_SERVICES_JSON_FILE='scripts/data/firebase/pro-google-services.json'
RELEASE_KEYSTORE='scripts/data/keystore/prod-release.keystore'

# ios information need to change
GOOGLE_SERVICES_INFO_PLIST_FILE='scripts/data/firebase/pro-GoogleService-Info.plist'
API_KEY='scripts/data/apikey/pro_AuthKey.json'

# Change google-services.json file
cp $GOOGLE_SERVICES_JSON_FILE $GOOGLE_SERVICES_JSON_FILE_OLD

# Change env file
cp $APP_ENV_FILE $APP_ENV_FILE_OLD

# Change key store file
cp $RELEASE_KEYSTORE $RELEASE_KEYSTORE_OLD

# Change GoogleService-Info.plist file
cp $GOOGLE_SERVICES_INFO_PLIST_FILE $GOOGLE_SERVICES_INFO_PLIST_FILE_OLD

# Change App-icon
cp $APP_ICON $APP_ICON_OLD
cp $APP_ICON_BACKGROUND $APP_ICON_BACKGROUND_OLD

#Change API Key file
cp $API_KEY $API_KEY_OLD
echo "ANDROID_FIREBASE_ID=1:36081245933:android:128c364ca80e7cd3f336e4" >> $GITHUB_ENV
echo "FIREBASE_CLI_TOKEN=$PRO_FIREBASE_CLI_TOKEN" >> $GITHUB_ENV
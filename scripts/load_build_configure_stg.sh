echo 'run load_build_configure_stg.sh'

APP_ENV_FILE_OLD='src/constant/dynamic.constants.ts'

APP_ICON_OLD='src/assets/logo/app-icon.png'
APP_ICON_BACKGROUND_OLD='src/assets/logo/app-icon-background.png'

# android old information
GOOGLE_SERVICES_JSON_FILE_OLD='android/app/google-services.json'

# ios old information
GOOGLE_SERVICES_INFO_PLIST_FILE_OLD='ios/GoogleService-Info.plist'

APP_ICON='scripts/data/icons/stg-app-icon.png'
APP_ICON_BACKGROUND='scripts/data/icons/stg-app-icon-background.png'
APP_ENV_FILE='scripts/data/env/dynamic.constants.ts.stg'

# Android information need to change
GOOGLE_SERVICES_JSON_FILE='scripts/data/firebase/stg-google-services.json'

# ios information need to change
GOOGLE_SERVICES_INFO_PLIST_FILE='scripts/data/firebase/stg-GoogleService-Info.plist'

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


echo $API_KEY_JSON >> scripts/data/apikey/AuthKey.json
echo "ANDROID_FIREBASE_ID=1:422008269517:android:019d064e6714d9f75c9784" >> $GITHUB_ENV
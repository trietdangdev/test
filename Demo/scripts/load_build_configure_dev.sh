# /bin/bash -l
echo "===== Config Development Environment"
WORKING_DIR=$(pwd)

# LOAD AUTH API KEY
echo "===== INFO: Load API key JSON"
echo $API_KEY_JSON >> scripts/data/apikey/AuthKey.json

# # LOAD ANDROID_FIREBASE_ID
# echo "===== INFO: LOAD ANDROID_FIREBASE_ID FROM GOOGLE SERVICES FILE"
# ANDROID_FIREBASE_ID_LINE=$(grep 'mobilesdk_app_id' android/app/google-services.json)
# ANDROID_FIREBASE_ID=$(echo $ANDROID_FIREBASE_ID_LINE | cut -d':' -f2- | tr -d '",' | sed -n '1p')
# echo "ANDROID_FIREBASE_ID=$ANDROID_FIREBASE_ID" >> $GITHUB_ENV

# CHANGE .ENV FILE
echo "===== INFO: Load Env File"
APP_ENV_FILE_OLD="$WORKING_DIR/src/constant/dynamic.constants.ts"
APP_ENV_FILE="$WORKING_DIR/scripts/data/env/dynamic.constants.ts.dev"
cp $APP_ENV_FILE $APP_ENV_FILE_OLD


APP_ICON_BACKGROUND_OLD='src/assets/logo/app-icon-background.png'
APP_ICON_BACKGROUND='scripts/data/icons/dev-app-icon-background.png'
cp $APP_ICON_BACKGROUND $APP_ICON_BACKGROUND_OLD
echo "ANDROID_FIREBASE_ID=1:422008269517:android:521e072779dba2435c9784" >> $GITHUB_ENV
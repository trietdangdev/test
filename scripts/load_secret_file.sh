echo $PRO_GOOGLESERVICE_INFO_PLIST >>scripts/data/firebase/pro-GoogleService-Info.plist
echo $PRO_GOOGLE_SERVICES_JSON >>scripts/data/firebase/pro-google-services.json

# echo "===== INFO: Load >scripts/data/keystore/release.base64"
# echo $PROD_RELEASE_KEYSTORE_BASE64 >>scripts/data/keystore/release.keystore.base64
# base64 --decode -i scripts/data/keystore/release.keystore.base64 > scripts/data/keystore/prod-release.keystore

echo "===== INFO: Load env/dynamic.constants.ts.prod.base64"
echo $DYNAMIC_CONSTANTS_TS_PROD_BASE64 >>scripts/data/env/dynamic.constants.ts.prod.base64
base64 --decode -i scripts/data/env/dynamic.constants.ts.prod.base64 > scripts/data/env/dynamic.constants.ts.prod

# echo INFO: Load keystore/release.keystore.base64
# echo $PROD_RELEASE_KEYSTORE_BASE64 >>scripts/data/keystore/release.keystore.base64
# if [[ $OSTYPE == 'darwin'* ]]; then
#   base64 --decode -i scripts/data/keystore/release.keystore.base64 > scripts/data/keystore/prod-release.keystore
# fi

# if [[ $OSTYPE == 'linux'* ]]; then
#   base64 -d scripts/data/keystore/release.keystore.base64 <<<cat >scripts/data/keystore/prod-release.keystore
# fi

echo "===== INFO: Load >scripts/data/apikey/AuthKey.json"
echo $PRO_API_KEY_JSON >>scripts/data/apikey/pro_AuthKey.json

echo INFO: Load apikey/PlayStoreKey.json
echo $PRO_PLAY_STORE_KEY_JSON >>scripts/data/apikey/PlayStoreKey.json
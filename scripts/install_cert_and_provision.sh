source scripts/func/config.sh

TAG_SOURCE=$(get_tag_source)
ENVIRONMENT=$(split_version $TAG_SOURCE env)
echo "Environment: $ENVIRONMENT"

# create variables
CERTIFICATE_PATH=$GITHUB_WORKSPACE/scripts/data/resources/certificates/deployment.p12
CERTIFICATE_PRD_PATH=$GITHUB_WORKSPACE/scripts/data/resources/certificates/deployment-prd.p12
KEYCHAIN_PATH=$GITHUB_WORKSPACE/scripts/data/certificates/app-signing.keychain-db
PP_PATH=$GITHUB_WORKSPACE/scripts/data/resources/provisions/develop
PP_PRD_PATH=$GITHUB_WORKSPACE/scripts/data/resources/provisions/product

# create temporary keychain
security create-keychain -p "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH
security set-keychain-settings -lut 21600 $KEYCHAIN_PATH
security unlock-keychain -p "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH

# import certificate to keychain
if [ $ENVIRONMENT = "pro" ]; then
  security import $CERTIFICATE_PRD_PATH -P "$P12_PASSWORD" -A -t cert -f pkcs12 -k $KEYCHAIN_PATH
else
  security import $CERTIFICATE_PATH -P "$P12_PASSWORD" -A -t cert -f pkcs12 -k $KEYCHAIN_PATH
fi
security set-key-partition-list -S apple-tool:,apple: -k "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH
security list-keychain -d user -s $KEYCHAIN_PATH

# apply provisioning profile
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
if [ $ENVIRONMENT = "pro" ]; then
  cp $PP_PRD_PATH/* ~/Library/MobileDevice/Provisioning\ Profiles
else
  cp $PP_PATH/* ~/Library/MobileDevice/Provisioning\ Profiles
fi

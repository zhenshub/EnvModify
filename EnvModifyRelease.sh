# 工程名
APP_NAME="EnvModify"
# 证书
CODE_SIGN_DISTRIBUTION="iPhone Developer: junjie li (RBG5C32B46)"
# info.plist路径
project_infoplist_path="./${APP_NAME}/Info.plist"

#取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")

#取build值
bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")

DATE="$(date +%Y%m%d)"
IPANAME="${APP_NAME}_V${bundleShortVersion}_${DATE}RELEASE.ipa"
ARCHNAME="${IPANAME}.xcarchive"


#要上传的ipa文件路径
IPA_PATH="$HOME/${IPANAME}"
echo ${IPA_PATH}
echo "${IPA_PATH}">> text.txt

echo "=================clean================="
xcodebuild -workspace "${APP_NAME}.xcworkspace" -scheme "${APP_NAME}"  -configuration 'Release' clean

echo "+++++++++++++++++build+++++++++++++++++"
xcodebuild -workspace "${APP_NAME}.xcworkspace" -scheme "${APP_NAME}" -sdk iphoneos -configuration 'Release'  SYMROOT='$(PWD)' -allowProvisioningUpdates

#构建
xcodebuild archive \
-workspace "${APP_NAME}.xcworkspace" \
-scheme "${APP_NAME}" \
-configuration Release \
-archivePath $ARCHNAME \
clean \
build \
-derivedDataPath ./
if [ -e $ARCHNAME ]; then
echo "==================xcodebuild archive Successful==================="
else
echo "==================xcodebuild archive Failed======================="
exit 1
fi

#xcrun -sdk iphoneos PackageApplication "./Release-iphoneos/${APP_NAME}.app" -o ~/"${IPANAME}"
#xcdebuild -exportArchive - archivePath
xcodebuild -exportArchive -archivePath "${ARCHNAME}" -exportPath "${IPANAME}" -exportOptionsPlist ./ExportOptions.plist -allowProvisioningUpdates

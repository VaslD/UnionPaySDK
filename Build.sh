#!/bin/zsh

XCFW_PROJECT="UnionPay.xcodeproj"
echo "Workspace:   $XCFW_PROJECT"

XCFW_SCHEME="UnionPay"
echo "Scheme:      $XCFW_SCHEME"

xcodebuild -showBuildSettings -project "$XCFW_PROJECT" -scheme "$XCFW_SCHEME" -configuration "Release" >/dev/null 2>/dev/null || {
    XCFW_STATUS=$?
    echo
    echo "Xcode workspace or scheme was not found."
    echo "You may need to run CocoaPods first and/or create schemes for archiving."
    exit $XCFW_STATUS
}

XCFW_NAME="UnionPay"

echo "(1) Building for iOS Simulator"
xcodebuild archive -project "$XCFW_PROJECT" -scheme "$XCFW_SCHEME" \
    -configuration "Release" \
    -destination "generic/platform=iphonesimulator" \
    -archivePath "$PWD/Simulator.xcarchive" >>"$PWD/Build.log" 2>>"$PWD/Build.log" || {
        XCFW_STATUS=$?
        echo
        echo "Building for iOS simulator failed with code $XCFW_STATUS."
        echo "See \"$PWD/Build.log\" for warnings and errors."
        exit $XCFW_STATUS
    }
rm -f "$PWD/Build.log" >/dev/null 2>/dev/null

echo "(2) Building for generic iOS device"
xcodebuild archive -project "$XCFW_PROJECT" -scheme "$XCFW_SCHEME" \
    -configuration "Release" \
    -destination "generic/platform=iphoneos" \
    -archivePath "$PWD/iOS.xcarchive" >>"$PWD/Build.log" 2>>"$PWD/Build.log" || {
        XCFW_STATUS=$?
        echo
        echo "Building for iOS device failed with code $XCFW_STATUS."
        echo "See \"$PWD/Build.log\" for warnings and errors."
        exit $XCFW_STATUS
    }
rm -f "$PWD/Build.log" >/dev/null 2>/dev/null

echo "(3) Packaging XCFramework"
xcodebuild -create-xcframework \
    -archive "$PWD/Simulator.xcarchive" -framework "$XCFW_SCHEME.framework" \
    -debug-symbols "$PWD/Simulator.xcarchive/dSYMs" \
    -archive "$PWD/iOS.xcarchive" -framework "$XCFW_SCHEME.framework" \
    -debug-symbols "$PWD/iOS.xcarchive/dSYMs" \
    -output "$PWD/$XCFW_NAME.xcframework" >>"$PWD/Build.log" 2>>"$PWD/Build.log" || {
        XCFW_STATUS=$?
        echo
        echo "Packaging XCFramework failed with error $XCFW_STATUS."
        exit $XCFW_STATUS
    }

rm -rf "$PWD/Simulator.xcarchive" >/dev/null 2>/dev/null
rm -rf "$PWD/iOS.xcarchive" >/dev/null 2>/dev/null
rm -f "$PWD/Build.log" >/dev/null 2>/dev/null
rm -rf "$PWD/../build/" >/dev/null 2>/dev/null
unset XCFW_PROJECT
unset XCFW_SCHEME
unset XCFW_NAME
echo
echo "XCFramework: $PWD/$XCFW_NAME.xcframework"
exit 0

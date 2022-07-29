#!/bin/sh
# https://github.com/apple/swift-package-manager/blob/main/Documentation/Usage.md#release

echo "prepare build files"
rm -rf .archives
rm -rf .swiftpm
rm -rf dummy.xcodeproj
mv Package.swift Package.swift.dist
mv Package.swift.build Package.swift

# https://www.youtube.com/watch?v=6BRrYT7bO1Q
echo "generate xcode project - HAVE TO DO IT to use -sdk flag in xcodebuild below"
swift package generate-xcodeproj

echo "build iOS and tvOS package"
SCHEME_NAME=dummy-Package
FRAMEWORK_NAME=dummy
ARCHIVE_DIR=archive

xcodebuild -showsdks

xcodebuild archive -quiet \
  -scheme $SCHEME_NAME \
  -sdk iphoneos15.2 \
  -configuration Release \
  -archivePath "$ARCHIVE_DIR/ios_devices.xcarchive" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO

xcodebuild archive -quiet \
  -scheme $SCHEME_NAME \
  -sdk iphonesimulator15.2 \
  -configuration Release \
  -archivePath "$ARCHIVE_DIR/ios_simulators.xcarchive" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO
  
xcodebuild archive -quiet \
  -scheme $SCHEME_NAME \
  -sdk appletvos15.2 \
  -configuration Release \
  -archivePath "$ARCHIVE_DIR/tvos_devices.xcarchive" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO

xcodebuild archive -quiet \
  -scheme $SCHEME_NAME \
  -sdk appletvsimulator15.2 \
  -configuration Release \
  -archivePath "$ARCHIVE_DIR/tvos_simulators.xcarchive" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO

echo "build combined xcframework for distribution"
xcodebuild -create-xcframework -output "$ARCHIVE_DIR/$FRAMEWORK_NAME.xcframework" \
  -framework "$ARCHIVE_DIR/ios_devices.xcarchive/Products/Library/Frameworks/$FRAMEWORK_NAME.framework" \
  -framework "$ARCHIVE_DIR/ios_simulators.xcarchive/Products/Library/Frameworks/$FRAMEWORK_NAME.framework" \
  -framework "$ARCHIVE_DIR/tvos_devices.xcarchive/Products/Library/Frameworks/$FRAMEWORK_NAME.framework" \
  -framework "$ARCHIVE_DIR/tvos_simulators.xcarchive/Products/Library/Frameworks/$FRAMEWORK_NAME.framework"

# https://developer.apple.com/documentation/swift_packages/distributing_binary_frameworks_as_swift_packages
echo "zip the xcframework"
cd $ARCHIVE_DIR
zip -r -X $FRAMEWORK_NAME.xcframework.zip $FRAMEWORK_NAME.xcframework
cd ..

echo "genefrate checksum hash for .binaryTarget"
checksum=$(swift package compute-checksum $ARCHIVE_DIR/$FRAMEWORK_NAME.xcframework.zip)
sed -i "" -e "s/checksum.*/checksum: \"$checksum\"),/" Package.swift.dist

echo "clean up"
mv Package.swift Package.swift.build
mv Package.swift.dist Package.swift
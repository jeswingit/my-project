#!/bin/bash
set -e

APP_NAME="MotivationalQuotes"
PACKAGE="com.example.motivationalquotes"
ANDROID_JAR="/usr/lib/android-sdk/platforms/android-23/android.jar"
BUILD_TOOLS="/usr/lib/android-sdk/build-tools/debian"
DX="/usr/lib/android-sdk/build-tools/debian/dx"
OUT_DIR="build"

mkdir -p $OUT_DIR/gen $OUT_DIR/obj $OUT_DIR/apk/res

echo "==> Generating R.java..."
aapt package -f -m \
    -S src/main/res \
    -J $OUT_DIR/gen \
    -M src/main/AndroidManifest.xml \
    -I $ANDROID_JAR

echo "==> Compiling Java..."
javac -source 1.8 -target 1.8 \
    -classpath $ANDROID_JAR \
    -d $OUT_DIR/obj \
    $OUT_DIR/gen/$(echo $PACKAGE | tr '.' '/')/R.java \
    src/main/java/$(echo $PACKAGE | tr '.' '/')/MainActivity.java

echo "==> Converting to DEX..."
$DX --dex --output=$OUT_DIR/classes.dex $OUT_DIR/obj

echo "==> Packaging APK..."
aapt package -f \
    -M src/main/AndroidManifest.xml \
    -S src/main/res \
    -I $ANDROID_JAR \
    -F $OUT_DIR/${APP_NAME}-unsigned.apk \
    $OUT_DIR

echo "==> Adding DEX to APK..."
cd $OUT_DIR && zip -u ${APP_NAME}-unsigned.apk classes.dex && cd ..

echo "==> Signing APK..."
# Generate debug keystore if it doesn't exist
if [ ! -f debug.keystore ]; then
    keytool -genkey -v \
        -keystore debug.keystore \
        -alias androiddebugkey \
        -keyalg RSA \
        -keysize 2048 \
        -validity 10000 \
        -storepass android \
        -keypass android \
        -dname "CN=Android Debug,O=Android,C=US"
fi

apksigner sign \
    --ks debug.keystore \
    --ks-pass pass:android \
    --key-pass pass:android \
    --ks-key-alias androiddebugkey \
    --out $OUT_DIR/${APP_NAME}.apk \
    $OUT_DIR/${APP_NAME}-unsigned.apk

echo "==> Done! APK: $OUT_DIR/${APP_NAME}.apk"
ls -lh $OUT_DIR/${APP_NAME}.apk

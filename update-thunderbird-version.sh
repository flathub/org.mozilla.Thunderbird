#!/bin/bash
set -eox pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 URL"
  echo ""
  echo "Example: $0 68.1.1"
  exit 1
fi

VERSION="$1"
PACKAGE=thunderbird
PLATFORM=linux-x86_64
SOURCE_URL="https://archive.mozilla.org/pub/$PACKAGE/releases/$VERSION"
MANIFEST_NAME="$PACKAGE-sources"
MANIFEST_FILE_TEMPLATE="$MANIFEST_NAME.json.template"
MANIFEST_FILE="$MANIFEST_NAME.json"

mkdir -p langpacks
cd langpacks || exit
wget -nc "$SOURCE_URL/SHA256SUMS"
CHECKSUM="$(grep "source/$PACKAGE-$VERSION.source.tar.xz" SHA256SUMS | cut -d\  -f1)"
wget -nc -nd -np --recursive --level=0 "$SOURCE_URL/$PLATFORM/xpi/"
for lang in *.xpi
do
LOCALE="$(basename -s .xpi "$lang")"
LOCALE_CHECKSUM="$(grep "$PLATFORM/xpi/$lang" SHA256SUMS | cut -d\  -f1)"
LANGPACKS="$LANGPACKS
    {
        \"type\": \"file\",
        \"url\": \"$SOURCE_URL/$PLATFORM/xpi/$lang\",
        \"sha256\": \"$LOCALE_CHECKSUM\",
        \"dest\": \"langpacks/\",
        \"dest-filename\": \"langpack-$LOCALE@$PACKAGE.mozilla.org.xpi\"
    },"
done
cd - || exit

export VERSION
export CHECKSUM
export LANGPACKS

< "$MANIFEST_FILE_TEMPLATE" envsubst > "$MANIFEST_FILE"

# Cleanup downloaded langpacks
rm -rf langpacks

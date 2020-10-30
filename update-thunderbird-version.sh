#!/bin/bash
set -eo pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 VERSION"
  echo ""
  echo "Example: $0 68.1.1"
  exit 1
fi

VERSION="$1"
PACKAGE=thunderbird
PLATFORM=linux-x86_64
BASE_URL="https://archive.mozilla.org/pub/$PACKAGE/releases/$VERSION"
SOURCES_FILE="$PACKAGE-sources.json"

# write new sources file
echo '[' > "$SOURCES_FILE"

# read files from SHA256SUMS file
while read -r line; do
  checksum="${line%%  *}"
  path="${line#*  }"

  # store source archive entry for later, because it should be the last element
  # in the json array
  if [[ $path =~ ^source/ ]]; then
    source_archive='    {
        "type": "archive",
        "url": "'"$BASE_URL"'/'"$path"'",
        "sha256": "'"$checksum"'"
    }'

  # add locale to sources file
  else
    # strip directories and .xpi extension
    locale="${path##*/}"
    locale="${locale%.*}"

    cat >> "$SOURCES_FILE" <<EOT
    {
        "type": "file",
        "url": "$BASE_URL/$path",
        "sha256": "$checksum",
        "dest": "langpacks/",
        "dest-filename": "langpack-$locale@$PACKAGE.mozilla.org.xpi"
    },
EOT
  fi
done < <(curl -Ss "$BASE_URL/SHA256SUMS" | grep "^\S\+  \(source\|$PLATFORM/xpi\)/")

# add source archive entry to sources file
echo -e "$source_archive\n]" >> "$SOURCES_FILE"

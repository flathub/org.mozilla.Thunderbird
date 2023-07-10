#!/bin/bash
set -eo pipefail

if (($# < 2)); then
  echo "Usage: $0 VERSION RELEASE_DATE"
  echo ""
  echo "Example: $0 78.4.3 2020-11-11"
  exit 1
fi

VERSION="$1"
RELEASE_DATE="$2"
PACKAGE=thunderbird
PLATFORM=linux-x86_64
BASE_URL="https://archive.mozilla.org/pub/$PACKAGE/releases/$VERSION"
SOURCES_FILE="$PACKAGE-sources.json"
APPDATA_FILE="org.mozilla.Thunderbird.appdata.xml"

# check provided release date
if ! [[ "$RELEASE_DATE" =~ ^20[0-9]{2}-(0[0-9]|1[0-2])-([0-2][0-9]|3[01])$ ]]; then
  echo >&2 "Invalid release date '$RELEASE_DATE'. Please provide the date in the format YYYY-MM-DD, e.g. 2021-01-28."
  exit 1
fi

# write new sources file
echo '[' >"$SOURCES_FILE"

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

    cat >>"$SOURCES_FILE" <<EOT
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
echo -e "$source_archive\n]" >>"$SOURCES_FILE"

# update releases in appdata file
sed -ri 's@^(\s+<release version=")[^"]+(" date=")[^"]+("/>)$@'"\1$VERSION\2$RELEASE_DATE\3@" "$APPDATA_FILE"

cat <<EOT
The files were successfully updated to version $VERSION.

You can commit the result by executing the following command:
git commit --message='Update to $VERSION' -- '$SOURCES_FILE' '$APPDATA_FILE'
EOT

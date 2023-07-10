#!/bin/bash
set -eo pipefail

PACKAGE=thunderbird
PLATFORM=linux-x86_64
BASE_URL="https://archive.mozilla.org/pub/$PACKAGE/releases/"
VERSION="$(grep --fixed-strings "\"url\": \"$BASE_URL" org.mozilla.Thunderbird.json | cut -d/ -f7)"
BASE_URL+="$VERSION"

OUTPUT_FILE="$PACKAGE-sources.json"

declare -a sources

# read files from SHA256SUMS file
while read -r line; do
  checksum="${line%%  *}"
  path="${line#*  }"

  # strip directories and .xpi extension
  locale="${path##*/}"
  locale="${locale%.*}"

  sources+=(
    "$(
      cat - <<EOT

    {
        "type": "file",
        "url": "$BASE_URL/$path",
        "sha256": "$checksum",
        "dest": "langpacks/",
        "dest-filename": "langpack-$locale@$PACKAGE.mozilla.org.xpi",
        "x-checker-data": {
            "type": "json",
            "parent-id": "thunderbird-base",
            "version-query": "if \$parent.new.version != null then \$parent.new.version else \$parent.current.url | match(\"/(\\\\\\\d+(\\\\\\\.\\\\\\\d+)*)/\").captures[0].string end",
            "url-query": "\"https://archive.mozilla.org/pub/thunderbird/releases/\" + \$version + \"/$path\""
        }
    }
EOT
    )"
  )
done < <(curl -Ss "$BASE_URL/SHA256SUMS" | grep "^\S\+  $PLATFORM/xpi/")

# write to file
printf -v joined '%s,' "${sources[@]}"

cat > "$OUTPUT_FILE" <<EOT
[${joined%,}
]
EOT

#!/usr/bin/env bash

for i in ar ast be bg bn-BD br ca cs cy da de dsb el en-GB en-US es-AR es-ES et eu fr fi fy-NL ga-IE gd gl he hr hsb hu hy-AM id is it ja kab ko lt nb-NO nn-NO pa-IN pl pt-BR pt-PT rm ro ru si sk sl sq sr sv-SE ta-LK tr uk vi zh-CN zh-TW ; do
    wget -q https://download-origin.cdn.mozilla.net/pub/thunderbird/releases/52.9.0/linux-x86_64/xpi/${i}.xpi
    filesize=$(du -b ${i}.xpi | sed -e 's/\t\w*.*//g')
    checksum=$(sha256sum ${i}.xpi | sed -e 's/\ \w*.*//g')
    echo "{
            \"type\": \"extra-data\",
            \"filename\": \"${i}.xpi\",
            \"only-arches\": [
                \"x86_64\"
            ],
            \"url\": \"https://download-origin.cdn.mozilla.net/pub/thunderbird/releases/52.9.0/linux-x86_64/xpi/et.xpi\",
            \"sha256\": \"${checksum}\",
            \"size\": \"${filesize}\"
        },"
    rm ${i}.xpi

done

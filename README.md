# org.mozilla.Thunderbird

For installation instructions, please visit app page on flathub at https://flathub.org/apps/details/org.mozilla.Thunderbird

## Known issues:

* In order to use old, non-flatpak Thunderbird profile you need to copy it from `~/.thunderbird` to `~/.var/app/org.mozilla.Thunderbird/.thunderbird`.

* For using GPG extensions like Enigmail you need to set (it may need sudo) #4: `flatpak override --filesystem=~/.gnupg org.mozilla.Thunderbird`.

* For language support other than English you need to download and install it manually from https://addons.thunderbird.net/en-US/thunderbird/language-tools/ #3 .

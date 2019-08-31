# org.mozilla.Thunderbird (aka net.thunderbird.Thunderbird)

[Thunderbird](https://www.thunderbird.net/) for [Flatpak](https://flatpak.org/) installation instructions are available by [clicking here to visit the Thunderbird app page on Flathub](https://flathub.org/apps/details/org.mozilla.Thunderbird).

## Known issues:

* In order to use an old, non-[Flatpak](https://flatpak.org/) [Thunderbird profile](https://support.mozilla.org/kb/profiles-where-thunderbird-stores-user-data) you need to copy it from<br>
`~/.thunderbird`<br>
to<br>
`~/.var/app/org.mozilla.Thunderbird/.thunderbird`

* [#4](https://github.com/flathub/org.mozilla.Thunderbird/issues/4)
To use [GPG](https://gnupg.org/) extensions like the [Enigmail add-on](https://addons.thunderbird.net/addon/enigmail/) you need to set (may require `sudo`)<br>
`flatpak override --filesystem=~/.gnupg org.mozilla.Thunderbird`

* [#3](https://github.com/flathub/org.mozilla.Thunderbird/issues/3)
Support for languages other than `English (US)` will require them to be manually downloaded and installed from<br>
https://addons.thunderbird.net/language-tools/

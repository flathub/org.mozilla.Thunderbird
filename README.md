# Thunderbird (Flathub)
org.mozilla.Thunderbird (aka net.thunderbird.Thunderbird)

[Thunderbird](https://www.thunderbird.net/) for [Flatpak](https://flatpak.org/) installation instructions are available by [clicking here to visit the Thunderbird app page on Flathub](https://flathub.org/apps/details/org.mozilla.Thunderbird).

## Known issues:

#### Old profile
To use an old, non-[Flatpak](https://flatpak.org/) [Thunderbird profile](https://support.mozilla.org/kb/profiles-where-thunderbird-stores-user-data) copy it from<br>
`~/.thunderbird`<br>
to<br>
`~/.var/app/org.mozilla.Thunderbird/.thunderbird`

In case Thunderbird opens a new profile instead of the old one, run:<br>
`flatpak run org.mozilla.Thunderbird -P`<br>
then select the old profile and tick "*Use the selected profile without asking on startup*" box.

#### Language support
([#3](https://github.com/flathub/org.mozilla.Thunderbird/issues/3)) Only `English (US)` is enabled by default. In order to switch to language that matches one from your system, you need to download language file in `.xpi` format from:<br>
https://addons.thunderbird.net/language-tools/ or <br>
http://ftp.mozilla.org/pub/thunderbird/releases/68.1.1/linux-x86_64/xpi/ <br>
then navigate to<br>
[Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Tools` > `Add-ons` > `Extensions` > `Install Add-on From File`<br>
and choose previously downloaded `.xpi` file. You may repeat the same with dictionaries. You need to restart app in order to make changes effective.

Note that Calendar extension won't be localized.

#### New mail notifications
([#11](https://github.com/flathub/org.mozilla.Thunderbird/issues/11#issuecomment-531987872)) To enable new mail notifications:<br>
1. [Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Edit` > `Preferences` > `Advanced` > `General` > `Config Editor…`, set `mail.biff.use_system_alert` to `true` (default)<br>
1. [Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Edit` > `Preferences` > `General` > Select `Customize…` for "Show an alert" and set "Show New Mail alert for:"

([#79](https://github.com/flathub/org.mozilla.Thunderbird/issues/79#issuecomment-534298255)) Alternatively you may set `mail.biff.use_system_alert` to `false` which will make notifications non-native but clicking on them will open mail in Thunderbird.

#### GPG extension support
([#4](https://github.com/flathub/org.mozilla.Thunderbird/issues/4)) To use [GPG](https://gnupg.org/) extensions like the [Enigmail add-on](https://addons.thunderbird.net/addon/enigmail/) set (may require `sudo`)<br>
`flatpak override --filesystem=~/.gnupg org.mozilla.Thunderbird`

#### Wayland
([#75](https://github.com/flathub/org.mozilla.Thunderbird/issues/75)) To enable the experimental [Wayland](https://wayland.freedesktop.org/) backend (assuming the desktop session runs under a Wayland) set (may require `sudo`)<br>
`flatpak override --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.Thunderbird`

#### Smartcard
([#51](https://github.com/flathub/org.mozilla.Thunderbird/issues/51)) For Smartcard support you need at least Flatpak 1.3.2.

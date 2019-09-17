# Thunderbird (Flathub)
org.mozilla.Thunderbird (aka net.thunderbird.Thunderbird)

[Thunderbird](https://www.thunderbird.net/) for [Flatpak](https://flatpak.org/) installation instructions are available by [clicking here to visit the Thunderbird app page on Flathub](https://flathub.org/apps/details/org.mozilla.Thunderbird).

## Known issues:

#### Profile
To use a non-[Flatpak](https://flatpak.org/) [Thunderbird profile](https://support.mozilla.org/kb/profiles-where-thunderbird-stores-user-data) copy it from<br>
`~/.thunderbird`<br>
to<br>
`~/.var/app/org.mozilla.Thunderbird/.thunderbird`

#### Language support
[#3](https://github.com/flathub/org.mozilla.Thunderbird/issues/3)<br>
`English (US)` is supported by default. Manually download and install other languages from<br>
https://addons.thunderbird.net/language-tools/

#### New mail notifications
[#11](https://github.com/flathub/org.mozilla.Thunderbird/issues/11#issuecomment-531987872)<br>
To enable new mail notifications:<br>
1. [Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Edit` > `Preferences` > `Advanced` > `General` > `Config Editor…`, set `mail.biff.use_system_alert` to `true` (default)<br>
1. [Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Edit` > `Preferences` > `General` > Select `Customize…` for "Show an alert" and set "Show New Mail alert for:"

#### GPG extension support
[#4](https://github.com/flathub/org.mozilla.Thunderbird/issues/4)<br>
To use [GPG](https://gnupg.org/) extensions like the [Enigmail add-on](https://addons.thunderbird.net/addon/enigmail/) set (may require `sudo`)<br>
`flatpak override --filesystem=~/.gnupg org.mozilla.Thunderbird`

#### Wayland
To enable the experimental [Wayland](https://wayland.freedesktop.org/) backend (assuming the desktop runs under a Wayland session) set  (may require `sudo`)<br>
`flatpak override --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.Thunderbird`

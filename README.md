# Thunderbird (Flathub)
org.mozilla.Thunderbird (aka net.thunderbird.Thunderbird)

[Thunderbird](https://www.thunderbird.net/) for [Flatpak](https://flatpak.org/) installation instructions are available by [clicking here to visit the Thunderbird app page on Flathub](https://flathub.org/apps/details/org.mozilla.Thunderbird).

## Known issues:
Non flatpak-packaging issues should be reported upstream at<br>
https://bugzilla.mozilla.org/describecomponents.cgi?product=Thunderbird

#### Old profile
To use an old, non-[Flatpak](https://flatpak.org/) [Thunderbird profile](https://support.mozilla.org/kb/profiles-where-thunderbird-stores-user-data) copy it from<br>
`~/.thunderbird`<br>
to<br>
`~/.var/app/org.mozilla.Thunderbird/.thunderbird`

In case Thunderbird opens a new profile instead of the old one, run:<br>
`flatpak run org.mozilla.Thunderbird -P`<br>
then select the old profile and tick "*Use the selected profile without asking on startup*" box.

#### Language support
([#3](https://github.com/flathub/org.mozilla.Thunderbird/issues/3)) All supported locales are available in `org.mozilla.Thunderbird.Locale` extension. One locale that matches host OS locale will be installed and selected by default. For instructions about how to enable more locales in flatpak take a look at https://flatpak.readthedocs.io/en/latest/flatpak-command-reference.html#flatpak-config

([#90](https://github.com/flathub/org.mozilla.Thunderbird/issues/90)) Dictionaries availabiity is similar as for locales. They also could be downloaded manually from:<br>
https://addons.thunderbird.net/language-tools/<br>
and installed through:<br>
[Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Tools` > `Add-ons` > `Extensions` > `Install Add-on From File`<br>
You may need to restart app in order to make changes effective.

([#88](https://github.com/flathub/org.mozilla.Thunderbird/issues/88)) Note that Calendar extension is not localized and available only in *English (US)*. For localized version you may remove bundled extension and install localized one from:<br>
https://addons.thunderbird.net/thunderbird/addon/lightning/

#### New mail notifications
([#11](https://github.com/flathub/org.mozilla.Thunderbird/issues/11#issuecomment-531987872)) To enable new mail notifications:<br>
1. [Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Edit` > `Preferences` > `Advanced` > `General` > `Config Editor…`, set `mail.biff.use_system_alert` to `true` (default)<br>
1. [Menu Bar](https://support.mozilla.org/kb/display-thunderbird-menus-and-toolbar) > `Edit` > `Preferences` > `General` > Select `Customize…` for "Show an alert" and set "Show New Mail alert for:"

([#79](https://github.com/flathub/org.mozilla.Thunderbird/issues/79#issuecomment-534298255)) Alternatively you may set `mail.biff.use_system_alert` to `false` which will make notifications non-native but clicking on them will open mail in Thunderbird.

#### Wayland
([#75](https://github.com/flathub/org.mozilla.Thunderbird/issues/75)) To enable the experimental [Wayland](https://wayland.freedesktop.org/) backend (assuming the desktop session runs under a Wayland) set:<br>
`flatpak override --user --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.Thunderbird`

#### Smartcard
([#51](https://github.com/flathub/org.mozilla.Thunderbird/issues/51)) For Smartcard support you need at least Flatpak 1.3.2.

# Gaz's Framework optmized Areo Rice.
Installed on Fedora42 Designed for Framework 13 Laptops with the 2.8k 120Hz display. 
Display is configrued for the full feature set and is able to be changed while in the DE just need to reload Hyprlan.


This is diinky's frutiger aero themed rice, She will likely update it with time(Her words not mine); so you can head over to the releases page for more concrete versions. diinky made a video of this rice, which you can watch here:
https://www.youtube.com/watch?v=Tx9dHc0MyHs

![alt text](./wallpapers/aquarium.png)

# Installation Steps 🖥️

You need to install the following dependencies on your system:

- `eww` for widgets
- `hyprland` the tiling window manager
- `caja` the file explorer
- `waybar` the taskbar
- `wofi` the application launcher/spotlight like search.
- diinky uses the `kitty` terminal, but you can use whichever terminal emulator that you are comfortable with. ( I did biuld on that)

On arch, you can install some of the above with `sudo pacman -S hyprland caja waybar wofi kitty`, installing `eww` has to
be done separately, easiest way is from the AUR with yay.

To install, copy all the folders in the `config` directory, to the `~/.config` directory on your system; make sure to backup your previous configs if you have them.

The `.config` directory is where most applications will store their config files.

You will need to make edits to config files, as not all configs are drag & drop But these are ment for Framework Laptops, the files are commented in
order to help.

## Weather Widget ☁️

The weather widget uses `openweathermap.org` as a backend. They give you 2000 free api calls / day, which is more than enough.

You need to create an account there, get an API key, and then edit
the `eww/scripts/weather.sh` file with the following details. I've commented more specific instructions in that bash file.

The bash file stores the weather data in `~/.cache/eww/weather` every time `weather.sh --getdata` is called; as such, I recommend creating a
cronjob for calling `~/.config/eww/scripts/weather.sh --getdata` every 30 minutes.

## GTK theme & Icon Pack 🖌️

To install the icon theme, copy the `crystal-remix-icon-theme-diinki-version` directory in `IconTRheme` to your `~/.local/share/icons` or `/usr/share/icons` directories
and then set the theme to the one in use either with `gsettings` or the `dconf` applications; which you can download with most linux package managers.

To install the GTK theme, copy the `diinki-aero` folder in `GTKTheme` to your `~/.themes` directory,
and then set the GTK theme to "diinki-aero" with either `gsettings` or the `dconf` application.

# The Default Keybinds ⌨️

You can edit the keybinds in the hyprland config file as needed to match your preference, by default the most important ones:

# start terminal
bind = $mainMod, Return, exec, $terminal
# Kill current focused application
bind = $mainMod, Q, killactive,
# Take screenshot of area, MUST HAVE HYPRSHOT INSTALLED!
bind = $mainMod SHIFT, S, exec, hyprshot --mode region --output-folder /tmp
# Open file manager (I prefer caja).
bind = $mainMod, E, exec, $fileManager
# Toggle focused window to be floating or tiled.
bind = $mainMod SHIFT, SPACE, togglefloating
# Toggle focused window to full-screen view.
bind = $mainMod, F, fullscreen
# Toggle application launcher (I prefer wofi).
bind = $mainMod, D, exec, $menu
# Restart hyprland and go back to gdm
bind = $mainMod SHIFT, R, exec, hyprctl reload 
# Exit Hyprland and return to GDM
bind = $mainMod SHIFT, Q, exit
# Launch Visual Studio Code
bind = $mainMod, V, exec, code
# Systemctl suspend
bind = $mainMod, -, exec, systemctl suspend
# Lock on lid open
bind =,switch:on:Lid Switch, exec, hyprlock
# Lock lid on close
bind =,switch:off:Lid Switch, exec, systemctl suspend
# Hyprlock
bind = $mainMod, L, exec, hyprlock

# Updates & Changes

Aspects and components of this rice will change with time, until diinky has a finalized design, she'll make specific releases on the github releases page.
I have changed the spacing aound the border of all things to 5px bc I need the extra space. Added Chao and Lain gif instead of Pokemon. Changed Gif spacing. Added Power Profiles to Waybar. Added Memory Use in waybar. Changed Networking Icons to work for me. Changed Sound Icons for the network speed indicator. I added a config to kitty that was not in the orginal repo but something was configered in the Video by diinky

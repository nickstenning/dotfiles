
    ln -s $HOME/.xkb/symbols/custom /usr/share/X11/xkb/symbols/custom

Edit the "evdev" rules file

    sudo vim /usr/share/X11/xkb/rules/evdev

Find the line which looks like

    ! option	=	symbols

At the end of the stanza, add an option for each named remapping in your symbols
file, e.g.

    custom:shift_ctrl	=	+custom(shift_ctrl)

Reconfigure xkb-data

    sudo dpkg-reconfigure xkb-data

Finally, add the relevant option to dconf

    dconf write /org/gnome/desktop/input-sources/xkb-options "['custom:shift_ctrl']"

Check that worked

    dconf read /org/gnome/desktop/input-sources/xkb-options

Yay! Finally, you can logout and log back in again.

To get the same map on the console...


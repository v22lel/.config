-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart


hl.on("hyprland.start", function ()
--	hl.exec_cmd("better-control --deamon")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("swaybg -i ~/Pictures/wallpaper/bg.jpeg")
	hl.exec_cmd("quickshell")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("xhost +SI:localuser:root")
    hl.dsp.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.dsp.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

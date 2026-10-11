-- Generic floating position
hl.window_rule({ match = { float = true }, persistent_size = true })


hl.window_rule({
    match             = { class = "^(better_control.py)$" },
    float             = true,
    keep_aspect_ratio = true,
    pin               = true,
})

-- Picture-in-Picture
hl.window_rule({
    match             = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float             = true,
    keep_aspect_ratio = true,
    size              = { "max(monitor_w, monitor_h)*0.25", "min(monitor_w, monitor_h)*0.25" },
    pin               = true,
})

-- Apps
hl.window_rule({ match = { class = "^(.*[Ll]auncher.*)$" }, float = true, monitor = PRIMARY_MONITOR })

hl.window_rule({ match = { class = "^(.*swash)$", title = "^(Swash)$" }, min_size = { "max(monitor_w, monitor_h)*0.35", "min(monitor_w, monitor_h)*0.35" }, float = true })

-- Opacity Overrides
local terminals = "^(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)$"

hl.window_rule({ match = { class = "^(firefox|zen)$" }, opacity = "1.0 override" })
hl.window_rule({ match = { class = terminals }, opacity = "1.0 override" }) -- Override opacity in favor of terminal settings for opacity. If your terminal doesn't support transparency, you can remove this rule.

-- Float Utility Windows
local floatApps = {
    { class = "^(kvantummanager|qt[56]ct|nwg-look)$" },
    { class = "^(org.pulseaudio.pavucontrol|blueman-manager|nm-applet|nm-connection-editor)$" },
    { title = "^(Winetricks.*|Protontricks.*)$" },
    { class = "org.gnome.FileRoller" },
    { class = "qalculate-gtk" },
    { class = "thunar" },
}
for _, m in ipairs(floatApps) do hl.window_rule({ match = m, float = true }) end

-- Float Common Modals
local modalMatches = {
    { title = "^(Open|Authentication Required|Add Folder to Workspace|Choose Files|Save As|Confirm to replace files|File Operation Progress)$" },
    { initial_title = "^(Open File)$" },
    { class = "^([Xx]dg-desktop-portal-gtk)$" },
    { title = "^(File Upload|Choose wallpaper|Library)(.*)$" },
    { class = "^(.*dialog.*)$" },
    { title = "^(.*dialog.*)$" },
    { class = "^(hyprland-share-picker)$"},
}
for _, m in ipairs(modalMatches) do hl.window_rule({ match = m, float = true }) end

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

--DO NOT TOUCH
hl.on("window.open", function(w)
    if (w.class == "jetbrains-toolbox") then
        hl.timer(function()
            --hl.notification.create({ text = "jb move", timeout = 5000 })
            local ws = hl.get_active_workspace().id
            hl.dispatch(hl.dsp.window.move({
                window = w,
                workspace = "name:discord"
            }))
            hl.dispatch(hl.dsp.window.move({
                window = w,
                workspace = ws
            }))
        end, { timeout = 100, type = "oneshot" })
    end
end)

hl.window_rule({
    name = "control_center",
    match = { class = "dev.v22.ControlCenter" },
    float = true,
    size = { 320, 320 },
    move = { "(monitor_w-" .. (320+45) .. ")", "60" },
    pin = true,
    focus_on_activate = true,
    border_size = 0,
    no_shadow = true,
    opacity = "1.0 override",
})
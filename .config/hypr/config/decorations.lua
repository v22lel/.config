-- Look and feel configuration

require("./config/variables")

hl.config({
    general = {
        gaps_in = GAP_IN,
        gaps_out = GAP_OUT,

        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = {
                colors = { COL_MAIN, COL_MAIN },
                angle = 45,
            },
            inactive_border = COL_SEC,
        },
    },
    group = {
        col = {
            border_active = CACHYLBLUE,
            border_inactive = CACHYGRAY,
            border_locked_active = CACHYDBLUE,
            border_locked_inactive = CACHYGRAY,
        },
        groupbar = {
            col = {
                active = CACHYLGREEN,
                inactive = CACHYGRAY,
                locked_active = CACHYDBLUE,
                locked_inactive = CACHYGRAY,
            },
        },
    },
    decoration = {
        dim_special = 0.3,
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1,
        blur = {
            size = 5,
            passes = 4,
            special = true,
        },
    },
})

hl.workspace_rule({
    workspace = "m[" .. MONITOR2 .. "]",
    gaps_out = {
        left = GAP_OUT,
        right = GAP_OUT,
        bottom = GAP_OUT,
        top = 0
    }
})
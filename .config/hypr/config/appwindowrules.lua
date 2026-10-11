--firefox
hl.window_rule({
	match = { class = "firefox" },
	workspace = "name:firefox"
})

hl.bind(mainMod .. " + ALT + W", hl.dsp.focus({ workspace = "name:firefox" }))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(BROWSER))


--discord
hl.window_rule({
	match = { class = "discord" },
	workspace = "name:discord"
})

hl.bind(mainMod .. " + ALT + D", hl.dsp.focus({ workspace = "name:discord" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord"))

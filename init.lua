local file_types = require "textadept.file_types"
local run = require "textadept.run"
file_types.extensions.be = "berry"
run.run_commands = {be='berry "%f"'}

ui.set_theme(CURSES and "term" or "monokai-dark", {
	font = "Source Code Pro Medium",
	fontsize = 12,
})


# Berry Textadept support

![screenshot](https://raw.githubusercontent.com/sodomon2/textadept-berry/master/screenshot.png)

## Install

To install, copy `lexers/berry.lua` to a `lexers` directory in your local
textadept directory (usually `.textadept`). or execute `make install` to install for all users


Update your `init.lua`:

```lua
-- enable the lexer and run module
local file_types = require "textadept.file_types"
local run = require "textadept.run"
file_types.extensions.be = "berry"
run.run_commands = {be='berry "%f"'}

-- enable the theme, with a custom font (optional)
ui.set_theme(CURSES and "term" or "monokai-dark", {
	font = "Source Code Pro Medium",
	fontsize = 12,
})
```
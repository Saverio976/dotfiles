local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.font = wezterm.font('CaskaydiaMono Nerd Font')
config.font_size = 15.0

config.colors = {
    foreground = "#b9c0cb",
    background = "#282c34",
    cursor_bg = "#ffcc00",
    cursor_border = "#ffcc00",
    cursor_fg = "#282c34",
    selection_bg = "#b9c0ca",
    selection_fg = "#272b33",

    ansi = {
        "#41444d",
        "#fc2f52",
        "#25a45c",
        "#ff936a",
        "#3476ff",
        "#7a82da",
        "#4483aa",
        "#cdd4e0"
    },

    brights = {
        "#8f9aae",
        "#ff6480",
        "#3fc56b",
        "#f9c859",
        "#10b1fe",
        "#ff78f8",
        "#5fb9bc",
        "#ffffff"
    },
}

return config

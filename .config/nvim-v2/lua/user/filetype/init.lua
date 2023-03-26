
local filetype = require("filetype")
filetype.setup({
    overrides = {
        extensions = {
            h = "c",
            hpp = "cpp",
            v = "v",
        }
    }
})

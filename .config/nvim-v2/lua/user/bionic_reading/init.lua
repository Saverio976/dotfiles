local bionic_reading = require("bionic-reading")
bionic_reading.setup({
    auto_highlight = true,
    file_types = {
        ["text"] = {
            "any",
        },
        ["markdown"] = {
            "any",
        },
        ["lua"] = {
            "comment",
        },
        ["python"] = {
            "comment",
        },
        ["cpp"] = {
            "comment",
        },
        ["c"] = {
            "comment",
        },
    },
    update_in_insert_mode = false,
})

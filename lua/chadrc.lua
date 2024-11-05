local M = {}

M = {
    base46 = {
        theme = "onedark",
        transparency = false
    },
    ui = {
        tabufline = {
            enable = true,
            lazyload = false,
            order = { "treeOffset", "buffers", "tabs", "btns" },
            modules = nil
        },
        cmp = {
            enable = true,
            lazyload = false,
            lspkind_text = true,
            style = "default", 
            format_colors = {
                tailwind = false,
            },
        }
    }
}

return M

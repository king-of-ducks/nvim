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
            lspkind_text = true,
            style = "atom_colored",
            format_colors = { tailwind = false }
        }
    },
    colorify = {
        enabled = true,
        mode = "bg", -- fg, bg, virtual
        virt_text = "󱓻 ",
        highlight = { hex = true, lspvars = true },
    }
}

return M

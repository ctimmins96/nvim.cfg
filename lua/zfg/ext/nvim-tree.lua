-- imports
local g = require("zfg.binds").g
local nmap = require("zfg.binds").nmap

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- Mappings
    nmap { "t", api.tree.toggle, opts("Toggle") }
    nmap { "?", api.tree.toggle_help, opts("Help") }
    nmap { "u", api.tree.change_root_to_parent, opts("Up") }
end

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    on_attach = "default",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

-- Global Keymaps
nmap { "<leader>nt", require("nvim-tree.api").tree.toggle, "Toggle Nvim-Tree"}
nmap { "<leader>nf", require("nvim-tree.api").tree.focus, "Focus Nvim-Tree" }


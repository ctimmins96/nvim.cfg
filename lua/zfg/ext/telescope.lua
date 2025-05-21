require('telescope').setup {
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
    },
}

local builtin = require("telescope.builtin")
local nmap = require("zfg.binds").nmap

nmap { '<leader>sf', function()
    builtin.find_files({ hidden = true })
end, { desc = "Telescope-[S]earch [F]iles" }}
nmap { "<leader>sg", builtin.git_files, { desc = "Telescope-[S]earch [G]it Files" }}
nmap { "<leader>sh", builtin.help_tags, { desc = "Telescope-[S]earch [H]elp"}}
nmap { "<leader>sm", builtin.keymaps, { desc = "Telescope-[S]earch Key[m]aps"}}
nmap { "<leader>sd", builtin.diagnostics, { desc = "Telescope-[S]earch [D]iagnostics"}}
nmap { "<leader>sp", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = "Telescope-Grep_String" }}


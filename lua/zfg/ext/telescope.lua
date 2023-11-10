local builtin = require("telescope.builtin")
local nmap = require("zfg.binds").nmap

nmap { '<leader>sf', builtin.find_files, { desc = "Telescope-Find_Files" }}
nmap { "<leader>sg", builtin.git_files, { desc = "Telescope-Git_Files" }}
nmap { "<leader>sp", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = "Telescope-Grep_String" }}

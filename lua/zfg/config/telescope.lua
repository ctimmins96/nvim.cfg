local builtin = require("telescope.builtin")
local nmap = require("zfg.binds").nmap

nmap { '<leader>sf', builtin.find_files, { }}
nmap { "<leader>sg", builtin.git_files, { }}
nmap { "<leader>sp", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end}

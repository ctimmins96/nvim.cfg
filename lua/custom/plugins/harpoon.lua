-- Imports
local helper = require('zfg_logger').new('Harpoon')

-- Functions
local function gh(repo) return 'https://github.com/' .. repo end

-- Plugin Setup
vim.pack.add { gh("theprimeagen/harpoon") }

helper:debg('Invoking Setup...')

require("harpoon").setup({
    save_on_toggle = true,
    save_on_change = true,
    tabline = false,
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

helper:debg('Setting Keymaps...')

vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon - Add File' })
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Harpoon - Toggle Quick-Menu'})

for i = 1,10 do
    vim.keymap.set('n', "<leader>"..(i%10), function() ui.nav_file(i) end, { desc = 'Harpoon - Goto File '.. i })
end

-- Dummy Configuration
local get_marks = function()
    local contents = "Marked Files: "
    for idx = 1,mark.get_length() do
        local file = mark.get_marked_file_name(idx)
        if file == "" then
            file = "[None]"
        else
            -- Find Last index of '/'
            local s_i = 0
            while (string.find(file, "/", s_i) ~= nil) do
                s_i = string.find(file, "/", s_i) + 1
            end
            file = string.sub(file, s_i, string.len(file))
        end
        contents = contents..file.." | "
    end
    print(contents)
end

vim.keymap.set('n', "<leader>hh", function() get_marks() end)

helper:info('Initialized!')


require("harpoon").setup({
    save_on_toggle = true,
    save_on_change = true,
    tabline = false,
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

for i = 1,10 do
    vim.keymap.set("n", "<leader>"..(i%10), function() ui.nav_file(i) end)
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

vim.keymap.set("n", "<leader>hh", function() get_marks() end)

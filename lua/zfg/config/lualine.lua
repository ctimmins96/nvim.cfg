local lline = require('lualine')

-- Configuration
local buf = {
    'buffers',
    show_filename_only = true,
    hide_filename_extension = false,
    show_modified_status = true,

    mode = 0,
    symbols = {
        modified = ' [󰣙]',
        alternate_file = '󱞩 ',
        directory = ' ',
    },
}

local f_name = {
    'filename',
    file_status = true,
    newfile_status = true,
    path = 0,
    shorting_target = 30,
    symbols = {
        modified = '[󰣙]',
        readonly = '[]',
        unnamed = '[?]',
        newfile = '[󰎔]',
    },
}

local s_count = {
    'searchcount',
    maxcount = 999,
    timeout = 300,
}

lline.setup {
    options = {
        theme = 'horizon',
        component_separators = '󰘧',
        section_separator = { left = '*', right = '*' },
        refresh = {
            statusline = 300,
            tabline = 200,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            f_name,
            s_count
        },
        lualine_x = { 'encoding' },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { f_name },
        lualine_x = { 'location' },
        lualine_y = { buf },
        lualine_z = {},
    },
}

-- Setup
lline.setup()

require('nvim-web-devicons').setup{default = true}

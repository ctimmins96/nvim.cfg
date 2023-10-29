local Bind = {}

function Bind.nmap(tbl)
    vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

function Bind.imap(tbl)
    vim.keymap.set('i', tbl[1], tbl[2], tbl[3])
end

function Bind.xmap(tbl)
    vim.keymap.set('x', tbl[1], tbl[2], tbl[3])
end

function Bind.ismap(tbl)
    vim.keymap.set({"i", "s"}, tbl[1], tbl[2], tbl[3])
end

function Bind.cmd(cmd_str)
    vim.api.nvim_command(cmd_str)
end

function Bind.vcmd(cmd_str)
    vim.cmd(cmd_str)
end

function Bind.so(f_path)
    Bind.cmd(":so "..f_path)
end

function Bind.msg(mes)
    vim.api.nvim_echo({{mes}},true, {})
end

Bind.a = vim.api

return Bind


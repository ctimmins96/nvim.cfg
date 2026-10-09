-- Imports
local fidget = require('fidget')

-- Function Aliases
local echo = fidget.notify

-- Local Variables
local sev_to_hl = {
	trace = 'DiagnosticHint',
	debug = 'Normal',
	info = 'MoreMsg',
	warn = 'WarningMsg',
	error = 'ErrorMsg'
}

local messages = {} ---@type {[1]: string, [2]: string?, [3]: string}[]

---@param ctx string?
---@return string
local function mkpfx(ctx)
	return ctx and string.format('[zfg.logger/%s]', ctx) or '[zfg.logger]'
end

---@class ZfgFidgetHelperModule
---@field trace fun(fmt: string, ...:any)
---@field debg fun(fmt: string, ...:any)
---@field info fun(fmt: string, ...:any)
---@field warn fun(fmt: string, ...:any)
---@field errr fun(fmt: string, ...:any)
local R = {}

local Logger = {}
R.Logger = Logger

---@param ctx any
---@return Logger
function R.new(ctx)
	return setmetatable({ ctx = ctx }, { __index = Logger })
end

---@param m string
---@param ... any
function Logger:trace(m, ...)
	messages[#messages+1] = { 'trace', self.ctx, m:format(...) }
end

---@param m string
---@param ... any
function Logger:debg(m, ...)
	messages[#messages+1] = { 'debg', self.ctx, m:format(...) }
end

---@param m string
---@param ... any
function Logger:info(m, ...)
	local m1 = m:format(...)
	messages[#messages+1] = { 'info', self.ctx, m1 }
	echo(mkpfx(self.ctx) .. ' info: ' .. m1)
end

---@param m string
---@param ... any
function Logger:warn(m, ...)
	local m1 = m:format(...)
	messages[#messages+1] = { 'warn', self.ctx, m1 }
	echo(mkpfx(self.ctx) .. ' warn: ' .. m1)
end

---@param m string
---@param ... any
function Logger:errr(m, ...)
	local m1 = m:format(...)
	messages[#messages+1] = { 'errr', self.ctx, m1 }
	echo(mkpfx(self.ctx) .. ' errr: ' .. m1)
end

local noctx_logger = R.new()

setmetatable(R, {
	__index = function(t, k)
		t[k] = function(...)
			return noctx_logger[k](noctx_logger, ...)
		end
		return t[k]
	end,
})

function R.show()
	for _, l in ipairs(messages) do
		local sev, ctx, msg = l[1], l[2], l[3]
		local hl = sev_to_hl[sev]
		local text = ctx and string.format('%s(%s}: %s', sev, ctx, msg)
			or string.format('%s: %s', sev, msg)
		vim.api.nvim_echo({ { text, hl } }, false, {})
	end
end

return R


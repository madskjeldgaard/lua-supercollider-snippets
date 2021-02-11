local utils = require'supercollider-snippets.utils'
local M = {}

function M.pseq(len)
	local t = utils.rand_var_list(len, "[", 1)
	utils.wrap_in_pat(t, "Pseq")
	return t
end

function M.prand(len)
	local t = utils.rand_var_list(len, "[", 1)
	utils.wrap_in_pat(t, "Prand")
	return t
end

function M.pshuf(len)
	local t = utils.rand_var_list(len, "[", 1)
	utils.wrap_in_pat(t, "Pshuf")
	return t
end

function M.pxrand(len)
	local t = utils.rand_var_list(len, "[", 1)
	utils.wrap_in_pat(t, "Pxrand")
	return t
end

function M.pwrand(len)
	local t = utils.rand_var_list(len, "[", 1)
	local probabilities = utils.rand_var_list(len, "[", len+1)
	table.insert(t, ", ")
	utils.append_table(t, probabilities)
	table.insert(t, ".normalizeSum")

	utils.wrap_in_pat(t, "Pwrand")
	return t
end

return M

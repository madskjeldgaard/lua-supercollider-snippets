local utils = require'supercollider-snippets.utils'
local M = {}

function M.pseq(len, type, offset)
	offset = offset or 0
	local t = utils.rand_var_list(len, "[", offset, type)
	utils.wrap_in_pat(t, "Pseq")
	return t
end

function M.prand(len, type, offset)
	offset = offset or 0
	local t = utils.rand_var_list(len, "[", 1, type, offset)
	utils.wrap_in_pat(t, "Prand")
	return t
end

function M.pshuf(len, type, offset)
	offset = offset or 0
	local t = utils.rand_var_list(len, "[", 1, type, offset)
	utils.wrap_in_pat(t, "Pshuf")
	return t
end

function M.pxrand(len, type, offset)
	offset = offset or 0
	local t = utils.rand_var_list(len, "[", 1, type, offset)
	utils.wrap_in_pat(t, "Pxrand")
	return t
end

function M.pwrand(len, type, offset)
	offset = offset or 0
	local t = utils.rand_var_list(len, "[", 1, type, offset)
	local probabilities = utils.rand_var_list(len, "[", len+1+offset)
	utils.insert_comma(t)
	utils.append_table(t, probabilities)
	table.insert(t, ".normalizeSum")

	utils.wrap_in_pat(t, "Pwrand")
	return t
end

function M.pseg(len, type, offset)
	offset = offset or 0
	len = len+offset
	local t = M.pseq(len, type)
	local times = M.pseq(len-1, 'i', len+1)
	utils.insert_comma(t)
	utils.append_table(t, times)
	utils.insert_comma(t)
	local curve = utils.var(len + len + 2, "\\lin", true)
	table.insert(t, curve)
	utils.wrap_in_pat(t, "Pseg")
	return t
end

return M

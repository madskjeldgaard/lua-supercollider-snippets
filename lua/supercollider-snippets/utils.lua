local M = {}

function M.append_table(table1, table2)
	for _,v in pairs(table2) do
		table.insert(table1, v)
	end
end

-- Check if string ends with something
local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

-- Basename of file (without suffix)
function M.get_basename()
	return vim.fn.expand("%:t:r")
end

-- Filename
function M.get_filename()
	return vim.fn.expand("%:t")
end

-- First letter capitalized in string
function M.capitalize(str)
	return str:gsub("^%l", string.upper)
end

-- Basename capitalized
function M.capitalized_base()
	return M.capitalize(M.get_basename())
end

-- Add newline
function M.nl(s)
	if type(s) == "table" then
		return s.v .. "\n"
	elseif type(s) == "string" then
		return s .. "\n"
	else
		return nil
	end
end

-- Add tab
function M.t(s)
	if type(s) == "table" then
		return "\t" .. s.v
	elseif type(s) == "string" then
		return "\t" .. s
	else
		return nil
	end
end

-- Create a snippets.nvim variable
function M.var(order, default, is_input, id, transform)
	local var = {
		order = order,
		id = id or order,
		default = default or "",
		is_input = is_input or false,
		transform = transform or function(context) return context.v end,
	}
	return var
end

-- Wrap a table in (), {} or []
function M.wrap_table_in(t, wrapperChar)

	-- Prefix
	if wrapperChar == "{" then
		table.insert(t, 1, "{")
		table.insert(t, "}")
	elseif wrapperChar == "[" then
		table.insert(t, 1, "[")
		table.insert(t, "]")
	elseif wrapperChar == "(" then
		table.insert(t, 1, "(")
		table.insert(t, ")")
	end

	return t
end

-- Create list of random variables
-- Offset is used to offset the variable numbers
function M.rand_var_list(maxLen, wrapListIn, offset)
	local t = {}

	for i=1, maxLen do
		local val = math.random()
		local is_input = true
		local numDecimals = 2

		offset = offset or 0
		local transform = function(sn)
			if ends_with(sn.v, "r") then
				local var = sn.v:sub(1,-2)

				return "Rest(" .. var .. ")"
			else
				return sn.v
			end
		end

		local index = i + offset
		local item = M.var(
			index,
			string.format("%." .. numDecimals .. "f", val),
			is_input,
			string.format("item %i", index),
			transform
		)
		table.insert(t, item)

		-- No comma at end of list
		if i ~= maxLen then
			table.insert(t, ", ")
		end
	end

	if wrapListIn ~= nil then
		M.wrap_table_in(t, wrapListIn)
	end

	return t
end

-- Wrap a table in a pattern (that is with a class prefixed and a repeats argument)
function M.wrap_in_pat(t, patternClass)
	table.insert(t, 1, string.format("%s(", patternClass))

	local repeats = M.var(1, "inf", true, "repeats",
		function(sn)
			if sn.v ~= nil then
				return ", " .. sn.v
			else
				return sn.v
			end
		end
	)

	table.insert(t, repeats)
	table.insert(t, ")")
end
return M

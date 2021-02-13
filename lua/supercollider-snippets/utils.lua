local sniputils = require'snippets.utils'
local M = {}
--
-- Check if string ends with something
local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end


-- Append table to end of table
function M.append_table(table1, table2)
	for _,v in pairs(table2) do
		table.insert(table1, v)
	end
end

-- Insert comma into table
-- A global setting controls wether it should be followed by a newline
local newline = vim.g.supercollider_snippet_comma_newline or 1
function M.insert_comma(table1)
	local comma
	if newline == 1 then
		comma = "," .. "\n"
	else
		comma = ","
	end

	table.insert(table1, comma)
end

function M.indented(str)
	local line = vim.api.nvim_get_current_line()
	local indent = line:match("^%s+") or ""
	local cursor = vim.api.nvim_win_get_cursor(0)
	local pos_on_line = cursor[2]

	-- if ends_with(line, "%S") then
		return indent .. str
	-- else
		-- return str
	-- end
end

function M.print_all()
	print("These are the supercollider snippets available. Type the name and expand")
	print("---")
	for k,_ in pairs(require'supercollider-snippets') do
		print(k)
	end
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
function M.rand_var_list(maxLen, wrapListIn, offset, type)
	local t = {}

	for i=1, maxLen do
		local is_input = true
		local numDecimals = 2
		local default = ""

		-- Random float
		if type == "f" then
			local val = math.random()
			default = string.format("%." .. numDecimals .. "f", val)

			-- Random integer
		elseif type == "i" then
			local val = math.random(10)
			default = string.format("%i", val)

			-- Random fraction
		elseif type == "fr" then
			local val = math.random(1,10)
			local div = math.random(1,10)

			-- Make sure val and div are not the same
			while val == div do
				div = math.random(1,10)
			end

			default = string.format("%i/%i", val, div)

			-- Random reciprocal ( eg 1/5, 1/7 etc )
		elseif type =="r" then
			local val = math.random(2,10)
			default = string.format("%i/%i", 1, val)

		else
			-- Default to floats
			local val = math.random()
			default = string.format("%." .. numDecimals .. "f", val)
		end

		offset = offset or 0
		local transform = function(sn)
			local nl = "\t"
			local nl_after = ""

			if i == 1 then
				nl = "\n\t"
			end

			-- if i == maxLen then
			-- 	nl_after = "\n"
			-- end

			if ends_with(sn.v, ",r") then
				local var = sn.v:sub(1,-3)

				return nl .. M.indented("Rest(" .. var .. ")") .. nl_after
			else
				return nl .. M.indented(sn.v) .. nl_after
			end
		end

		local index = i + offset
		local item = M.var(
			index,
			default,
			is_input,
			string.format("item %i", index),
			transform
		)

		table.insert(t, item)

		-- No comma at end of list
		if i ~= maxLen then
			M.insert_comma(t)
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

-- Separators
vim.g.lsep = ''
vim.g.rsep = ' '

local function build(sepHi, lSep, rSep, hi, data)
	return "%#"..sepHi.."#"..lSep.."%#"..hi.."# "..data.." %#"..sepHi.."#"..rSep
end

return function(hi, data)
	return build(hi.."Separator", vim.g.lsep, vim.g.rsep, hi, data)
end

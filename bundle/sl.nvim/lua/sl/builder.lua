local builder = {}

-- Separators
vim.g.lsep = ''
vim.g.rsep = ' '

function builder.build(sepHi, lSep, rSep, hi, data)
	return "%#"..sepHi.."#"..lSep.."%#"..hi.."# "..data.." %#"..sepHi.."#"..rSep
end

function builder.item(hi, data)
	return builder.build(hi.."Separator", vim.g.lsep, vim.g.rsep, hi, data)
end

return builder

import re
import vim

def zone(offset = 0):
	return vim.eval('v:lua.require("jd.latex_zones").get_zone({})'.format(offset))
def math():
	return zone() == 'math' and zone(-1) == 'math'
	# return vim.eval('vimtex#syntax#in_mathzone()') == '1'
def comment():
	return zone(-1) == 'comment'
	# return vim.eval('vimtex#syntax#in_comment()') == '1'
def env(name):
	[x,y] = vim.eval("vimtex#env#is_inside('" + name + "')")
	return x != '0' and y != '0'

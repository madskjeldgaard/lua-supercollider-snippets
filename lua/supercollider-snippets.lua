local utils = require'supercollider-snippets/utils'
local pats = require'supercollider-snippets/patterns'

local snippets = {
	b = [[${1:b} = Buffer.read(${3:s}, "${2:~/testsound/harmonica1.wav}".asAbsolutePath);$0]];
	randlist = utils.rand_var_list(math.random(3,8), "[");
	pseq = pats.pseq(4);
	prand = pats.prand(4);
	pxrand = pats.pxrand(4);
	pshuf = pats.pshuf(4);
	pwrand = pats.pwrand(3);
}

return snippets

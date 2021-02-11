local utils = require'supercollider-snippets/utils'
local pats = require'supercollider-snippets/patterns'

local snippets = {
	b = [[${1:b} = Buffer.read(${3:s}, "${2:~/testsound/harmonica1.wav}".asAbsolutePath);$0]];

	randlist = utils.rand_var_list(math.random(3,16), "[");
	randlisti = utils.rand_var_list(math.random(3,12), "[", 0, 'i');
	randlistfr = utils.rand_var_list(math.random(3,16), "[", 0, 'fr');

	pseq = pats.pseq(4);
	pseqi = pats.pseq(4, 'i');
	pseqfr = pats.pseq(4, 'fr');

	prand = pats.prand(4);
	prandi = pats.prand(4, 'i');
	prandfr = pats.prand(4, 'fr');

	pxrand = pats.pxrand(4);
	pxrandi = pats.pxrand(4, 'i');
	pxrandfr = pats.pxrand(4, 'fr');

	pshuf = pats.pshuf(4);
	pshufi = pats.pshuf(4, 'i');
	pshuffr = pats.pshuf(4, 'fr');

	pwrand = pats.pwrand(4);
	pwrandi = pats.pwrand(4, 'i');
	pwrandfr = pats.pwrand(4, 'fr');

	pseg = pats.pseg(3);
	psegi = pats.pseg(3, 'i');
	psegfr = pats.pseg(3, 'fr');

}

return snippets

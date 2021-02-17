local utils = require'supercollider-snippets/utils'
local pats = require'supercollider-snippets/patterns'
local opts = require'supercollider-snippets/opts'
local scsnips = require'supercollider-snippets/scsnips'

local snippets = {
	b = [[${1:b} = Buffer.read(${3:s}, "${2:~/testsound/harmonica1.wav}".asAbsolutePath);$0]];

	randlist = utils.rand_var_list(math.random(3,16), "[");
	randlisti = utils.rand_var_list(math.random(3,12), "[", 0, 'i');
	randlistfr = utils.rand_var_list(math.random(3,16), "[", 0, 'fr');

	-- Pattern stuff
    pdef = pats.pdef;

	pseq = pats.pseq(opts.default_sequence_length);
	pseqi = pats.pseq(opts.default_sequence_length, 'i');
	pseqfr = pats.pseq(opts.default_sequence_length, 'fr');
	pseqr = pats.pseq(opts.default_sequence_length, 'r');

	prand = pats.prand(opts.default_sequence_length);
	prandi = pats.prand(opts.default_sequence_length, 'i');
	prandfr = pats.prand(opts.default_sequence_length, 'fr');
	prandr = pats.prand(opts.default_sequence_length, 'r');

	pxrand = pats.pxrand(opts.default_sequence_length);
	pxrandi = pats.pxrand(opts.default_sequence_length, 'i');
	pxrandfr = pats.pxrand(opts.default_sequence_length, 'fr');
	pxrandr = pats.pxrand(opts.default_sequence_length, 'r');

	pshuf = pats.pshuf(opts.default_sequence_length);
	pshufi = pats.pshuf(opts.default_sequence_length, 'i');
	pshuffr = pats.pshuf(opts.default_sequence_length, 'fr');
	pshufr = pats.pshuf(opts.default_sequence_length, 'r');

	pwrand = pats.pwrand(opts.default_sequence_length);
	pwrandi = pats.pwrand(opts.default_sequence_length, 'i');
	pwrandfr = pats.pwrand(opts.default_sequence_length, 'fr');
	pwrandr = pats.pwrand(opts.default_sequence_length, 'r');

	pseg = pats.pseg(opts.default_sequence_length);
	psegi = pats.pseg(opts.default_sequence_length, 'i');
	psegfr = pats.pseg(opts.default_sequence_length, 'fr');
	psegr = pats.pseg(opts.default_sequence_length, 'r');

	-- Midi stuff
	noteon = scsnips.mididefNoteon;
	noteoff = scsnips.mididefNoteoff;
	cc = scsnips.mididefcc;

	-- Synthdef stuff
	sd = scsnips.synthdef;
	synthdef = scsnips.synthdef;

	-- Ndefs
	input = scsnips.ndefinput;

    -- Bus snips
    busfactory = scsnips.create_top_envir_busses;
}

return snippets

local utils = require'supercollider-snippets.utils'
local M = {}

function M.pseq(len, type, offset)
	offset = offset or 0
	local t = utils.rand_var_list(len, "[", 1, type, offset)
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

M.pdef = {
    "Pdef('",
    { order=1, id="name", default=function()return os.date('%H_%M_%S')end, is_input=true },
    "', {\n\tPbind(*[\n\t\tinstrument: '",
    { order=2, id="instrument", default="default", is_input=true },
    "'},\n\t\tdur: ",
    { order=3, id="dur", default="1/4", is_input=true },
    ",\n\t\t",
    { order=0, id=0 },
    "\n\t]\n)})",
    { order=4, id="method", default=".play(quant:0)", is_input=true },
}

M.swing_routine = [[
~swingify = Prout({ |ev|
    var now, nextTime = 0, thisShouldSwing, nextShouldSwing = false, adjust;
    while { ev.notNil } {
            now = nextTime;
            nextTime = now + ev.delta;
            thisShouldSwing = nextShouldSwing;
            nextShouldSwing = ((nextTime absdif: nextTime.round(ev[\swingBase])) <= (ev[\swingThreshold] ? 0)) and: {
            (nextTime / ev[\swingBase]).round.asInteger.odd
        };
        adjust = ev[\swingBase] * ev[\swingAmount];
        if(thisShouldSwing) {
            ev[\timingOffset] = (ev[\timingOffset] ? 0) + adjust;
            if(nextShouldSwing.not) {
                ev[\sustain] = ev.use { ~sustain.value } - adjust;
            };
        } {
            if(nextShouldSwing) {
                ev[\sustain] = ev.use { ~sustain.value } + adjust;
            };
        };
        ev = ev.yield;
    };
});
]];

M.swing_pattern = {
    "TempoClock.tempo = ", { order=1, id="tempo", default="90", is_input=true }, " / 120;\n",
    "Pdef('", { order=2, id="name", default="swing", is_input=true }, "',\n\tPpar([\n\t\tPseq([\n",
    "\t\t\tPchain(\n\t\t\t\t~swingify,\n\t\t\t\tPbind(\n\t\t\t\t\t\\instrument, '",
    { order=3, id="instrument", default="default", is_input=true }, "',\n",
    "\t\t\t\t\t", "\\out, ", { order=4, id="out", default="~bus_1", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\dur, ", { order=5, id="duration", default="Pwhite(0.1)", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\legato, ", { order=6, id="legato", default="1.0", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\degree, ", { order=7, id="degree", default="Pseq((0..12), inf)", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\octave, ", { order=8, id="octave", default="Pseq([3,4,5,4,5], inf)", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\scale, ", { order=9, id="scale", default="Scale.yu", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\pan, Pwhite(-1) * ", { order=10, id="random pan amount", default="1/4", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\amp, ", { order=11, id="amplitude", default="Pwhite(0.6,0.7)", is_input=true }, ",\n",
    "\t\t\t\t),\n",
    "\t\t\t\t(swingBase: 0.25, swingAmount: ", { order=12, id="swing amount", default="0.1", is_input=true }, ")\n",
    "\t\t\t),\n",
    "\t\t\tPfuncn({ q.stop; Event.silent(0) }, 1)", "\n",
    "\t\t])\n\t])\n).play(quant: ", { order=13, id="quant", default="1/8", is_input=true }, ");"
};

return M

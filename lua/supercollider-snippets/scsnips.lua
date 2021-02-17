local Snippets = {}

-- Synthdef stuff
Snippets.synthdef = [[SynthDef(${1:\\name}, {|out=0, amp=0.5| 
	var sig = ${2:Silent.ar()};
	Out.ar(out, sig * amp)
}).add;
]];

-- Midi stuff
Snippets.mididefNoteon = [[MIDIdef.noteOn(${1:\\name}, {
	arg val, num, chan, src; 
	${2:num.postln}
}, chan: ${3:0})${4:.fix};]];

Snippets.mididefNoteoff = [[MIDIdef.noteOff(${1:\\name}, {
	arg val, num, chan, src; 
	${2:num.postln}
}, chan: ${3:0})${4:.fix};]];

Snippets.mididefcc = [[MIDIdef.cc(${1:\\name}, {
	arg val, num, chan, src; 
	${2:val.postln}
},ccNum: ${3:64}, chan: ${4:0})${5:.fix};]];

-- Ndefs
Snippets.ndefinput = [[Ndef(${1:\\name}, {|in=0|
    SoundIn.ar(in)
})${2:.play}]];

-- Bus stuff
Snippets.create_top_envir_busses = {
    { order=1, id="how many busses?", default="5", is_input=true },
    ".do{arg i;\n",
    "\tvar num = i+1;\n",
    "\tvar key = (\"",
    { order=2, id="bus prefix name", default="bus", is_input=true }, "\"++\"",
    { order=3, id="bus name spacer", default="_", is_input=true },
    "\"++num).asSymbol;\n",
    "\tvar env = topEnvironment;\n",
    "\tenv.put(key, Bus.audio(s, ",
    { order=4, id="num channels", default="2", is_input=true }, "));\n",
    "\tNdef(key, {\n\t\tvar in = In.ar(env.at(key), ",
    { order=4, id="num channels" }, ");\n\t\t",
    { order=5, default="Limiter.ar(LeakDC.ar(in*0.95), 0.99)"},
    ";\n\t}).play(i*",{ order=4, id="num channels" },");\n}\n",
    { order=0, id=0 }
};

return Snippets

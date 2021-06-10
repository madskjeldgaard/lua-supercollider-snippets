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

Snippets.modality_midi_desc = [[
// Modality description for $2, a $4 device
~${1:descInput} = (
idInfo: "${2:Teensy MIDI}",
deviceName: "${3:$2}",
protocol: '${4:midi}',
elementsDesc: (
elements: 
	// $5 $6s
	${5:10}.collect{|$6Num|
	(
	key: "${12| S[6]:sub(1,2)}%".format($6Num).asSymbol,
	type: '${6:knob}',
	spec: '${7:midiCC}',
	midiMsgType: '${8:cc}',
	midiChan: ${9:0},
	midiNum: ${10:$6Num},
	ioType: '${11:in}'
	)
	}
)
);

m = MKtl(\test, ~$1);
m.trace(${13:true});
$0
]];

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

-- SynthDef.wrap
Snippets.synthdefwrap = [[SynthDef.wrap(${1:~funcName}, prependArgs: [${2:sig}])]];

-- Custom event types
Snippets.eventType = [[Event.addEventType(\\${1:happyEvent}, { |server|
    ~octave = [5, 6, 7]; // always play three octaves
    ~detune = 10.0.rand2; // always play a bit out of tune
    ~type = \note; // now set type to a different one
    currentEnvironment.play;
});]];

Snippets.synthdefx = [[ SynthDef.new(\\${1:fxname}, {|out| 
	var in = In.ar(out, numChannels: ${2:2});
	var sig = ${3:HPF.ar(in)};

	ReplaceOut.ar(out, sig);
}).add;]]

Snippets.vstplugin = [[(
SynthDef(\\${1:vstplugin}, { arg bus;
	var numChannels = ${2:2};
	ReplaceOut.ar(bus, VSTPlugin.ar(In.ar(bus, numChannels), numChannels));
}).add;
)

// Build cache
VSTPlugin.search;

${3:~fx} = VSTPluginController(Synth(\\$1, [\bus, ${4:0}])).open("${5:TEOTE}");
$3.gui;
]];


Snippets.ndef = [[Ndef(\\${1:name}, { 
	${2:SinOsc.ar(${3:200})} 
})${4:.play}]];

Snippets.ndefplaybuf = [[Ndef(\\${1:name}, { 
	var buffer = \buffer.kr(b);
	var env = Env.perc(\atk.kr(0.01), \rel.kr(0.99)).kr(gate: \t_gate.kr(1), timeScale: \dur.kr(1), doneAction: 0);
	var sig = PlayBuf.ar(
		numChannels: ${2:2},  
		bufnum: buffer,  
		rate: \rate.kr(${3:1}, spec:[-4.0,4.0]) * BufRateScale.kr(buffer),  
		trigger: 1.0,  
		startPos: \start.kr(${4:0}, spec: [0.0,1.0]) * BufFrames.kr(buffer),  
		loop: \loop.kr(${5:1}),  
		doneAction: 0
	);

	sig * env * \amp.kr(${6:0.5})
})${7:.play}]];



return Snippets

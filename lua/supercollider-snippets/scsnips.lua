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

return Snippets

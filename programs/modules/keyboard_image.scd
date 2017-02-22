//Opens window with image of a table showing name connection between MIDI Note # and Musical Note
//Table from "A Mathematical Exploration of Musical Dissonance", Maxwell Ng, Feb. 2014

(var basePath = thisProcess.nowExecutingPath.asString.dirname;
    ~wkeys = Window.new("Table of MIDI Notes", Rect(50,500,400,489));
    ~wkeys.front; // comment this to copy offscreen window
    ~wkeys.view.background_(Color.white);
i = Image.new(basePath +/+ "MIDI_table.png");

~wkeys.drawFunc = {
	i.drawInRect(Rect(0,0,400,489), Rect(0,0,400,489), 2, 1.0);};
)
if(~button.value == 0, {~color_array = Array.fill(200,1)});

(if(~key_vis.value == 1, {

	var obj;

	obj = ~freqslider;


/*A0*/(if(obj.value.linlin(0,1,21,108) <= 21, {~a0.background_(Color(1,~color_array[21-1],~color_array[21-1]));}, {~a0.background_(Color.white)}););
/*B0*/(if(obj.value.linlin(0,1,21,108) <= 23, {~b0.background_(Color(1,~color_array[23-1],~color_array[23-1]));}, {~b0.background_(Color.white)}););
/*C1*/(if(obj.value.linlin(0,1,21,108) <= 24, {~c1.background_(Color(1,~color_array[24-1],~color_array[24-1]));}, {~c1.background_(Color.white)}););
/*D1*/(if(obj.value.linlin(0,1,21,108) <= 26, {~d1.background_(Color(1,~color_array[26-1],~color_array[26-1]));}, {~d1.background_(Color.white)}););
/*E1*/(if(obj.value.linlin(0,1,21,108) <= 28, {~e1.background_(Color(1,~color_array[28-1],~color_array[28-1]));}, {~e1.background_(Color.white)}););
/*F1*/(if(obj.value.linlin(0,1,21,108) <= 29, {~f1.background_(Color(1,~color_array[29-1],~color_array[29-1]));}, {~f1.background_(Color.white)}););
/*G1*/(if(obj.value.linlin(0,1,21,108) <= 31, {~g1.background_(Color(1,~color_array[31-1],~color_array[31-1]));}, {~g1.background_(Color.white)}););
/*A1*/(if(obj.value.linlin(0,1,21,108) <= 33, {~a1.background_(Color(1,~color_array[33-1],~color_array[33-1]));}, {~a1.background_(Color.white)}););
/*B1*/(if(obj.value.linlin(0,1,21,108) <= 35, {~b1.background_(Color(1,~color_array[35-1],~color_array[35-1]));}, {~b1.background_(Color.white)}););
/*C2*/(if(obj.value.linlin(0,1,21,108) <= 36, {~c2.background_(Color(1,~color_array[36-1],~color_array[36-1]));}, {~c2.background_(Color.white)}););
/*D2*/(if(obj.value.linlin(0,1,21,108) <= 38, {~d2.background_(Color(1,~color_array[38-1],~color_array[38-1]));}, {~d2.background_(Color.white)}););
/*E2*/(if(obj.value.linlin(0,1,21,108) <= 40, {~e2.background_(Color(1,~color_array[40-1],~color_array[40-1]));}, {~e2.background_(Color.white)}););
/*F2*/(if(obj.value.linlin(0,1,21,108) <= 41, {~f2.background_(Color(1,~color_array[41-1],~color_array[41-1]));}, {~f2.background_(Color.white)}););
/*G2*/(if(obj.value.linlin(0,1,21,108) <= 43, {~g2.background_(Color(1,~color_array[43-1],~color_array[43-1]));}, {~g2.background_(Color.white)}););
/*A2*/(if(obj.value.linlin(0,1,21,108) <= 45, {~a2.background_(Color(1,~color_array[45-1],~color_array[45-1]));}, {~a2.background_(Color.white)}););
/*B2*/(if(obj.value.linlin(0,1,21,108) <= 47, {~b2.background_(Color(1,~color_array[47-1],~color_array[47-1]));}, {~b2.background_(Color.white)}););
/*C3*/(if(obj.value.linlin(0,1,21,108) <= 48, {~c3.background_(Color(1,~color_array[48-1],~color_array[48-1]));}, {~c3.background_(Color.white)}););
/*D3*/(if(obj.value.linlin(0,1,21,108) <= 50, {~d3.background_(Color(1,~color_array[50-1],~color_array[50-1]));}, {~d3.background_(Color.white)}););
/*E3*/(if(obj.value.linlin(0,1,21,108) <= 52, {~e3.background_(Color(1,~color_array[52-1],~color_array[52-1]));}, {~e3.background_(Color.white)}););
/*F3*/(if(obj.value.linlin(0,1,21,108) <= 53, {~f3.background_(Color(1,~color_array[53-1],~color_array[53-1]));}, {~f3.background_(Color.white)}););
/*G3*/(if(obj.value.linlin(0,1,21,108) <= 55, {~g3.background_(Color(1,~color_array[55-1],~color_array[55-1]));}, {~g3.background_(Color.white)}););
/*A3*/(if(obj.value.linlin(0,1,21,108) <= 57, {~a3.background_(Color(1,~color_array[57-1],~color_array[57-1]));}, {~a3.background_(Color.white)}););
/*B3*/(if(obj.value.linlin(0,1,21,108) <= 59, {~b3.background_(Color(1,~color_array[59-1],~color_array[59-1]));}, {~b3.background_(Color.white)}););
/*C4*/(if(obj.value.linlin(0,1,21,108) <= 60, {~c4.background_(Color(1,~color_array[60-1],~color_array[60-1]));}, {~c4.background_(Color.white)}););
/*D4*/(if(obj.value.linlin(0,1,21,108) <= 62, {~d4.background_(Color(1,~color_array[62-1],~color_array[62-1]));}, {~d4.background_(Color.white)}););
/*E4*/(if(obj.value.linlin(0,1,21,108) <= 64, {~e4.background_(Color(1,~color_array[64-1],~color_array[64-1]));}, {~e4.background_(Color.white)}););
/*F4*/(if(obj.value.linlin(0,1,21,108) <= 65, {~f4.background_(Color(1,~color_array[65-1],~color_array[65-1]));}, {~f4.background_(Color.white)}););
/*G4*/(if(obj.value.linlin(0,1,21,108) <= 67, {~g4.background_(Color(1,~color_array[67-1],~color_array[67-1]));}, {~g4.background_(Color.white)}););
/*A4*/(if(obj.value.linlin(0,1,21,108) <= 69, {~a4.background_(Color(1,~color_array[69-1],~color_array[69-1]));}, {~a4.background_(Color.white)}););
/*B4*/(if(obj.value.linlin(0,1,21,108) <= 71, {~b4.background_(Color(1,~color_array[71-1],~color_array[71-1]));}, {~b4.background_(Color.white)}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 72, {~c5.background_(Color(1,~color_array[72-1],~color_array[72-1]));}, {~c5.background_(Color.white)}););
/*D5*/(if(obj.value.linlin(0,1,21,108) <= 74, {~d5.background_(Color(1,~color_array[74-1],~color_array[74-1]));}, {~d5.background_(Color.white)}););
/*E5*/(if(obj.value.linlin(0,1,21,108) <= 76, {~e5.background_(Color(1,~color_array[76-1],~color_array[76-1]));}, {~e5.background_(Color.white)}););
/*F5*/(if(obj.value.linlin(0,1,21,108) <= 77, {~f5.background_(Color(1,~color_array[77-1],~color_array[77-1]));}, {~f5.background_(Color.white)}););
/*G5*/(if(obj.value.linlin(0,1,21,108) <= 79, {~g5.background_(Color(1,~color_array[79-1],~color_array[79-1]));}, {~g5.background_(Color.white)}););
/*A5*/(if(obj.value.linlin(0,1,21,108) <= 81, {~a5.background_(Color(1,~color_array[81-1],~color_array[81-1]));}, {~a5.background_(Color.white)}););
/*B5*/(if(obj.value.linlin(0,1,21,108) <= 83, {~b5.background_(Color(1,~color_array[83-1],~color_array[83-1]));}, {~b5.background_(Color.white)}););
/*C6*/(if(obj.value.linlin(0,1,21,108) <= 84, {~c6.background_(Color(1,~color_array[84-1],~color_array[84-1]));}, {~c6.background_(Color.white)}););
/*D6*/(if(obj.value.linlin(0,1,21,108) <= 86, {~d6.background_(Color(1,~color_array[86-1],~color_array[86-1]));}, {~d6.background_(Color.white)}););
/*E6*/(if(obj.value.linlin(0,1,21,108) <= 88, {~e6.background_(Color(1,~color_array[88-1],~color_array[88-1]));}, {~e6.background_(Color.white)}););
/*F6*/(if(obj.value.linlin(0,1,21,108) <= 89, {~f6.background_(Color(1,~color_array[89-1],~color_array[89-1]));}, {~f6.background_(Color.white)}););
/*G6*/(if(obj.value.linlin(0,1,21,108) <= 91, {~g6.background_(Color(1,~color_array[91-1],~color_array[91-1]));}, {~g6.background_(Color.white)}););
/*A6*/(if(obj.value.linlin(0,1,21,108) <= 93, {~a6.background_(Color(1,~color_array[93-1],~color_array[93-1]));}, {~a6.background_(Color.white)}););
/*B6*/(if(obj.value.linlin(0,1,21,108) <= 95, {~b6.background_(Color(1,~color_array[95-1],~color_array[95-1]));}, {~b6.background_(Color.white)}););
/*C7*/(if(obj.value.linlin(0,1,21,108) <= 96, {~c7.background_(Color(1,~color_array[96-1],~color_array[96-1]));}, {~c7.background_(Color.white)}););
/*D7*/(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,~color_array[98-1],~color_array[98-1]));}, {~d7.background_(Color.white)}););
/*E7*/(if(obj.value.linlin(0,1,21,108) <= 100, {~e7.background_(Color(1,~color_array[100-1],~color_array[100-1]));}, {~e7.background_(Color.white)}););
/*F7*/(if(obj.value.linlin(0,1,21,108) <= 101, {~f7.background_(Color(1,~color_array[101-1],~color_array[101-1]));}, {~f7.background_(Color.white)}););
/*G7*/(if(obj.value.linlin(0,1,21,108) <= 103, {~g7.background_(Color(1,~color_array[103-1],~color_array[103-1]));}, {~g7.background_(Color.white)}););
/*A7*/(if(obj.value.linlin(0,1,21,108) <= 105, {~a7.background_(Color(1,~color_array[105-1],~color_array[105-1]));}, {~a7.background_(Color.white)}););
/*B7*/(if(obj.value.linlin(0,1,21,108) <= 107, {~b7.background_(Color(1,~color_array[107-1],~color_array[107-1]));}, {~b7.background_(Color.white)}););
/*C8*/(if(obj.value.linlin(0,1,21,108) <= 108, {~c8.background_(Color(1,~color_array[108-1],~color_array[108-1]));}, {~c8.background_(Color.white)}););


	// Extended
/*D8*/(if(obj.value.linlin(0,1,21,108) <= 110, {~d8.background_(Color(1,~color_array[110-1],~color_array[110-1]));}, {~d8.background_(Color.white)}););
/*E8*/(if(obj.value.linlin(0,1,21,108) <= 112, {~e8.background_(Color(1,~color_array[112-1],~color_array[112-1]));}, {~e8.background_(Color.white)}););
/*F8*/(if(obj.value.linlin(0,1,21,108) <= 113, {~f8.background_(Color(1,~color_array[113-1],~color_array[113-1]));}, {~f8.background_(Color.white)}););
/*G8*/(if(obj.value.linlin(0,1,21,108) <= 115, {~g8.background_(Color(1,~color_array[115-1],~color_array[115-1]));}, {~g8.background_(Color.white)}););
/*A8*/(if(obj.value.linlin(0,1,21,108) <= 117, {~a8.background_(Color(1,~color_array[117-1],~color_array[117-1]));}, {~a8.background_(Color.white)}););
/*B8*/(if(obj.value.linlin(0,1,21,108) <= 119, {~b8.background_(Color(1,~color_array[119-1],~color_array[119-1]));}, {~b8.background_(Color.white)}););
/*C9*/(if(obj.value.linlin(0,1,21,108) <= 120, {~c9.background_(Color(1,~color_array[120-1],~color_array[120-1]));}, {~c9.background_(Color.white)}););
/*D9*/(if(obj.value.linlin(0,1,21,108) <= 122, {~d9.background_(Color(1,~color_array[122-1],~color_array[122-1]));}, {~d9.background_(Color.white)}););
/*E9*/(if(obj.value.linlin(0,1,21,108) <= 124, {~e9.background_(Color(1,~color_array[124-1],~color_array[124-1]));}, {~e9.background_(Color.white)}););
/*F9*/(if(obj.value.linlin(0,1,21,108) <= 125, {~f9.background_(Color(1,~color_array[125-1],~color_array[125-1]));}, {~f9.background_(Color.white)}););
/*G9*/(if(obj.value.linlin(0,1,21,108) <= 127, {~g9.background_(Color(1,~color_array[127-1],~color_array[127-1]));}, {~g9.background_(Color.white)}););
/*A9*/(if(obj.value.linlin(0,1,21,108) <= 129, {~a9.background_(Color(1,~color_array[129-1],~color_array[129-1]));}, {~a9.background_(Color.white)}););
/*B9*/(if(obj.value.linlin(0,1,21,108) <= 131, {~b9.background_(Color(1,~color_array[131-1],~color_array[131-1]));}, {~b9.background_(Color.white)}););
/*C10*/(if(obj.value.linlin(0,1,21,108) <= 132, {~c10.background_(Color(1,~color_array[132-1],~color_array[132-1]));}, {~c10.background_(Color.white)}););
/*D10*/(if(obj.value.linlin(0,1,21,108) <= 134, {~d10.background_(Color(1,~color_array[134-1],~color_array[134-1]));}, {~d10.background_(Color.white)}););
/*E10*/(if(obj.value.linlin(0,1,21,108) <= 136, {~e10.background_(Color(1,~color_array[136-1],~color_array[136-1]));}, {~e10.background_(Color.white)}););
/*F10*/(if(obj.value.linlin(0,1,21,108) <= 137, {~f10.background_(Color(1,~color_array[137-1],~color_array[137-1]));}, {~f10.background_(Color.white)}););
/*G10*/(if(obj.value.linlin(0,1,21,108) <= 139, {~g10.background_(Color(1,~color_array[139-1],~color_array[139-1]));}, {~g10.background_(Color.white)}););
/*A10*/(if(obj.value.linlin(0,1,21,108) <= 141, {~a10.background_(Color(1,~color_array[141-1],~color_array[141-1]));}, {~a10.background_(Color.white)}););
/*B10*/(if(obj.value.linlin(0,1,21,108) <= 143, {~b10.background_(Color(1,~color_array[143-1],~color_array[143-1]));}, {~b10.background_(Color.white)}););
/*C11*/(if(obj.value.linlin(0,1,21,108) <= 144, {~c11.background_(Color(1,~color_array[144-1],~color_array[144-1]));}, {~c11.background_(Color.white)}););
/*D11*/(if(obj.value.linlin(0,1,21,108) <= 146, {~d11.background_(Color(1,~color_array[146-1],~color_array[146-1]));}, {~d11.background_(Color.white)}););
/*E11*/(if(obj.value.linlin(0,1,21,108) <= 148, {~e11.background_(Color(1,~color_array[148-1],~color_array[148-1]));}, {~e11.background_(Color.white)}););
/*F11*/(if(obj.value.linlin(0,1,21,108) <= 149, {~f11.background_(Color(1,~color_array[149-1],~color_array[149-1]));}, {~f11.background_(Color.white)}););
/*G11*/(if(obj.value.linlin(0,1,21,108) <= 151, {~g11.background_(Color(1,~color_array[151-1],~color_array[151-1]));}, {~g11.background_(Color.white)}););
/*A11*/(if(obj.value.linlin(0,1,21,108) <= 153, {~a11.background_(Color(1,~color_array[153-1],~color_array[153-1]));}, {~a11.background_(Color.white)}););
/*B11*/(if(obj.value.linlin(0,1,21,108) <= 155, {~b11.background_(Color(1,~color_array[155-1],~color_array[155-1]));}, {~b11.background_(Color.white)}););
/*C12*/(if(obj.value.linlin(0,1,21,108) <= 156, {~c12.background_(Color(1,~color_array[156-1],~color_array[156-1]));}, {~c12.background_(Color.white)}););



/*
/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <= 22, {
				if(~color_array[22-1] < 1, {~aSHARP0.background_(Color(1,~color_array[22-1],~color_array[22-1]));},
					{~aSHARP0.background_(Color.black)})
			}, {~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 25, {~cSHARP1.background_(Color((1-~color_array[25-1])**(0.25),0,0));}, {~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 27, {~dSHARP1.background_(Color((1-~color_array[27-1])**(0.25),0,0));}, {~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 30, {~fSHARP1.background_(Color((1-~color_array[30-1])**(0.25),0,0));}, {~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 32, {~gSHARP1.background_(Color((1-~color_array[32-1])**(0.25),0,0));}, {~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <= 34, {~aSHARP1.background_(Color((1-~color_array[34-1])**(0.25),0,0));}, {~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 37, {~cSHARP2.background_(Color((1-~color_array[37-1])**(0.25),0,0));}, {~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 39, {~dSHARP2.background_(Color((1-~color_array[39-1])**(0.25),0,0));}, {~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 42, {~fSHARP2.background_(Color((1-~color_array[42-1])**(0.25),0,0));}, {~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 44, {~gSHARP2.background_(Color((1-~color_array[44-1])**(0.25),0,0));}, {~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <= 46, {~aSHARP2.background_(Color((1-~color_array[46-1])**(0.25),0,0));}, {~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 49, {~cSHARP3.background_(Color((1-~color_array[49-1])**(0.25),0,0));}, {~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 51, {~dSHARP3.background_(Color((1-~color_array[51-1])**(0.25),0,0));}, {~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 54, {~fSHARP3.background_(Color((1-~color_array[54-1])**(0.25),0,0));}, {~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 56, {~gSHARP3.background_(Color((1-~color_array[56-1])**(0.25),0,0));}, {~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <= 58, {~aSHARP3.background_(Color((1-~color_array[58-1])**(0.25),0,0));}, {~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 61, {~cSHARP4.background_(Color((1-~color_array[61-1])**(0.25),0,0));}, {~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 63, {~dSHARP4.background_(Color((1-~color_array[63-1])**(0.25),0,0));}, {~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 66, {~fSHARP4.background_(Color((1-~color_array[66-1])**(0.25),0,0));}, {~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 68, {~gSHARP4.background_(Color((1-~color_array[68-1])**(0.25),0,0));}, {~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <= 70, {~aSHARP4.background_(Color((1-~color_array[70-1])**(0.25),0,0));}, {~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 73, {~cSHARP5.background_(Color((1-~color_array[73-1])**(0.25),0,0));}, {~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 75, {~dSHARP5.background_(Color((1-~color_array[75-1])**(0.25),0,0));}, {~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 78, {~fSHARP5.background_(Color((1-~color_array[78-1])**(0.25),0,0));}, {~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 80, {~gSHARP5.background_(Color((1-~color_array[80-1])**(0.25),0,0));}, {~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <= 82, {~aSHARP5.background_(Color((1-~color_array[82-1])**(0.25),0,0));}, {~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 85, {~cSHARP6.background_(Color((1-~color_array[85-1])**(0.25),0,0));}, {~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 87, {~dSHARP6.background_(Color((1-~color_array[87-1])**(0.25),0,0));}, {~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 90, {~fSHARP6.background_(Color((1-~color_array[90-1])**(0.25),0,0));}, {~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 92, {~gSHARP6.background_(Color((1-~color_array[92-1])**(0.25),0,0));}, {~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <= 94, {~aSHARP6.background_(Color((1-~color_array[94-1])**(0.25),0,0));}, {~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 97, {~cSHARP7.background_(Color((1-~color_array[97-1])**(0.25),0,0));}, {~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 99, {~dSHARP7.background_(Color((1-~color_array[99-1])**(0.25),0,0));}, {~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 102, {~fSHARP7.background_(Color((1-~color_array[102-1])**(0.25),0,0));}, {~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 104, {~gSHARP7.background_(Color((1-~color_array[104-1])**(0.25),0,0));}, {~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <= 106, {~aSHARP7.background_(Color((1-~color_array[106-1])**(0.25),0,0));}, {~aSHARP7.background_(Color.black)}););*/

/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <=22,{if(~color_array[22-1]<1,{~aSHARP0.background_(Color(1,~color_array[22-1],~color_array[22-1]));},{~aSHARP0.background_(Color.black)})},{~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <=25,{if(~color_array[25-1]<1,{~cSHARP1.background_(Color(1,~color_array[25-1],~color_array[25-1]));},{~cSHARP1.background_(Color.black)})},{~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <=27,{if(~color_array[27-1]<1,{~dSHARP1.background_(Color(1,~color_array[27-1],~color_array[27-1]));},{~dSHARP1.background_(Color.black)})},{~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <=30,{if(~color_array[30-1]<1,{~fSHARP1.background_(Color(1,~color_array[30-1],~color_array[30-1]));},{~fSHARP1.background_(Color.black)})},{~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <=32,{if(~color_array[32-1]<1,{~gSHARP1.background_(Color(1,~color_array[32-1],~color_array[32-1]));},{~gSHARP1.background_(Color.black)})},{~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <=34,{if(~color_array[34-1]<1,{~aSHARP1.background_(Color(1,~color_array[34-1],~color_array[34-1]));},{~aSHARP1.background_(Color.black)})},{~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <=37,{if(~color_array[37-1]<1,{~cSHARP2.background_(Color(1,~color_array[37-1],~color_array[37-1]));},{~cSHARP2.background_(Color.black)})},{~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <=39,{if(~color_array[39-1]<1,{~dSHARP2.background_(Color(1,~color_array[39-1],~color_array[39-1]));},{~dSHARP2.background_(Color.black)})},{~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <=42,{if(~color_array[42-1]<1,{~fSHARP2.background_(Color(1,~color_array[42-1],~color_array[42-1]));},{~fSHARP2.background_(Color.black)})},{~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <=44,{if(~color_array[44-1]<1,{~gSHARP2.background_(Color(1,~color_array[44-1],~color_array[44-1]));},{~gSHARP2.background_(Color.black)})},{~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <=46,{if(~color_array[46-1]<1,{~aSHARP2.background_(Color(1,~color_array[46-1],~color_array[46-1]));},{~aSHARP2.background_(Color.black)})},{~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <=49,{if(~color_array[49-1]<1,{~cSHARP3.background_(Color(1,~color_array[49-1],~color_array[49-1]));},{~cSHARP3.background_(Color.black)})},{~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <=51,{if(~color_array[51-1]<1,{~dSHARP3.background_(Color(1,~color_array[51-1],~color_array[51-1]));},{~dSHARP3.background_(Color.black)})},{~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <=54,{if(~color_array[54-1]<1,{~fSHARP3.background_(Color(1,~color_array[54-1],~color_array[54-1]));},{~fSHARP3.background_(Color.black)})},{~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <=56,{if(~color_array[56-1]<1,{~gSHARP3.background_(Color(1,~color_array[56-1],~color_array[56-1]));},{~gSHARP3.background_(Color.black)})},{~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <=58,{if(~color_array[58-1]<1,{~aSHARP3.background_(Color(1,~color_array[58-1],~color_array[58-1]));},{~aSHARP3.background_(Color.black)})},{~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <=61,{if(~color_array[61-1]<1,{~cSHARP4.background_(Color(1,~color_array[61-1],~color_array[61-1]));},{~cSHARP4.background_(Color.black)})},{~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <=63,{if(~color_array[63-1]<1,{~dSHARP4.background_(Color(1,~color_array[63-1],~color_array[63-1]));},{~dSHARP4.background_(Color.black)})},{~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <=66,{if(~color_array[66-1]<1,{~fSHARP4.background_(Color(1,~color_array[66-1],~color_array[66-1]));},{~fSHARP4.background_(Color.black)})},{~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <=68,{if(~color_array[68-1]<1,{~gSHARP4.background_(Color(1,~color_array[68-1],~color_array[68-1]));},{~gSHARP4.background_(Color.black)})},{~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <=70,{if(~color_array[70-1]<1,{~aSHARP4.background_(Color(1,~color_array[70-1],~color_array[70-1]));},{~aSHARP4.background_(Color.black)})},{~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <=73,{if(~color_array[73-1]<1,{~cSHARP5.background_(Color(1,~color_array[73-1],~color_array[73-1]));},{~cSHARP5.background_(Color.black)})},{~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <=75,{if(~color_array[75-1]<1,{~dSHARP5.background_(Color(1,~color_array[75-1],~color_array[75-1]));},{~dSHARP5.background_(Color.black)})},{~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <=78,{if(~color_array[78-1]<1,{~fSHARP5.background_(Color(1,~color_array[78-1],~color_array[78-1]));},{~fSHARP5.background_(Color.black)})},{~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <=80,{if(~color_array[80-1]<1,{~gSHARP5.background_(Color(1,~color_array[80-1],~color_array[80-1]));},{~gSHARP5.background_(Color.black)})},{~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <=82,{if(~color_array[82-1]<1,{~aSHARP5.background_(Color(1,~color_array[82-1],~color_array[82-1]));},{~aSHARP5.background_(Color.black)})},{~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <=85,{if(~color_array[85-1]<1,{~cSHARP6.background_(Color(1,~color_array[85-1],~color_array[85-1]));},{~cSHARP6.background_(Color.black)})},{~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <=87,{if(~color_array[87-1]<1,{~dSHARP6.background_(Color(1,~color_array[87-1],~color_array[87-1]));},{~dSHARP6.background_(Color.black)})},{~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <=90,{if(~color_array[90-1]<1,{~fSHARP6.background_(Color(1,~color_array[90-1],~color_array[90-1]));},{~fSHARP6.background_(Color.black)})},{~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <=92,{if(~color_array[92-1]<1,{~gSHARP6.background_(Color(1,~color_array[92-1],~color_array[92-1]));},{~gSHARP6.background_(Color.black)})},{~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <=94,{if(~color_array[94-1]<1,{~aSHARP6.background_(Color(1,~color_array[94-1],~color_array[94-1]));},{~aSHARP6.background_(Color.black)})},{~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <=97,{if(~color_array[97-1]<1,{~cSHARP7.background_(Color(1,~color_array[97-1],~color_array[97-1]));},{~cSHARP7.background_(Color.black)})},{~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <=99,{if(~color_array[99-1]<1,{~dSHARP7.background_(Color(1,~color_array[99-1],~color_array[99-1]));},{~dSHARP7.background_(Color.black)})},{~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <=102,{if(~color_array[102-1]<1,{~fSHARP7.background_(Color(1,~color_array[102-1],~color_array[102-1]));},{~fSHARP7.background_(Color.black)})},{~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <=104,{if(~color_array[104-1]<1,{~gSHARP7.background_(Color(1,~color_array[104-1],~color_array[104-1]));},{~gSHARP7.background_(Color.black)})},{~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <=106,{if(~color_array[106-1]<1,{~aSHARP7.background_(Color(1,~color_array[106-1],~color_array[106-1]));},{~aSHARP7.background_(Color.black)})},{~aSHARP7.background_(Color.black)}););

// Extended
/*CSHARP8*/(if(obj.value.linlin(0,1,21,108) <=109,{if(~color_array[109-1]<1,{~cSHARP8.background_(Color(1,~color_array[109-1],~color_array[109-1]));},{~cSHARP8.background_(Color.black)})},{~cSHARP8.background_(Color.black)}););
/*DSHARP8*/(if(obj.value.linlin(0,1,21,108) <=111,{if(~color_array[111-1]<1,{~dSHARP8.background_(Color(1,~color_array[111-1],~color_array[111-1]));},{~dSHARP8.background_(Color.black)})},{~dSHARP8.background_(Color.black)}););
/*FSHARP8*/(if(obj.value.linlin(0,1,21,108) <=114,{if(~color_array[114-1]<1,{~fSHARP8.background_(Color(1,~color_array[114-1],~color_array[114-1]));},{~fSHARP8.background_(Color.black)})},{~fSHARP8.background_(Color.black)}););
/*GSHARP8*/(if(obj.value.linlin(0,1,21,108) <=116,{if(~color_array[116-1]<1,{~gSHARP8.background_(Color(1,~color_array[116-1],~color_array[116-1]));},{~gSHARP8.background_(Color.black)})},{~gSHARP8.background_(Color.black)}););
/*ASHARP8*/(if(obj.value.linlin(0,1,21,108) <=118,{if(~color_array[118-1]<1,{~aSHARP8.background_(Color(1,~color_array[118-1],~color_array[118-1]));},{~aSHARP8.background_(Color.black)})},{~aSHARP8.background_(Color.black)}););
/*CSHARP9*/(if(obj.value.linlin(0,1,21,108) <=121,{if(~color_array[121-1]<1,{~cSHARP9.background_(Color(1,~color_array[121-1],~color_array[121-1]));},{~cSHARP9.background_(Color.black)})},{~cSHARP9.background_(Color.black)}););
/*DSHARP9*/(if(obj.value.linlin(0,1,21,108) <=123,{if(~color_array[123-1]<1,{~dSHARP9.background_(Color(1,~color_array[123-1],~color_array[123-1]));},{~dSHARP9.background_(Color.black)})},{~dSHARP9.background_(Color.black)}););
/*FSHARP9*/(if(obj.value.linlin(0,1,21,108) <=126,{if(~color_array[126-1]<1,{~fSHARP9.background_(Color(1,~color_array[126-1],~color_array[126-1]));},{~fSHARP9.background_(Color.black)})},{~fSHARP9.background_(Color.black)}););
/*GSHARP9*/(if(obj.value.linlin(0,1,21,108) <=128,{if(~color_array[128-1]<1,{~gSHARP9.background_(Color(1,~color_array[128-1],~color_array[128-1]));},{~gSHARP9.background_(Color.black)})},{~gSHARP9.background_(Color.black)}););
/*ASHARP9*/(if(obj.value.linlin(0,1,21,108) <=130,{if(~color_array[130-1]<1,{~aSHARP9.background_(Color(1,~color_array[130-1],~color_array[130-1]));},{~aSHARP9.background_(Color.black)})},{~aSHARP9.background_(Color.black)}););
/*CSHARP10*/(if(obj.value.linlin(0,1,21,108) <=133,{if(~color_array[133-1]<1,{~cSHARP10.background_(Color(1,~color_array[133-1],~color_array[133-1]));},{~cSHARP10.background_(Color.black)})},{~cSHARP10.background_(Color.black)}););
/*DSHARP10*/(if(obj.value.linlin(0,1,21,108) <=135,{if(~color_array[135-1]<1,{~dSHARP10.background_(Color(1,~color_array[135-1],~color_array[135-1]));},{~dSHARP10.background_(Color.black)})},{~dSHARP10.background_(Color.black)}););
/*FSHARP10*/(if(obj.value.linlin(0,1,21,108) <=138,{if(~color_array[138-1]<1,{~fSHARP10.background_(Color(1,~color_array[138-1],~color_array[138-1]));},{~fSHARP10.background_(Color.black)})},{~fSHARP10.background_(Color.black)}););
/*GSHARP10*/(if(obj.value.linlin(0,1,21,108) <=140,{if(~color_array[140-1]<1,{~gSHARP10.background_(Color(1,~color_array[140-1],~color_array[140-1]));},{~gSHARP10.background_(Color.black)})},{~gSHARP10.background_(Color.black)}););
/*ASHARP10*/(if(obj.value.linlin(0,1,21,108) <=142,{if(~color_array[142-1]<1,{~aSHARP10.background_(Color(1,~color_array[142-1],~color_array[142-1]));},{~aSHARP10.background_(Color.black)})},{~aSHARP10.background_(Color.black)}););
/*CSHARP11*/(if(obj.value.linlin(0,1,21,108) <=145,{if(~color_array[145-1]<1,{~cSHARP11.background_(Color(1,~color_array[145-1],~color_array[145-1]));},{~cSHARP11.background_(Color.black)})},{~cSHARP11.background_(Color.black)}););
/*DSHARP11*/(if(obj.value.linlin(0,1,21,108) <=147,{if(~color_array[147-1]<1,{~dSHARP11.background_(Color(1,~color_array[147-1],~color_array[147-1]));},{~dSHARP11.background_(Color.black)})},{~dSHARP11.background_(Color.black)}););
/*FSHARP11*/(if(obj.value.linlin(0,1,21,108) <=150,{if(~color_array[150-1]<1,{~fSHARP11.background_(Color(1,~color_array[150-1],~color_array[150-1]));},{~fSHARP11.background_(Color.black)})},{~fSHARP11.background_(Color.black)}););
/*GSHARP11*/(if(obj.value.linlin(0,1,21,108) <=152,{if(~color_array[152-1]<1,{~gSHARP11.background_(Color(1,~color_array[152-1],~color_array[152-1]));},{~gSHARP11.background_(Color.black)})},{~gSHARP11.background_(Color.black)}););
/*ASHARP11*/(if(obj.value.linlin(0,1,21,108) <=154,{if(~color_array[154-1]<1,{~aSHARP11.background_(Color(1,~color_array[154-1],~color_array[154-1]));},{~aSHARP11.background_(Color.black)})},{~aSHARP11.background_(Color.black)}););


			~dirtyBit = 1;
			/*~dirtyBit.postln;*/


			(if(~dirtyBit > 0, {/*~dirtyBit.postln;*/}, {~freqslider.valueAction_(~fslider.value);}););





			}))
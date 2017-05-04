(
~color_array = Array.fill(200,1);
~color_array[~fslider.value.linlin(0,1,21,108)-1+0]=(~harmonics_array[0]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[0])))-(~manipulated_harmonic[0]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+12]=(~harmonics_array[1]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[1])))-(~manipulated_harmonic[1]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+19]=(~harmonics_array[2]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[2])))-(~manipulated_harmonic[2]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+24]=(~harmonics_array[3]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[3])))-(~manipulated_harmonic[3]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+28]=(~harmonics_array[4]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[4])))-(~manipulated_harmonic[4]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+31]=(~harmonics_array[5]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[5])))-(~manipulated_harmonic[5]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+34]=(~harmonics_array[6]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[6])))-(~manipulated_harmonic[6]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+36]=(~harmonics_array[7]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[7])))-(~manipulated_harmonic[7]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+38]=(~harmonics_array[8]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[8])))-(~manipulated_harmonic[8]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+40]=(~harmonics_array[9]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[9])))-(~manipulated_harmonic[9]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+41]=(~harmonics_array[10]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[10])))-(~manipulated_harmonic[10]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+43]=(~harmonics_array[11]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[11])))-(~manipulated_harmonic[11]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+44]=(~harmonics_array[12]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[12])))-(~manipulated_harmonic[12]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+46]=(~harmonics_array[13]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[13])))-(~manipulated_harmonic[13]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+47]=(~harmonics_array[14]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[14])))-(~manipulated_harmonic[14]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+48]=(~harmonics_array[15]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[15])))-(~manipulated_harmonic[15]*~mulslider.value.linlin(0,1,0,1););



			~color_arrayMAN = Array.fill(200,0);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+0]=~manipulated_harmonic[0];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+12]=~manipulated_harmonic[1];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+19]=~manipulated_harmonic[2];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+24]=~manipulated_harmonic[3];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+28]=~manipulated_harmonic[4];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+31]=~manipulated_harmonic[5];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+34]=~manipulated_harmonic[6];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+36]=~manipulated_harmonic[7];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+38]=~manipulated_harmonic[8];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+40]=~manipulated_harmonic[9];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+41]=~manipulated_harmonic[10];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+43]=~manipulated_harmonic[11];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+44]=~manipulated_harmonic[12];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+46]=~manipulated_harmonic[13];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+47]=~manipulated_harmonic[14];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+48]=~manipulated_harmonic[15];

/*
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+0]=~manipulated_harmonic[0]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+12]=~manipulated_harmonic[1]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+19]=~manipulated_harmonic[2]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+24]=~manipulated_harmonic[3]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+28]=~manipulated_harmonic[4]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+31]=~manipulated_harmonic[5]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+34]=~manipulated_harmonic[6]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+36]=~manipulated_harmonic[7]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+38]=~manipulated_harmonic[8]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+40]=~manipulated_harmonic[9]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+41]=~manipulated_harmonic[10]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+43]=~manipulated_harmonic[11]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+44]=~manipulated_harmonic[12]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+46]=~manipulated_harmonic[13]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+47]=~manipulated_harmonic[14]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+48]=~manipulated_harmonic[15]*0.5*~mulslider.value.linlin(0,1,0,1);
*/
		);


// This macro removes big structures from channel of interest of a xyct data.
//
// Written by hui ting, 25 Nov 2022.


/////////////////////////////////////////////////////////////////////////////////////

channel_of_interest = 4;

/////////////////////////////////////////////////////////////////////////////////////

res_folder = getDirectory("Select results folder");

setBackgroundColor(0, 0, 0);
setOption("BlackBackground", true);

run("Duplicate...", "title=temp duplicate channels="+channel_of_interest);
run("Duplicate...", "duplicate");

run("Gaussian Blur...", "sigma=2 stack");
run("Auto Threshold", "method=Otsu white stack");
setAutoThreshold("Default dark");

setThreshold(100,255);
run("Analyze Particles...", "size=10000-Infinity pixel show=Masks include stack");
run("Invert LUT");

for (i=1;i<=25;i++){
run("Erode", "stack");
}

for (ii=1;ii<=25;ii++){
run("Dilate", "stack");
}

run("32-bit");
run("Mean...", "radius=10 stack");


for (slc=1;slc<=nSlices;slc++){

selectWindow("Mask of temp-1");
setSlice(slc);
setThreshold(10.0000, 255.0000);
run("Create Selection");

selectWindow("temp");
setSlice(slc);
run("Restore Selection");
run("Clear", "slice");

}

run("Select None");

saveAs("Tiff", res_folder+"big_removed.tif");	

run("Close All");	

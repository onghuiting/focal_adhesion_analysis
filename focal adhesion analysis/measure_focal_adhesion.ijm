

// This macro segments and measures focal adhesions.
// This macro uses MorphoLibJ 1.5.1 plugin from: https://github.com/ijpb/MorphoLibJ
//
// Written by hui ting, 25 Nov 2022.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contrast = 50;    // contrast for auto local threshold (Bernsen)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

run("Select None");
run("Set Measurements...", "area mean perimeter fit shape stack display redirect=None decimal=4");

run("Duplicate...", "duplicate");

//run("Subtract Background...", "rolling=70"); //50
setMinAndMax(0, 150);
run("Median...", "radius=2");
run("Conversions...", "scale");

run("8-bit");
total_slices = nSlices;

run("Auto Local Threshold", "method=Bernsen radius=15 parameter_1="+contrast+" parameter_2=0 white stack");

setThreshold(100,255);
run("Analyze Particles...", "size=10-10000 pixel show=Masks exclude include stack");
run("Invert LUT");
mask_name = getTitle;

waitForUser("Edit", "Clear unwanted objects");

for (slc=1;slc<=total_slices;slc++){

selectWindow(mask_name);
setSlice(slc);
run("Distance Transform Watershed", "distances=[Borgefors (3,4)] output=[32 bits] normalize dynamic=1 connectivity=8");
rename(slc);

}

run("Images to Stack");

setThreshold(1.0000, 100000.0000);
run("Analyze Particles...", "size=10-500 pixel show=Masks display exclude clear include summarize add stack");




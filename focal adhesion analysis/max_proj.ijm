

// This macro performs max projection in batch.
//
// Written by hui ting, 25 Nov 2022.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dir = getDirectory("Choose a input folder"); 

res_dir_max = dir+"MAX";
File.makeDirectory(res_dir_max); 

list = getFileList(dir); 
count_file = 1;
for (i=0; i< list.length; i++) {
     
     if (endsWith(list[i], ".nd2")) {
         
         run("Bio-Formats Importer", "open=[" + dir + list[i] + "] color_mode=Default view=Hyperstack stack_order=XYCZT");

         name = getTitle;
         Stack.getDimensions(width, height, channels, slices, frames);
         if (slices>1){
		 run("Z Project...", "projection=[Max Intensity]");
         }
		 saveAs("Tiff", res_dir_max+File.separator+count_file+".tif");	
		 print(count_file+".tif : "+name+"_max");
		 run("Close All");		 
         count_file = count_file+1;
     }
 }








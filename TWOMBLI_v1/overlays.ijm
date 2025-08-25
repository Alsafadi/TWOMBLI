// Step 1: List all TIFF files in a specific directory

inputDir = "C:/Users/ha8343al/GitHub/TWOMBLI/TWOMBLI_v1/OriginalFiles/Eligible/";
pngInput = "C:/Users/ha8343al/GitHub/TWOMBLI/TWOMBLI_v1/Masks/";
outputDir = "C:/Users/ha8343al/GitHub/TWOMBLI/TWOMBLI_v1/overlays/";
fileList = getFileList(inputDir);

// Step 2: Loop through each TIFF file
for (i = 0; i < fileList.length; i++) {
    if (endsWith(fileList[i], ".tif")) {
        // Open the TIFF file
        open(inputDir + fileList[i]);

        // Extract the base name of the TIFF file
        baseName = replace(fileList[i], ".tif", "");

        // Open the PNG file with the same base name
        open(pngInput + baseName + ".png");

        // Apply the red LUT to the PNG file
        run("Invert");
        run("Red");

        // Overlay the PNG file onto the TIFF file
        selectWindow(fileList[i]);
        run("Add Image...", "image=[" + baseName + ".png] x=0 y=0 opacity=100 zero");

        // Save the resulting image as a PNG in a new folder
        outputPath = outputDir + baseName + "_overlay.png";
        saveAs("PNG", outputPath);

        // Close all images to prepare for the next iteration
        close("*");
    }
}
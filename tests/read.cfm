
<!--- read the file from disk --->
<cffile action="readbinary"
	file="#expandPath('forest1.jpg')#"
	variable="binaryData" />
	
<!--- conver the binary image data to base64 --->
<cfset base64Data = ToBase64(binaryData) />

<!--- create the Image Component --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- read the image from a URL --->
<cfset myImage.readFromBase64(base64Data) />

<!--- invert the image --->
<cfset myImage.flipHorizontal() />

<!--- output the image as a png --->
<cfset myImage.writeImage(expandPath("flipedForest.png"), "png") />

<img src="flipedForest.png">
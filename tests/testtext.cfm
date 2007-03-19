<cfset myImage = CreateObject("Component", "Image2.Image") />
<cfset myImage.readImage(expandPath("jai/arches.jpg")) />

<cfset myImage.scaleToFit(100) />

<cfset myImage.writeToBrowser("jpg") />
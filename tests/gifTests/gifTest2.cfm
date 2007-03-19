<cfset mySuperImage = CreateObject("Component", "Image2.SuperImage") />

<cfset mySuperImage.readImage(expandPath("mylogo.png")) />

<cfset mySuperImage.drawImageInCenterBottom(expandPath("watermark.png")) />

<cfset mySuperImage.writeGif(expandPath("myGif.gif")) />

<img src="myGif.gif">
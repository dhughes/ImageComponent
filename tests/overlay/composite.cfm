<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.createImage(500, 375) />
<cfset myImage.setBackgroundColor(myImage.createColor(159, 98, 96)) />
<cfset myImage.clearImage() />


<cfset myImage.setComposite("dstAtop") />
<cfset myImage.drawImage(expandPath("P1010013.JPG"), 0, 0, myImage.getWidth(), myImage.getHeight()) />

<!---
<cfset myImage.grayscale() />
<cfset myImage.drawRectangle(0, 0, myImage.getWidth(), myImage.getHeight()) />
--->

<cfset myImage.writeImage(expandPath("overlay.jpg"), "jpg") />

<img src="overlay.jpg">

<cfdump var="#myImage.getImageMode()#" />

<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(expandPath("forest1.jpg")) />

<!--- adjust this number to control the number of steps in the fade --->
<cfset steps = 20 />
<cfset alpha = 255/steps />

<cfloop from="0" to="#steps#" index="x">
	<cfset white = myImage.createColor(255, 255, 255, 255 - (x*alpha)) />
	<cfset myImage.setStroke(1, white) />
	<!--- draw an empty rectangle --->
	<cfset myImage.drawRectangle(0 + x, 0 + x, myImage.getWidth() - (x*2), myImage.getHeight() - (x*2)) />
</cfloop>




<cfset myImage.writeImage(expandPath("forestFade.jpg"), "jpg") />

<img src="forestFade.jpg">

<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(ExpandPath("img3.jpg")) />
<cfset myImage.adjustLevels(8, 255) />
<cfset myImage.writeImage(ExpandPath("img3_alagad.png"), "png") /> 

<img src="img3.jpg">&nbsp;
<img src="img3_alagad.png">
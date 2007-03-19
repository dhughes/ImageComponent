<!--- create the object --->
<cfset myImage = CreateObject("Component","Image.Image") />

<!--- open a new image --->
<cfset myImage.readImage(expandPath("wineRose.jpg")) />

<!--- set the transparency used when drawing into the image --->
<cfset myImage.setTransparency(25) />

<!--- draw an image into the image --->
<cfset myImage.drawImage(expandPath("logo.png"), 20, 20) />

<!--- output the new image --->
<cfset myImage.writeImage(expandPath("wineRoseLogo.jpg"), "jpg") />

<!--- output the image --->
<b>Result</b><br>
<img src="wineRoseLogo.jpg">

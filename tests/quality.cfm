<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- open image to resize --->
<cfset myImage.readImage(expandPath("snow.jpg"))>

<!--- scale the image to fit in a box --->
<cfset myImage.scaleToBox(225, 190) />

<!--- write the image --->
<cfset myImage.writeImage(expandPath("snowBox.jpg"), "jpg")>

<!--- show the results --->
<p>Before:<br />
<img src="snow.jpg" /></p>

<p>Scaled to fit box:<br />
<img src="snowBox.jpg" /></p>

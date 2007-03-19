<!--- create the object --->
<cfset myImage = CreateObject("Component","Image.Image") />

<!--- read the source GIF image --->
<cfset myImage.readImage(expandPath("shells.jpg")) />

<!--- output the image in PNG format --->
<cfset myImage.writeImage(expandPath("shells.png"), "png") />

<!--- output both images --->
<p>
<b>shells.gif:</b><br>
<img src="shells.jpg">
</p>

<p>
<b>shells.png:</b><br>
<img src="shells.png">
</p>

<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(expandPath("transparentBg.png")) />


<!--- set the font --->
<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 20, "boldItalic") />
 
<!--- create a string to write into the image --->
<cfset myString = "Where the heck is my milk?" />

<cfset myImage.drawSimpleString(myString, 50, 40, timesNewRoman) />

<cfset myImage.writeImage(expandPath("xparent.png"), "png") />


<div style="background-color:#663399 ">
	<img src="xparent.png" />
</div>
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image.Image") />

<!--- open the image to write into --->
<cfset myImage.readImage(expandPath("catAndCup.jpg")) />

<!--- set the font --->
<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 20,  "boldItalic") />

<!--- create a string to write into the image --->
<cfset myString = "Where the heck is my milk?" />

<!---
	Find the metrics (width, height, etc) for the string.
	We will use this to center the string in the image.
--->
<cfset metrics = myImage.getSimpleStringMetrics(myString,  timesNewRoman) />

<!--- determine the X coordinate so we can center the text 
in the image --->
<cfset x = (myImage.getWidth() - metrics.width) / 2 />

<!--- draw the text, centered at the top of the image --->
<cfset myImage.drawSimpleString(myString, x, 30, timesNewRoman) />

<!--- output the new image --->
<cfset myImage.writeImage(expandPath("catCupAndText.jpg"), "jpg") />

<!--- the new image --->
<p>
<b>catCupAndText.jpg:</b><br>
<img src="catCupAndText.jpg"><br>
</p>

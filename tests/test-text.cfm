<cfset component = "Image" />

<!--- create the object --->
<cfset myImage = CreateObject("Component",component) />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\catAndCup.jpg") />

<!--- set the font --->
<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 20, "boldItalic") />

<cfset myString = myImage.createString("this is a test") />

<cfset myImage.setStringFont(myString, "timesNewRoman", 1, 5) />

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
<cfset myImage.writeImage("d:\examples\catCupAndText.jpg", "jpg") />

<!--- the new images --->
<p>
<b>catCupAndText.jpg:</b><br>
<img src="d:\examples\catCupAndText.jpg"><br>
</p>

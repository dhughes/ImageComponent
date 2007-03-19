
<!--- create the image object --->
<cfset myImage = CreateObject("Component", "JavaImage.Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("D:\examples\catAndCup.jpg") />

<!--- set the font --->
<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 20, "boldItalic") />

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
<cfset myImage.drawSimpleString(myString, x, 30, "test") />

<!--- output the new image --->
<cfset myImage.writeImage("D:\examples\catCupAndText.jpg", "jpg") />

<!--- the new images --->
<p>
<b>catCupAndText.jpg:</b><br>
<img src="/examples/catCupAndText.jpg"><br>
</p>

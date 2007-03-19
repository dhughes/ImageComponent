<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />
 
<!--- open the image to write into --->
<cfset myImage.readImage(expandpath("forest1.jpg")) />
 
<!--- set the font --->
<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 90, "boldItalic") />
 
<!--- create a string to write into the image --->
<cfset myString = "Tree" />
 
<!---
      Find the metrics (width, height, etc) for the string.
      We will use this to center the string in the image.
--->
<cfset metrics = myImage.getSimpleStringMetrics(myString, timesNewRoman) />
 
<!--- determine the X coordinate so we can center the text
in the image --->
<cfset x = (myImage.getWidth() - metrics.width) / 2 />

<!--- create a 50% transparent white color --->
<cfset white = myImage.createColor(255, 255, 255, 128) />

<!--- set the fill to use to be the 50% transparent white color --->
<cfset myImage.setFill(white) />

<!--- draw the text, centered at the top of the image --->
<cfset myImage.drawSimpleString(myString, x, 100, timesNewRoman) />
 
<!--- output the new image --->
<cfset myImage.writeImage(expandpath("forest2.jpg"), "jpg") />
 
<!--- the new image --->
<p>
<img src="forest2.jpg"><br>
</p>
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- get the font metrics for the url variable 'text' --->
<cfset fontMetrics = myImage.getSimpleStringMetrics(url.text) />

<!--- create a new image --->
<cfset myImage.createImage(fontMetrics.width + 10, fontMetrics.height + 10) />

<!--- draw a string into the image --->
<cfset myImage.drawSimpleString(url.text, 5, fontMetrics.ascent + 5) />

<!--- write the image to the browser --->
<cfset myImage.writeToBrowser("png") />


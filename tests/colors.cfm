<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- open the image --->
<cfset myImage.readImage("d:\examples\strawberries.jpg") />

<!--- get the color from the upper left pixel --->
<cfset myColor = myImage.getColorFromPixel(1, 1) />

<cfdump var="#myColor#" />
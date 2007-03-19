<!--- 
This example demonstrates some of the path features.
--->
<cfset myImage = CreateObject("Component", "Image2.Image") />

<!--- create some colors --->
<cfset darkGray = myImage.getColorByName("DarkGray") />
<cfset lightblue = myImage.getColorByName("lightblue") />
<cfset darkBlue = myImage.getColorByName("DarkBlue") />
<cfset white = myImage.getColorByName("White") />

<!--- set the image's background color --->
<cfset myImage.setBackgroundColor(darkGray) />

<!--- create a new image --->
<cfset myImage.createImage(400, 400) />

<!--- set the fill and transparency for the shape --->
<cfset myImage.setFill(myImage.createGradient(0,0, 0, 400, lightblue, darkblue)) />
<cfset myImage.setTransparency(80) />

<!--- make a nice heavy stroke --->
<cfset myImage.setStroke(3) />

<!--- create a new path object, setting it's initial point --->
<cfset myPath = myImage.createPath(20, 20) />

<!--- add a strait line --->
<cfset myImage.addPathLine(myPath, 380, 20) />

<!--- add a bezier curve --->
<cfset myImage.addPathBezierCurve(myPath, 380,380, 330,120, 430,280) />

<!--- add another strait line --->
<cfset myImage.addPathLine(myPath, 100, 380) />

<!--- draw a quadratic curve --->
<cfset myImage.addPathQuadraticCurve(myPath, 20,300, 100, 300) />

<!--- add another strait line --->
<cfset myImage.addPathLine(myPath, 20, 20) />

<!--- jump to the center of the shape --->
<cfset myImage.addPathJump(myPath, 100, 100) />

<!--- draw a few more lines --->
<cfset myImage.addPathQuadraticCurve(myPath, 300,300, 100, 300) />
<cfset myImage.addPathLine(myPath, 300, 100) />

<!--- close the path --->
<cfset myImage.closePath(myPath) />

<!--- draw the path --->
<cfset myImage.drawPath(myPath) />

<!--- write the image --->
<cfset myImage.writeImage(expandPath("line.png"), "png") />

<img src="line.png">
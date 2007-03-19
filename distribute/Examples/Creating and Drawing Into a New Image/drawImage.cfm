<!--- create the object --->
<cfset myImage = CreateObject("Component","Image.Image") />

<!--- create some colors --->
<cfset red = myImage.getColorByName("red") />
<cfset yellow = myImage.getColorByName("yellow") />
<cfset green = myImage.getColorByName("green") />
<cfset blue = myImage.getColorByName("blue") />
<cfset orange = myImage.getColorByName("orange") />
<cfset white = myImage.getColorByName("white") />

<!--- set the background color --->
<cfset myImage.setBackgroundColor(red) />

<!--- create a new image --->
<cfset myImage.createImage(200, 200) />

<!--- draw a few shapes into the new image --->
<!--- draw a square --->
<cfset myImage.setFill(yellow) />
<cfset myImage.setStroke(2, green) />
<cfset myImage.drawRectangle(10, 10, 80, 80) />

<!--- draw a circle --->
<cfset myImage.setFill(green) />
<cfset myImage.setStroke(4, blue) />
<cfset myImage.drawOval(110, 10, 80, 80) />

<!--- draw two arcs --->
<cfset myImage.setStroke(2) />
<cfset myImage.setFill(blue) />
<cfset myImage.drawArc(10, 110, 80, 80, 0, 270) />
<cfset myImage.setFill(orange) />
<cfset myImage.drawArc(10, 110, 80, 80, 270, 90) />

<!--- draw another image into this image --->
<cfset myImage.drawImage(expandPath("buy-now.gif"), 110, 110, 80, 80)/>

<!--- output the image in PNG format --->
<cfset myImage.writeImage(expandPath("newImage.png"), "png") />

<!--- the new image --->
<p>
<b>newImage.png:</b><br>
<img src="newImage.png">
</p>

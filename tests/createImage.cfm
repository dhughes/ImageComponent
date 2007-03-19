<!--- create the object --->
<cfset myImage = CreateObject("Component","Encoded.Image") />

<!--- create some colors --->
<cfset white = myImage.getColorByName("gray") />
<cfset black = myImage.getColorByName("black") />

<!--- set the background color --->
<cfset myImage.setBackgroundColor(white) />

<!--- create a new image --->
<cfset myImage.createImage(400, 300) />

<!--- draw an oval --->
<cfset myImage.setFill(black) />
<cfset myImage.drawOval(10, 10, 380, 280) />

<!--- output the image in PNG format --->
<cfset myImage.writeImage("d:\examples\newImage.png", "png") />

<!--- the new image --->
<p>
<b>newImage.png:</b><br>
<img src="/examples/newImage.png">
</p>

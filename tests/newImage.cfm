<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- create some colors --->
<cfset red = myImage.createColor(255,0,0) />
<cfset green = myImage.createColor(0,255,0) />
<cfset blue = myImage.createColor(0,0,255) />
<cfset yellow = myImage.createColor(255,255,0) />
<cfset purple = myImage.createColor(255,0,255) />
<cfset black = myImage.createColor(0,0,0) />

<!--- set the background color --->
<cfset myImage.setBackgroundColor(red) />

<!--- create a new image --->
<cfset myImage.createImage(200, 200) />

<!--- draw four rounded rectanges into the new image --->
<!--- round rectangle 1 --->
<cfset myImage.setFill(green) />
<cfset myImage.setStroke(4, blue) />
<cfset myImage.drawRoundRectangle(10, 10, 80, 80, 50, 50) />

<!--- round rectangle 2 --->
<cfset myImage.setFill(blue) />
<cfset myImage.setStroke(4, yellow) />
<cfset myImage.drawRoundRectangle(110, 10, 80, 80, 50, 30) />

<!--- round rectangle 3 --->
<cfset myImage.setFill(yellow) />
<cfset myImage.setStroke(4, purple) />
<cfset myImage.drawRoundRectangle(10, 110, 80, 80, 30, 50) />

<!--- round rectangle 4 --->
<cfset myImage.setFill(purple) />
<cfset myImage.setStroke(4, black) />
<cfset myImage.drawRoundRectangle(110, 110, 80, 80, 30, 30) />

<!--- output the image in PNG format --->
<cfset myImage.writeImage("d:\examples\newImage.png", "png") />

<!--- the new image --->
<p>
<b>newImage.png:</b><br>
<img src="/examples/newImage.png">
</p>

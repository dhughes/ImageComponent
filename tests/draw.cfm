<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- create some colors --->
<cfset darkgray = myImage.getColorByName("darkGray") />

<!--- set the background color --->
<cfset myImage.setBackgroundColor(darkgray) />

<!--- create a new new image --->
<cfset myImage.createImage(150, 150) />

<!--- draw a circle with a texture fill --->
<cfset texture = myImage.createTexture("d:\examples\bricks.jpg", 0, 0, 60, 60) />
<cfset myImage.setFill(texture) />
<cfset myImage.drawOval(10, 10, 130, 130) />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\texture.png", "png") />

<!--- the new images --->
<p>
<b>Results:</b><br>
<img src="/examples/texture.png">
</p>

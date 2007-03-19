<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- create some colors --->
<cfset red = myImage.createColor(255,0,0,255) />
<cfset black = myImage.createColor(0,0,0,255) />
<cfset yellow = myImage.createColor(255,255,204,255) />

<!--- set the background color --->
<cfset myImage.setBackgroundColor(yellow) />

<!--- create a new image --->
<cfset myImage.createImage(500, 250) />

<CFSET R=32>
<CFSET myImage.setAntiAlias(False) />

<cfset myImage.setFill(red) />
<cfset myImage.setStroke(2, black) />

<cfset myImage.drawOval(10, 10, 200, 200) />

<cfset myImage.drawRoundRectangle(220, 10, 200, 200,R,R) />


<!--- output the image in JPG format --->
<cfset myImage.writeImage(expandPath("newImage.jpg"), "jpg",100) />

<!--- the new image --->
<p>
<b>newImage.jpg:</b><br>
<img src="newImage.jpg">
</p>

<!--- output the image in PNG format --->
<cfset myImage.writeImage(expandPath("newImage.png"), "png") />

<!--- the new image --->
<p>
<b>newImage.png:</b><br>
<img src="newImage.png">
</p>

<!--- create the object --->
<cfset myImage = CreateObject("Component","Image.Image") />

<!--- open the image to resize --->
<cfset myImage.readImage(expandPath("fatherAndSon.jpg")) />

<!--- resize the image to a specific width and height --->
<cfset myImage.scalePixels(100, 100) />

<!--- output the image in JPG format --->
<cfset myImage.writeImage(expandPath("fatherAndSon-small.jpg"), "jpg") />

<!--- the new images --->
<p>
<b>fatherAndSon.jpg:</b><br>
<img src="fatherAndSon.jpg">
</p>
<p>
<b>fatherAndSon-small.jpg:</b><br>
<img src="fatherAndSon-small.jpg">
</p>

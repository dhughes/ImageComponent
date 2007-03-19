<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\strawberries.jpg") />

<!--- set to grayscale ---->
<cfset myImage.grayscale() />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\strawberriesBW.jpg", "jpg") />

<!--- output the images --->
<b>Original</b><br>
<img src="/examples/strawberries.jpg"><Br>
<b>Gray Scale</b><br>
<img src="/examples/strawberriesBW.jpg">

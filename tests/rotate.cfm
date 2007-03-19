
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\georgetown.jpg") />

<!--- set the background color --->
<cfset darkKhaki = myImage.getColorByName("DarkKhaki") />
<cfset myImage.setBackgroundColor(darkKhaki) />

<!--- rotate the image couterclockwise 39 degrees ---->
<cfset myImage.rotate(-39) />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\georgetownRotate.jpg", "jpg") />

<!--- output the images --->
<b>Original</b><br>
<img src="/examples/georgetown.jpg"><Br>
<b>Rotated</b><br>
<img src="/examples/georgetownRotate.jpg">

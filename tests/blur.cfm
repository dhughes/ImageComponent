
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\fuelPump.jpg") />

<!--- blur the image --->
<cfset myImage.blur(3) />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\fuelPumpBlur.jpg", "jpg") />

<!--- output the images --->
<p>
<b>Original</b><br>
<img src="/examples/fuelPump.jpg">
</p>
<p>
<b>Blurred</b><br>
<img src="/examples/fuelPumpBlur.jpg">
</p>
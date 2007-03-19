
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- read the source GIF image --->
<cfset myImage.readImage("d:\examples\buy-now.gif") />

<!--- output the image in PNG format --->
<cfset myImage.writeImage("d:\examples\buy-now.png", "png") />

<!--- output both images --->
<p>
<b>buy-now.gif:</b><br>
<img src="/examples/buy-now.gif">
</p>
<p>
<b>buy-now.png:</b><br>
<img src="/examples/buy-now.png">
</p>
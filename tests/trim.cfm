
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- read the image --->
<cfset myImage.readImage("d:\examples\rotation1.png") />

<!--- trim the image --->
<cfset myImage.trimEdges() />

<!--- write the Image --->
<cfset myImage.writeImage("d:\examples\trim.png", "png") />

<!--- display the image --->
<p><b>Before:</b><br>
<img src="/examples/rotation1.png">
</p>
<p><b>Trimmed:</b><br>
<img src="/examples/trim.png">
</p>

<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\fatherAndSon.jpg") />

<!--- copy a region of the image and move it elsewhere ---->
<cfset myImage.copyRectangleTo(125, 100, 65, 65, -65, -65) />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\fatherAndSon2.jpg", "jpg") />

<!--- output the images --->
<table>
<tr>
	<td>
		<b>Original</b><br>
		<img src="/examples/fatherAndSon.jpg">
	</td>
	<td>
		<b>Region Coppied</b><br>
		<img src="/examples/fatherAndSon2.jpg">
	</td>
</tr>
</table>
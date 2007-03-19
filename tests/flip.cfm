
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\kennelworth3.jpg") />

<!--- find edges ---->
<cfset myImage.flipVertical() />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\kennelworth3Flip.jpg", "jpg") />

<!--- output the images --->
<table>
<tr>
	<td>
		<b>Original</b><br>
		<img src="/examples/kennelworth3.jpg">
	</td>
	<td>
		<b>Flipped</b><br>
		<img src="/examples/kennelworth3Flip.jpg">
	</td>
</tr>
</table>
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\forest1.jpg") />

<!--- lighten the image 50% ---->
<cfset myImage.lighten(50) />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\lightForest.jpg", "jpg") />

<!--- output the images --->
<table>
<tr>
	<td>
		<b>Original</b><br>
		<img src="/examples/forest1.jpg">
	</td>
	<td>
		<b>Lightened</b><br>
		<img src="/examples/lightForest.jpg">
	</td>
</tr>
</table>

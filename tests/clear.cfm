
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\river.jpg") />

<!--- set the background color ---->
<cfset oliveDrab = myImage.getColorByName("OliveDrab") />
<cfset myImage.setBackgroundColor(oliveDrab) />

<!--- clear the image --->
<cfset myImage.clearImage() />

<!--- output the new image --->
<cfset myImage.writeImage("d:\examples\clear.jpg", "jpg") />

<!--- output the images --->
<table>
<tr>
	<td>
		<b>Original</b><br>
		<img src="/examples/river.jpg">
	</td>
	<td>
		<b>Cleared</b><br>
		<img src="/examples/clear.jpg">
	</td>
</tr>
</table>
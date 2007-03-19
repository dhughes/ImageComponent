<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!---// open image to resize (equal width and height) //--->
<cfset myImage.readImage("d:\examples\fatherAndSon.jpg") />

<!--- resize the image to fit a specific width and height --->
<cfset myImage.scaleToFit(100) />

<!--- output the image in JPG format --->
<cfset myImage.writeImage("d:\examples\equalWidthHeight.jpg", "jpg") />

<!---// open image to resize (taller than wide) //--->
<cfset myImage.readImage("d:\examples\catAndCup.jpg") />

<!--- resize the image to fit a specific width and height --->
<cfset myImage.scaleToFit(100) />

<!--- output the image in JPG format --->
<cfset myImage.writeImage("d:\examples\tallerThanWide.jpg", "jpg") />

<!---// open image to resize (wider than tall) //--->
<cfset myImage.readImage("d:\examples\strawberries.jpg") />

<!--- resize the image to fit a specific width and height --->
<cfset myImage.scaleToFit(100) />

<!--- output the image in JPG format --->
<cfset myImage.writeImage("d:\examples\widerThanTall.jpg", "jpg") />


<!--- display the new images --->
<table border="1">
	<tr>
		<td height="100" width="100" align="center" valign="middle">
		<img src="/examples/equalWidthHeight.jpg"></td>
	
		<td height="100" width="100" align="center" valign="middle">
		<img src="/examples/tallerThanWide.jpg"></td>
	
		<td height="100" width="100" align="center" valign="middle">
		<img src="/examples/widerThanTall.jpg"></td>
	</tr>
</table>

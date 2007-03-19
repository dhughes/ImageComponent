
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\shells.jpg") />
<!--- darken the image --->
<cfset myImage.adjustLevels(0, 191) />
<!--- output the lightened version --->
<cfset myImage.writeImage("d:\examples\shells_dark.jpg", "jpg") />

<!--- reopen the image to inspect --->
<cfset myImage.readImage("d:\examples\shells.jpg") />
<!--- lighten the image --->
<cfset myImage.adjustLevels(64, 255) />
<!--- output the lightened version --->
<cfset myImage.writeImage("d:\examples\shells_light.jpg", "jpg") />

<!--- reopen the image to inspect --->
<cfset myImage.readImage("d:\examples\shells.jpg") />
<!--- negate the image --->
<cfset myImage.adjustLevels(255, 0) />
<!--- output the negative version --->
<cfset myImage.writeImage("d:\examples\shells_negative.jpg", "jpg") />

<!--- reopen the image to inspect --->
<cfset myImage.readImage("d:\examples\shells.jpg") />
<!--- lower the image contrast --->
<cfset myImage.adjustLevels(64, 191) />
<!--- output the lowered contrast version --->
<cfset myImage.writeImage("d:\examples\shells_lowContrast.jpg", "jpg") />

<!--- output the images --->
<table>
<tr>
	<td>
		<b>Original</b><br>
		<img src="/examples/shells.jpg">
	</td>
	<td>
		<b>Darkened</b><br>
		<img src="/examples/shells_dark.jpg">
	</td>
</tr>
<tr>
	<td>
		<b>Lightened</b><br>
		<img src="/examples/shells_light.jpg">
	</td>
	<td>
		<b>Negated</b><br>
		<img src="/examples/shells_negative.jpg">
	</td>
</tr>
<tr>
	<td colspan="2">
		<b>Low Contrast</b><br>
		<img src="/examples/shells_lowContrast.jpg">
	</td>
</tr>
</table>
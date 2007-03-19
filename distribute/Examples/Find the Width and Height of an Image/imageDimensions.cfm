<!--- create the object --->
<cfset myImage = CreateObject("Component","Image.Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage(expandPath("georgetown.jpg")) />

<!--- get the width --->
<cfset width = myImage.getWidth() />
<!--- get the height --->
<cfset height = myImage.getHeight() />

<!--- output the image size --->
<p>
<b>georgetown.jpg:</b><br>
<img src="georgetown.jpg"><br>
<cfoutput>
	Width: #width#<br>
	Height: #height#
</cfoutput>
</p>

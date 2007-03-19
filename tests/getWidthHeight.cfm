
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage("d:\examples\georgetown.jpg") />

<!--- get the width --->
<cfset width = myImage.getWidth() />
<!--- get the height --->
<cfset height = myImage.getHeight() />

<!--- the new images --->
<p>
<b>georgetown.jpg:</b><br>
<img src="/examples/georgetown.jpg"><br>
<cfoutput>
	Width: #width#<br>
	Height: #height#
</cfoutput>
</p>
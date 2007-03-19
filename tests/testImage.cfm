<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(ExpandPath("test_fade_start.png")) />

<cfset myImage.writeToBrowser("png") />
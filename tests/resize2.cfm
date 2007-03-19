<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(expandPath("fire.jpg")) />
<cfset myImage.scaleWidth(156) />
<cfset myImage.writeImage(expandPath("foobar.jpg"), "jpg") />

<img src="foobar.jpg" />

<cfdump var="#myImage.getVersion()#" />
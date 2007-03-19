
<cfset folder = "d:\Inetpub\Alagad Image Component\2\tests\" />

<cfset myImage = CreateObject("Component", "Image2.Image") />


<cfset red = myImage.createColor(255,0,0) />

<cfset myImage.setBackgroundColor(red) />
<cfset myImage.readImage("#folder#1.jpg") />

<cfset myImage.setImageSize(650, 650, "middleCenter")>
 
<cfset myImage.writeImage(expandPath("resized2.jpg"), "jpg") />

<img src="resized2.jpg"> 
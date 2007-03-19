<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(expandPath("DougSource.jpg")) />

<cfset myImage.writeImage(expandPath("Compressed10.jpg"), "jpg", 10) />
<cfset myImage.writeImage(expandPath("Compressed50.jpg"), "jpg", 50) />
<cfset myImage.writeImage(expandPath("Compressed100.jpg"), "jpg", 100) />

done
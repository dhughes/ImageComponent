<cfset myImage = CreateObject("Component","Image2.Image") />	

<cfset myImage.readImage(expandPath("testImage.jpg"), "rgb") />

<!---
Temp file created when this function is called
--->
<cfset font =  myImage.loadTTFFile(expandPath("arial.ttf"), "12", "plain")>

<cfset font = 0 />
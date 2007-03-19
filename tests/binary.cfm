<cffile action="readbinary" file="#expandPath("mylogo.png")#" variable="data" />

<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImageFromUrl("http://www.doughughes.net/images/logo.gif") />

<!---<cfset myImage.readImage(expandPath("mylogo.png")) />

<cfset imageData = myImage.writeImage(expandPath("foobar.jpg"), "jpg") />

<img src="foobar.jpg" />--->
<!---<cfset context = GetPageContext() />


<cfdump var="#getClass()#" /><cfabort>

<cfabort />
--->
<cfset myImage = CreateObject("Component", "image2.image") />

<cfset myImage.readImage(expandPath("Coverimage.jpg")) />

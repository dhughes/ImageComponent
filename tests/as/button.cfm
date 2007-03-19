<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- open an image to inspect --->
<cfset myImage.readImage(expandPath("lowColor.gif")) />

<!--- output the mode --->
<cfoutput>
#myImage.getImageMode()#
</cfoutput>
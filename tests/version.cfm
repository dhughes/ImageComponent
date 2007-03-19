<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />
<!--- get the version info --->
<cfdump var="#myImage.getVersion()#">

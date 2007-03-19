<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />

<!--- dump the system fonts --->
<cfdump var="#myImage.getSystemFonts()#">

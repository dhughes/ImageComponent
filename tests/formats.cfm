<cfset myImage = CreateObject("Component","image") />

<cfdump var="#myImage.getReadableFormats()#">
<br>
<cfdump var="#myImage.getWritableFormats()#">
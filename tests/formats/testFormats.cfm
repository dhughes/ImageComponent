<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(expandPath("DougSource.jpg")) />

<cfloop list="#myImage.getWritableFormats()#" index="format">
	<cfoutput>#format#</cfoutput><cfflush>
	<cfif format IS NOT "wbmp" and format is not "jpeg2000" and format is not "jpeg 2000">
		<cfset myImage.writeImage(expandPath("test.#format#"), format) />
	</cfif>
<br><br>
</cfloop>
DONE!!
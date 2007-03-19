<cfset myImage = CreateObject("Component", "Image2.Image") />
<cfset myImage.readImage(expandPath("arches.jpg")) />

<cfset formats = myImage.getWritableFormats() />

<cfloop list="#formats#" index="format">
	<cfoutput>
	<p>Writing format #format#</p>
	</cfoutput>
	<cfif format IS "wbmp">
		<cfset myImage.setImageMode("Binary") />
	</cfif>
	<cfset myImage.writeImage(expandPath("test.#format#"), format) />
	<cfif format IS "wbmp">
		<cfset myImage.readImage(expandPath("arches.jpg")) />
	</cfif>
</cfloop>


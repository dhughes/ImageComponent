<cfset Image = CreateObject("java", "java.awt.image.BufferedImage") />
<cfset Image.init( 100, 100, Image.TYPE_4BYTE_ABGR ) />

<cfdump var="#Image#">
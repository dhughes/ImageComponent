<cfset myImage = CreateObject("Component", "Image2.Image") />
<cfset myImage.readImage(expandPath("snow.jpg")) />

<cfoutput>
<p><b>Full size:</b>
#myImage.getSize("jpg")# Bytes</p>
</cfoutput>

<cfset myImage.scaleHeight(100) />

<cfoutput>
<p><b>100 pixels tall:</b>
100% - #myImage.getSize("jpg")# Bytes</p>
</cfoutput>
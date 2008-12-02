

<!--- create the object --->

<cfset myImage = CreateObject("Component","image") />

 
<!--- read the source GIF image --->

<cfset myImage.readImage("\\fbowltrandom\massagemosaics\buttonOff.gif") />


<cfoutput>
<p><b>Get Size:</b> #myImage.getSize("jpg")# Bytes</p>
</cfoutput>

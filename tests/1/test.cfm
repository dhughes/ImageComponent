 <cfset myImage = CreateObject('Component', 'Image2.Image').setKey('TB8HG-Y2G0A-JK49C-FX1RM-79NGF') />
                                                                                                                       
                                                                                                                        
<!--- open the image to resize ---> 
<cfset myImage.readImage(expandpath("DSC00969.JPG")) /> 
                                                                                                                        
<!--- resize the image to a specific width--->
<!--- get the width ---> 
<cfset width = myImage.getWidth()> 
<cfset height = myImage.getHeight()> 
																														
<cfset max_width = 800>
																														
<cfif width GT max_width>
	<cfset myImage.scaleWidth(max_width) />
	<cfset height = round(height * max_width / width)>
	<cfset width = max_width>
</cfif>
																														
<cfset myImage.writeImage(expandpath("DSC00969-small.JPG"), "jpg", 90) />

<img src="DSC00969.JPG" />
<img src="DSC00969-small.JPG" />
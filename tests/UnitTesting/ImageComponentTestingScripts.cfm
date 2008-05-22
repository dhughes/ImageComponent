<!------------------------------------------------------------------------------
Source Code Copyright © 2004 Alagad, Inc. www.alagad.com

  Application: Alagad Image Component 
  Supported CF Version: CF MX, MX 6.1, BlueDragon 6.1 JX
  File Name: text.cfm
  CFC Component Name: N/A
  Created By: Doug Hughes (alagad@alagad.com)
  Created Date: 06/21/2004
  Description: I am a set of test for all of the Image Component methods.

Version History:
  
  mm/dd/yyyy	Author		Comments
  06/21/2004	D.Hughes	Created  

Comments:

  mm/dd/yyyy	Author		Comment
  
To Do:

  mm/dd/yyyy	Comment
  
------------------------------------------------------------------------------->


<!--- <cfset request.imagePath = "D:\BlueDragon_Server_61\wwwroot\examples\" /> --->
<cfset imageComponent = "Image2.Image" />
<cfset request.error = false />
<cfset request.errorMessage = "" />
<cfset request.image1 = "forest1.jpg" />
<cfset request.ttfFile = expandPath("georgia.ttf") />
<cfset request.imageCount = 0 />
<cfset row = 1 />

<!--- method to add table rows --->
<cffunction name="addResults" returntype="void" output="true">
	<cfargument name="method" type="string">
	<cfargument name="error" type="boolean">
	<cfargument name="cfcatch" type="any" required="no" default="">
	<cfargument name="image" type="any" required="no" default="">
	<cfargument name="results" type="any" required="no" default="">
	
	<cfset var bgcolor = "" />

	<cfif error IS "Yes">
		<cfset bgcolor = "ffdddd" />
	<cfelseif row mod 2 IS 1>
		<cfset bgcolor = "ffffff" />
	<cfelse>
		<cfset bgcolor = "dddddd" />
	</cfif>
	
	<cfoutput>
		<tr style="background-color: #bgcolor# ">
			<td nowrap>
				#arguments.method#
			</td>
			<td width="100%">
				<cfif error IS "Yes">
					<cfdump var="#cfcatch#">
				<cfelse>
					Success
				</cfif>
			</td>
			<td>
				<cfif NOT error AND image IS NOT "">
					<img src="#image#">
				<cfelseif image IS "">
					&nbsp;
				<cfelse>
					Error occured
				</cfif>
				
				<cfif NOT IsSimpleValue(arguments.results) OR (IsSimpleValue(arguments.results) AND Len(arguments.results))>
					<cfdump var="#arguments.results#" />
				</cfif>
			</td>
		</td>
	</cfoutput>
	
	<cfset request.error = false />
	<cfset request.errorMessage = "" />
	
	<cfset row = row + 1 />
	<cfflush><cfflush>
</cffunction>

<!--- function for a table row --->
<cffunction name="addHeaderRow" returntype="void" output="true">
	<cfargument name="name" type="string">
	<cfoutput>
		<tr><td colspan="3" style="background-color: ##0099FF;"><p style="font-size: 18px; font-weight: bold; color: ##FFFFFF">#arguments.name#</p></td></tr>
	</cfoutput>
</cffunction>

<!--- function to get the next image name --->
<cffunction name="nextImage" returntype="string" output="true">
	<cfset request.imageCount = request.imageCount + 1 />
	<cfreturn "#request.imageCount##request.image1#" />
</cffunction>

<!--- output the version --->
<cfset myImage = CreateObject("Component", "#imageComponent#") />
<cfdump var="#myImage.getVersion()#">

<table width="100%" cellpadding="3" cellspacing="0" border="1">
	<tr>
		<td style="font-weight: bold">
			Method
		</td>
		<td style="font-weight: bold">
			Error
		</td>
		<td style="font-weight: bold">
			Results
		</td>	
	</tr>
	
	<cfset addHeaderRow("Working with Images and Image Files") />
	
	<!--- create the image component --->
	<cftry>
		<cfset method = "creating the object" />
		<cfset image = "" />
		
		<cfset myImage = CreateObject("Component", "#imageComponent#") />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image )#
	</cfoutput>
	
	<!--- createImage() ---->
	<cftry>
		<cfset method = "createImage()" />
		<cfset image = "newImage.png" />
		
		<cfset myImage.createImage(30,30, "rgb") />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	<!--- readImageFromURL() --->
	<cftry>
		<cfset method = "readImageFromURL()" />
		<cfset image = request.image1 />
		<cfset image2 = nextImage() />
		
		<cfset myImage.readImageFromURL("http://aic/UnitTesting/#request.image1#") />
		<cfset myImage.writeImage(ExpandPath(image2), ListLast(image2, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image2)#
	</cfoutput>
	
	<!--- writeToBase64() --->
	<cftry>
		<cfset method = "writeToBase64()" />
		<cfset image = "" />
		<cfset base64Data = "" />
		
		<cfset base64Data = myImage.writeToBase64("png") />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image, base64Data)#
	</cfoutput>
	
	
	<!--- readFromBase64() --->
	<cftry>
		<cfset method = "readFromBase64()" />
		<cfset image = nextImage() />
		
		<cfset myImage.readFromBase64(base64Data) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>

	
	<!--- readImage() --->
	<cftry>
		<cfset method = "readImage()" />
		<cfset image = request.image1 />
		<cfset image2 = nextImage() />
		
		<cfset myImage.readImage(ExpandPath(image)) />
		<cfset myImage.writeImage(ExpandPath(image2), ListLast(image2, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image2)#
	</cfoutput>
	
	
 	<!--- writeToBrowser() --->
	<cftry>
		<cfset method = "writeToBrowser()<Br>Calls testImage.cfm inside an img tag." />
		<cfset image = nextImage() />
		
		<cfoutput>
			#addResults(method, request.error, request.errorMessage, "testImage.cfm")#
		</cfoutput>
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>	
	
		
 	<!--- writeImage() --->
	<cftry>
		<cfset method = "writeImage()" />
		<cfset image = nextImage() />
		
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- getReadableFormats() --->
	<cftry>
		<cfset method = "getReadableFormats()" />
		<cfset image = "" />
		
		<cfset formats = myImage.getReadableFormats() />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image, formats)#
	</cfoutput>
	
	
	<!--- getWritableFormats() --->
	<cftry>
		<cfset method = "getWritableFormats()" />
		<cfset image = "" />
		
		<cfset formats = myImage.getWritableFormats() />
		
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image, formats)#
	</cfoutput>
	
	<cfset addHeaderRow("Image Size Methods") />
	
	
	<!--- crop() --->
	<cftry>
		<cfset method = "crop()" />
		<cfset image = nextImage() />
		
		<cfset myImage.crop(100, 100, 50, 50) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- scaleHeight() --->
	<cftry>
		<cfset method = "scaleHeight()" />
		<cfset image = nextImage() />
		
		<cfset myImage.scaleHeight(150) />
		
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- scaleWidth() --->
	<cftry>
		<cfset method = "scaleWidth()" />
		<cfset image = nextImage() />
		
		<cfset myImage.scaleWidth(200) />
		
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- scalePercent() --->
	<cftry>
		<cfset method = "scalePercent()" />
		<cfset image = nextImage() />
		
		<cfset myImage.scalePercent(400,300) />
		
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- scalePixels() --->
	<cftry>
		<cfset method = "scalePixels()" />
		<cfset image = nextImage() />
		
		<cfset myImage.scalePixels(150,150) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setImageSize() --->
	<cftry>
		<cfset method = "setImageSize()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setImageSize(220,200) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- trimEdges() --->
	<cftry>
		<cfset method = "trimEdges()" />
		<cfset image = nextImage() />
		
		<cfset myImage.trimEdges("bottomRight") />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
		
	<!--- getHeight() --->
	<cftry>
		<cfset method = "getHeight()" />
		<cfset image = "" />
		
		<cfset size = myImage.getHeight() />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image, size)#
	</cfoutput>
	
	
	<!--- getWidth() --->
	<cftry>
		<cfset method = "getWidth()" />
		<cfset image = "" />
		
		<cfset size = myImage.getWidth() />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image, size)#
	</cfoutput>
	
	
	<cfset addHeaderRow("Manipulating Image Data") />
	
	
	<!--- adjustLevels() --->
	<cftry>
		<cfset method = "adjustLevels()" />
		<cfset image = nextImage() />
		
		<cfset myImage.adjustLevels(255, 0) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- blur() --->
	<cftry>
		<cfset method = "blur()" />
		<cfset image = nextImage() />
		
		<cfset myImage.blur(5) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- clearImage() --->
	<cftry>
		<cfset method = "clearImage()" />
		<cfset image = nextImage() />
		
		<cfset myImage.clearImage() />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		<!--- I've got to reload the inital image now, as this was cleared --->
		<cfset myImage.readImage(ExpandPath(request.image1)) />		
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!---- clearRectangle() --->
	<cftry>
		<cfset method = "clearRectangle()" />
		<cfset image = nextImage() />
		
		<cfset myImage.clearRectangle(50, 50, 20, 20) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!---- copyRectangleTo() --->
	<cftry>
		<cfset method = "copyRectangleTo()" />
		<cfset image = nextImage() />
		
		<cfset myImage.copyRectangleTo(15, 15, 50, 50, 100, 100) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- darken() --->
	<cftry>
		<cfset method = "darken()" />
		<cfset image = nextImage() />
		
		<cfset myImage.darken(50) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		<!--- I'm reloading the initial image because the image has been darkened --->
		<cfset myImage.readImage(ExpandPath(request.image1)) />		
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- emboss() --->
	<cftry>
		<cfset method = "emboss()" />
		<cfset image = nextImage() />
		
		<cfset myImage.emboss(1, 1) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- findEdges() --->
	<cftry>
		<cfset method = "findEdges()" />
		<cfset image = nextImage() />
		
		<cfset myImage.findEdges(1, 25) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- flipHorizontal() --->
	<cftry>
		<cfset method = "flipHorizontal()" />
		<cfset image = nextImage() />
		
		<cfset myImage.flipHorizontal() />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- flipVertical() --->
	<cftry>
		<cfset method = "flipVertical()" />
		<cfset image = nextImage() />
		
		<cfset myImage.flipVertical() />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- grayScale() --->
	<cftry>
		<cfset method = "grayScale()" />
		<cfset image = nextImage() />
		
		<cfset myImage.grayScale() />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- lighten() --->
	<cftry>
		<cfset method = "lighten()" />
		<cfset image = nextImage() />
		
		<cfset myImage.lighten(50) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		<!--- I'm reloading the initial image because the image has been lightened --->
		<cfset myImage.readImage(ExpandPath(request.image1)) />		
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- negate() --->
	<cftry>
		<cfset method = "negate()" />
		<cfset image = nextImage() />
		
		<cfset myImage.negate() />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		<!--- I'm reloading the initial image because the image has been negated --->
		<cfset myImage.readImage(ExpandPath(request.image1)) />		
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- rotate() --->
	<cftry>
		<cfset method = "rotate()" />
		<cfset image = nextImage() />
		
		<cfset myImage.rotate(90, true) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- sharpen() --->
	<cftry>
		<cfset method = "sharpen()" />
		<cfset image = nextImage() />
		
		<cfset myImage.sharpen(2, 25) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<cfset addHeaderRow("Drawing on Images") />
	
	
	<!--- drawArc() --->
	<cftry>
		<cfset method = "sharpen()" />
		<cfset image = nextImage() />
		
		<cfset lemonChiffon = myImage.getColorByName("LemonChiffon") />
		<cfset myImage.setStroke(3) />
		<cfset myImage.setFill(lemonChiffon) />
		<cfset myImage.drawArc(50, 50, 50, 50, 90, 180) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- drawImage() --->
	<cftry>
		<cfset method = "drawImage()" />
		<cfset image = nextImage() />
		
		<cfset myImage.drawImage(ExpandPath(request.image1), 50, 50, 50, 50) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- drawLine() --->
	<cftry>
		<cfset method = "drawLine()" />
		<cfset image = nextImage() />
		
		<cfset myImage.drawLine(50, 50, 150, 150) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- drawOval() --->
	<cftry>
		<cfset method = "drawOval()" />
		<cfset image = nextImage() />
		
		<cfset myImage.drawOval(50, 50, 150, 150) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- drawRectangle() --->
	<cftry>
		<cfset method = "drawRectangle()" />
		<cfset image = nextImage() />
		
		<cfset myImage.drawRectangle(50, 50, 150, 150) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	<!--- drawRoundRectangle() --->
	<cftry>
		<cfset method = "drawRoundRectangle()" />
		<cfset image = nextImage() />
		
		<cfset myImage.drawRoundRectangle(60, 60, 130, 130, 40, 40) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<cfset addHeaderRow("Drawing Polygons on Images") />
	
	
	<!--- createPolygon(), addPolygonPoint(), drawPolygon() --->
	<cftry>
		<cfset method = "createPolygon()<br>addPolygonPoint()<br>drawPolygon()" />
		<cfset image = nextImage() />
		
		<cfset myPolygon = myImage.createPolygon() />
		<cfset myImage.addPolygonPoint(myPolygon, 10, 10) />
		<cfset myImage.addPolygonPoint(myPolygon, 45, 10) />
		<cfset myImage.addPolygonPoint(myPolygon, 10, 45) />
		<cfset myImage.drawPolygon(myPolygon) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<cfset addHeaderRow("Drawing Simple Text on Images") />
	
	
	<!--- drawSimpleString() --->
	<cftry>
		<cfset method = "drawSimpleString()" />
		<cfset image = nextImage() />
		
		<cfset black = myImage.getColorByName("black") />
		<cfset myImage.setFill(black) />
		<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 50, "boldItalic") />
		<cfset myImage.drawSimpleString("This is a test", 10, 50, timesNewRoman) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- getSimpleStringMetrics() --->
	<cftry>
		<cfset method = "getSimpleStringMetrics()" />
		<cfset image = nextImage() />
		
		<cfset metrics = myImage.getSimpleStringMetrics("This is a test", timesNewRoman) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", metrics)#
	</cfoutput>
	
	
	<cfset addHeaderRow("Drawing Advanced Text on Images") />
	
	
	<!--- createString() --->
	<cftry>
		<cfset method = "createString()" />
		<cfset image = nextImage() />
		
		<cfset myString = myImage.createString("It was a dark and stormy night.") />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "")#
	</cfoutput>
		
	<!--- drawString() --->
	<cftry>
		<cfset method = "drawString()" />
		<cfset image = nextImage() />
		
		<cfset myImage.drawString(myString, 80, 80) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- getStringMetrics() --->
	<cftry>
		<cfset method = "getSimpleStringMetrics()" />
		<cfset image = nextImage() />
		
		<cfset metrics = myImage.getStringMetrics(myString) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", metrics)#
	</cfoutput>
	
	
	<!--- setStringBackground() --->
	<cftry>
		<cfset method = "setStringBackground()" />
		<cfset image = nextImage() />
		
		<cfset blue = myImage.getColorByName("blue") />
		<cfset myImage.setStringBackground(myString, blue, 0, 10) />
		<cfset myImage.drawString(myString, 80, 80) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringDirection() --->
	<cftry>
		<cfset method = "setStringDirection()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStringDirection(myString, "rtl", 0, 10) />
		<cfset myImage.drawString(myString, 80, 80) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringFamily() --->
	<cftry>
		<cfset method = "setStringFamily()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStringFamily(myString, "Times New Roman", 0, 10) />
		<cfset myImage.drawString(myString, 80, 80) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringFont() --->
	<cftry>
		<cfset method = "setStringFont()" />
		<cfset image = nextImage() />
		
		<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 50, "boldItalic") />
		<cfset myImage.setStringFont(myString, timesNewRoman, 0, 10) />
		<cfset myImage.drawString(myString, 20, 80) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringForeground() --->
	<cftry>
		<cfset method = "setStringForeground()" />
		<cfset image = nextImage() />
		
		<cfset red = myImage.getColorByName("red") />
		<cfset myImage.setStringForeground(myString, red, 0, 10) />
		<cfset myImage.drawString(myString, 20, 80) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	<!--- setStringSize() --->
	<cftry>
		<cfset method = "setStringSize()" />
		<cfset image = nextImage() />
		
		<!--- I'm creating a new advanced string because the setStringFont settings override the setStringSize settings --->
		<cfset myString2 = myImage.createString("It was a dark and stormy night.") />
		<cfset myImage.setStringSize(myString2, 40, 0, 10) />
		<cfset myImage.drawString(myString2, 20, 150) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringStrikeThrough() --->
	<cftry>
		<cfset method = "setStringStrikeThrough()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStringStrikeThrough(myString2, true, 0, 10) />
		<cfset myImage.drawString(myString2, 20, 150) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringUnderline() --->
	<cftry>
		<cfset method = "setStringUnderline()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStringUnderline(myString2, "on", 0, 10) />
		<cfset myImage.drawString(myString2, 20, 150) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringPosture() --->
	<cftry>
		<cfset method = "setStringPosture()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStringPosture(myString2, "oblique", 0, 10) />
		<cfset myImage.drawString(myString2, 20, 180) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringWeight() --->
	<cftry>
		<cfset method = "setStringWeight()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStringWeight(myString2, "bold", 0, 10) />
		<cfset myImage.drawString(myString2, 20, 200) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStringWidth() --->
	<cftry>
		<cfset method = "setStringWidth()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStringWidth(myString2, "condensed", 0, 10) />
		<cfset myImage.drawString(myString2, 20, 200) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- getSystemFonts() --->
	<cftry>
		<cfset method = "getSystemFonts()" />
		<cfset image = nextImage() />
		
		<cfset fontArray = myImage.getSystemFonts() />
				
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", fontArray)#
	</cfoutput>
	
	
	<!--- loadSystemFont() --->
	<cftry>
		<cfset method = "loadSystemFont()" />
		<cfset image = nextImage() />
		
		<cfset myFont = myImage.loadSystemFont(fontArray[1], 40, "Italic") />
				
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", myFont)#
	</cfoutput>
	
	
	<!--- loadTTFFile() --->
	<cftry>
		<cfset method = "loadTTFFile()" />
		<cfset image = nextImage() />
		
		<cfset myFont = myImage.loadTTFFile(request.ttfFile, 40, "Italic") />
				
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", myFont)#
	</cfoutput>
	
	
	<cfset addHeaderRow("Component Properties") />
	
	
	<!--- reset() --->
	<cftry>
		<cfset method = "reset()" />
		<cfset image = nextImage() />
		
		<cfset blue = myImage.getColorByName("blue") />
		<cfset red = myImage.getColorByName("red") />
		<cfset myImage.setComposite("srcOver") />
		<cfset myImage.setShear(10, 10) />
		<cfset myImage.setRotation(20) />
		<cfset myImage.setFill(blue) />
		<cfset myImage.setStroke(5, blue) />
		<cfset myImage.setBackgroundColor(red) />
		<cfset myImage.setTransparency(50) />
		<cfset myImage.reset() />
		<cfset myImage.drawOval(50,50,100,100) />
		<cfset myImage.clearRectangle(10, 10, 20, 20) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- resetBackgroundColor() --->
	<cftry>
		<cfset method = "resetBackgroundColor()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setBackgroundColor(red) />
		<cfset myImage.resetBackgroundColor() />
		<cfset myImage.clearRectangle(20, 20, 20, 20) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- resetComposite() --->
	<cftry>
		<cfset method = "resetComposite()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setComposite("dstOver") />
		<cfset myImage.resetComposite() />
		<cfset myImage.drawOval(60,60,100,100) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- resetFill() --->
	<cftry>
		<cfset method = "resetFill()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setFill(blue) />
		<cfset myImage.resetFill() />
		<cfset myImage.drawOval(60,60,100,100) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- resetRotation() --->
	<cftry>
		<cfset method = "resetRotation()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setRotation(10) />
		<cfset myImage.resetRotation() />
		<cfset myImage.drawOval(10,10,40,20) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- resetShear() --->
	<cftry>
		<cfset method = "resetShear()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setShear(10, 10) />
		<cfset myImage.resetShear() />
		<cfset myImage.drawOval(20,20,60,30) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- resetStroke() --->
	<cftry>
		<cfset method = "resetStroke()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setStroke(10) />
		<cfset myImage.resetStroke() />
		<cfset myImage.drawOval(40,40,60,30) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- resetTransparency() --->
	<cftry>
		<cfset method = "resetTransparency()" />
		<cfset image = nextImage() />
		
		<cfset myImage.setTransparency(40) />
		<cfset myImage.resetTransparency() />
		<cfset myImage.drawOval(60,60,60,60) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setBackgroundColor() --->
	<cftry>
		<cfset method = "setBackgroundColor()" />
		<cfset image = nextImage() />
		
		<cfset myImage.reset() />
		<cfset myImage.setBackgroundColor(red) />
		<cfset myImage.clearRectangle(20, 20, 20, 20) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setComposite() --->
	<cftry>
		<cfset method = "setComposite()" />
		<cfset image = nextImage() />
		
		<cfset myImage.reset() />
		<cfset myImage.setComposite("dstOver") />
		<cfset myImage.drawOval(60,60,100,100) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setFill() --->
	<cftry>
		<cfset method = "setFill()" />
		<cfset image = nextImage() />
		
		<cfset myImage.reset() />
		<cfset myImage.setFill(blue) />
		<cfset myImage.drawOval(60,60,100,100) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setRotation() --->
	<cftry>
		<cfset method = "setRotation()" />
		<cfset image = nextImage() />
		
		<cfset myImage.reset() />
		<cfset myImage.setRotation(10) />
		<cfset myImage.drawOval(10,10,40,20) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setShear() --->
	<cftry>
		<cfset method = "setShear()" />
		<cfset image = nextImage() />
		
		<cfset myImage.reset() />
		<cfset myImage.setShear(10, 10) />
		<cfset myImage.drawOval(20,20,60,30) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setStroke() --->
	<cftry>
		<cfset method = "setStroke()" />
		<cfset image = nextImage() />
		
		<cfset myImage.reset() />
		<cfset myImage.setStroke(10, red, "butt", "bevel", 5, 10, 10) />
		<cfset myImage.drawOval(40,40,60,30) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<!--- setTransparency() --->
	<cftry>
		<cfset method = "setTransparency()" />
		<cfset image = nextImage() />
		
		<cfset myImage.reset() />
		<cfset myImage.setStroke(10) />
		<cfset myImage.setTransparency(50) />
		<cfset myImage.drawOval(60,60,60,60) />
		<cfset myImage.writeImage(ExpandPath(image), ListLast(image, ".")) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, image)#
	</cfoutput>
	
	
	<cfset addHeaderRow("Component Properties") />
	
	
	<!--- createColor() --->
	<cftry>
		<cfset method = "createColor()" />
		<cfset image = nextImage() />
		
		<cfset myColor = myImage.createColor(255, 0, 255, 128) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", myColor)#
	</cfoutput>
	
	
	<!--- createGradient() --->
	<cftry>
		<cfset method = "createGradient()" />
		<cfset image = nextImage() />
		
		<cfset blue = myImage.getColorByName("blue") />
		<cfset red = myImage.getColorByName("red") />
		<cfset myGradient = myImage.createGradient(1, 1, 200, 200, red, blue) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", myGradient)#
	</cfoutput>
	
	
	<!--- createTexture() --->
	<cftry>
		<cfset method = "createTexture()" />
		<cfset image = nextImage() />
		
		<cfset myTexture = myImage.createTexture(expandPath("arlonjanis2008366770522.gif"), 1, 1, 200, 200) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", myTexture)#
	</cfoutput>
	
	
	<!--- getColorByName() --->
	<cftry>
		<cfset method = "getColorByName()" />
		<cfset image = nextImage() />
		
		<cfset myColor = myImage.getColorByName("green") />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", myColor)#
	</cfoutput>
	
	
	<!--- getColorFromPixel() --->
	<cftry>
		<cfset method = "getColorFromPixel()" />
		<cfset image = nextImage() />
		
		<cfset myColor = myImage.getColorFromPixel(50, 50) />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", myColor)#
	</cfoutput>
	
	
	<!--- getColorList() --->
	<cftry>
		<cfset method = "getColorList()" />
		<cfset image = nextImage() />
		
		<cfset colorList = myImage.getColorList() />
		
		<cfcatch> 
			<cfset request.error = true />
			<cfset request.errorMessage = cfcatch />
		</cfcatch>
	</cftry>
	<cfoutput>
		#addResults(method, request.error, request.errorMessage, "", ListToArray(colorList))#
	</cfoutput>
</table>


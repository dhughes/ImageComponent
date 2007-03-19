<!------------------------------------------------------------------------------
Source Code Copyright © 2003 Alagad, Inc. www.alagad.com

  Application: Image 
  Supported CF Version: CF MX
  File Name: Image.cfc
  CFC Component Name: Image
  Created By: Doug Hughes
  Created Date: 05/10/2004
  Description: I am a CFC which can be used to create and edit images.

Version History:
  
  mm/dd/yyyy	Author		Comments
  05/10/2004	D.Hughes	Created
  05/12/2004	D.Hughes	Added scalePixels and scalePercent as well as the private method scale called by both.
  
Comments:

  mm/dd/yyyy	Author		Comment
  05/10/2004	D. Hughes	Variables which start with upper case letters are objects, lowercase are primitives.  
  05/10/2004	D.Hughes	Some getter/setter methods for java objects have a type of "any".  This is because specifying the java class name does not work in CF.
  
------------------------------------------------------------------------------->
<cfcomponent displayname="Image" hint="I am a CFC which can be used to create and edit images." output="no">
	<!--- // -- // -- // -- // -- // -- // -- // -- // ---- 
	//
	//		instance variables (And init)
	//
	----- // -- // -- // -- // -- // -- // -- // -- // --->
	<!--- Image: 			I am the image we're working with --->
	<cfset variables.Image = createObject("java", "java.awt.image.BufferedImage") />
	<!--- ImageIO: 			I am used to read, write and create images --->
	<cfset variables.ImageIO = CreateObject("Java", "javax.imageio.ImageIO") />
	<!--- typeList:			I hold a list of image types supported --->
	<cfset variables.typeList = "gray,rgb,argb" />
	
	<!--- init --->
	<cffunction name="init" access="public" output="false" returntype="Image" hint="I am a constructor for the Image CFC.">
		<cfreturn this />
	</cffunction>

	<!--- // -- // -- // -- // -- // -- // -- // -- // ---- 
	//
	//		public methods
	//
	----- // -- // -- // -- // -- // -- // -- // -- // --->
	<!--- CreateImage --->
	<cffunction name="createImage" access="public" output="false" returntype="void" hint="I create a new image.">
		<cfargument name="width" hint="I am the width of the image to create" required="yes" type="numeric" />
		<cfargument name="height" hint="I am the height of the image to create" required="yes" type="numeric" />
		<cfargument name="type" hint="I am the type of image to create" default="rgb" required="no" type="string" />
		<cfset var Image = getImage() />
				
		<!--- validate type --->
		<cfif NOT verifyType(arguments.type)>
			<cfthrow message="Invalid type attribute.  Valid type attributes are #getTypeList()#" />
		</cfif>
				
		<!--- find out what the type is and change it to the corrisponding java imageType --->
		<cfswitch expression="#arguments.type#">
			<cfcase value="gray">
				<cfset arguments.type = image.TYPE_BYTE_GRAY />
			</cfcase>
			<cfcase value="rgb">
				<cfset arguments.type = image.TYPE_INT_RGB />
			</cfcase>
			<cfcase value="argb">
				<cfset arguments.type = image.TYPE_INT_ARGB />
			</cfcase>
		</cfswitch>
		
		<!--- create the new image --->
		<cfset Image.init( arguments.width, arguments.height, arguments.type ) />
		
		<cfset setImage(Image) />
	</cffunction>
	
	<!--- readImage --->
	<cffunction name="readImage" access="public" output="false" returntype="void" hint="I read an image from disk.">
		<cfargument name="path" hint="I am the path of the image file to read." required="yes" type="string">
		<cfset var InputStream = CreateObject("Java", "java.io.FileInputStream") />
		<cfset var Image = getImage() />
		
		<cftry>
			<!--- output the file --->
			<cfset InputStream.init(arguments.path) />
			<cfset Image = getImageIO().read(InputStream) />
			
			<cfcatch>
				<cfthrow message="There was an error reading an image from #arguments.path#.  #cfcatch.RootCause.cause.Message#" />
			</cfcatch>		
		</cftry>
		
		<cfset setImage(Image) />
	</cffunction>
	
	<!--- writeImage --->
	<cffunction name="writeImage" access="public" output="false" returntype="void" hint="I write the image to disk.">
		<cfargument name="path" hint="I am the path of the file to write to." required="yes" type="string"/>
		<cfargument name="format" hint="I am the format of the file to write to." required="yes" type="string" />
		<cfset var OutputStream = CreateObject("Java", "java.io.FileOutputStream") /> 
		<cfset var Image = getImage() />
		
		<!--- insure that the provided format is a supported format --->
		<cfif NOT verifyWritableFormat(arguments.format)>
			<cfthrow message="Invalid format attribute.  Valid format attributes are #getWritableFormats()#" />
		</cfif>

		<cftry>
			<!--- output the file --->
			<cfset OutputStream.init(arguments.path) />
			<cfset getImageIO().write(Image, arguments.format, OutputStream) />
		
			<cfcatch>
				<!--- close the output stream --->
				<cfset OutputStream.close() />
				<cfthrow message="There was an error writing the image to the #arguments.path#.  #cfcatch.RootCause.cause.Message#" />
			</cfcatch>		
		</cftry>
		
		<!--- close the output stream --->
		<cfset OutputStream.close() />
	</cffunction>
	
	<!--- scalePixels --->
	<cffunction name="scalePixels" access="public" output="false" returntype="void">
		<cfargument name="width" hint="I am the new pixel width for the image" required="yes" type="numeric">
		<cfargument name="height" hint="I am the new pixel height for the image" required="yes" type="numeric">
		<cfset var Image = getImage() />
		<cfset var widthPercent = 0 />
		<cfset var heightPercent = 0 />
		
		<!--- insure that the width and height are > 0 --->
		<cfif NOT arguments.width>
			<cfthrow message="Invalid width attribute.  The width attribute must be greater than 0." />
		</cfif> 
		<cfif NOT arguments.height>
			<cfthrow message="Invalid height attribute.  The height attribute must be greater than 0." />
		</cfif> 
		
		<!--- change new pixel sizes to percents --->
		<cfset widthPercent = arguments.width / Image.getWidth() />
		<cfset heigthPercent = arguments.height / Image.getHeight() />
		
		<!--- scale the image --->
		<cfset scale(widthPercent, heigthPercent) />
	</cffunction>
	
	<!--- scalePercent --->
	<cffunction name="scalePercent" access="public" output="false" returntype="void">
		<cfargument name="width" hint="I am the percent by which the image width will be scaled." required="yes" type="numeric">
		<cfargument name="height" hint="I am the percent by which the image height will be scaled." required="yes" type="numeric">
		
		<!--- insure that the width and height are > 0 --->
		<cfif NOT arguments.width>
			<cfthrow message="Invalid width attribute.  The width attribute must be greater than 0." />
		</cfif> 
		<cfif NOT arguments.height>
			<cfthrow message="Invalid height attribute.  The height attribute must be greater than 0." />
		</cfif> 
		
		<!--- scale the image --->
		<cfset scale(arguments.width / 100, arguments.height / 100) />
	</cffunction>
	
		
	<!--- getReadableFormats --->
	<cffunction name="getReadableFormats" access="public" output="false" returntype="string">
		<cfreturn ArrayToList(getImageIO().getReaderFormatNames()) />
	</cffunction>
	<!--- getWritableFormats --->
	<cffunction name="getWritableFormats" access="public" output="false" returntype="string">
		<cfreturn ArrayToList(getImageIO().getWriterFormatNames()) />
	</cffunction>
	<!--- getWidth --->
	<cffunction name="getWidth" access="public" output="false" returntype="numeric">
		<cfreturn getImage().getWidth() />	
	</cffunction>
	<!--- getHeight --->
	<cffunction name="getHeight" access="public" output="false" returntype="numeric">
		<cfreturn getImage().getHeight() />	
	</cffunction>
	
	
	<!--- // -- // -- // -- // -- // -- // -- // -- // ---- 
	//
	//		private methods
	//
	----- // -- // -- // -- // -- // -- // -- // -- // --->
	
	<!--- scale --->
	<cffunction name="scale" access="private" output="false" returntype="void">
		<cfargument name="widthPercent" hint="I am the new width for the image" required="yes" type="numeric">
		<cfargument name="heightPercent" hint="I am the new height for the image" required="yes" type="numeric">
		<cfset var Image = getImage() />
		<cfset var ScaledImage = createObject("java", "java.awt.image.BufferedImage") />
		<cfset var Transform = CreateObject("Java", "java.awt.geom.AffineTransform") />
		<cfset var Operation = CreateObject("Java", "java.awt.image.AffineTransformOp") />
		<cfset var width = int(Image.getWidth() * arguments.widthPercent).intValue() />
		<cfset var height = int(Image.getHeight() * arguments.heightPercent).intValue() />
		
		<cfif NOT width OR NOT height>
			<cfthrow message="Scale operation produced image of 0 width or height." />
		</cfif>
		
		<cfscript>
			ScaledImage.init(width, height, Image.getType());
			Transform.scale(arguments.widthPercent, arguments.heightPercent);
			Operation.init(Transform, Operation.TYPE_BILINEAR);
			Operation.filter(Image, ScaledImage);
		</cfscript>
		
		<cfset setImage(ScaledImage) />
	</cffunction>
	
	<!--- getTypeList --->
    <cffunction name="getTypeList" access="private" output="false" returntype="string">
       <cfreturn variables.typeList />
    </cffunction>
	<!--- verifyType --->
	<cffunction name="verifyType" access="private" output="false" returntype="boolean">
		<cfargument name="type" hint="I am the type to validate" required="no" type="string" />
		<cfreturn ListFindNoCase(getTypeList(), arguments.type) />
	</cffunction>
	<!--- verifyReadableFormat --->
	<cffunction name="verifyReadableFormat" access="private" output="false" returntype="boolean">
		<cfargument name="format" hint="I am the write format to validate" required="no" type="string" />
		<cfreturn ListFindNoCase(getReadableFormats(), arguments.format) />
	</cffunction>
	<!--- verifyWritableFormat --->
	<cffunction name="verifyWritableFormat" access="private" output="false" returntype="boolean">
		<cfargument name="format" hint="I am the write format to validate" required="no" type="string" />
		<cfreturn ListFindNoCase(getWritableFormats(), arguments.format) />
	</cffunction>
	
	
	<!--- // -- // -- // -- // -- // -- // -- // -- // ---- 
	//
	//		getters/setters (may be public or private) 
	//
	----- // -- // -- // -- // -- // -- // -- // -- // --->
	
	<!--- image --->
    <cffunction name="setImage" access="private" output="false" returntype="void">
       <cfargument name="image" hint="I am the image we're working with" required="yes" type="any" />
       <cfset variables.image = arguments.image />
    </cffunction>
    <cffunction name="getImage" access="private" output="false" returntype="any">
       <cfreturn variables.image />
    </cffunction>
	
	<!--- imageIO --->
    <cffunction name="setImageIO" access="private" output="false" returntype="void">
       <cfargument name="imageIO" hint="I am used to read, write and create images" required="yes" type="any" />
       <cfset variables.imageIO = arguments.imageIO />
    </cffunction>
    <cffunction name="getImageIO" access="private" output="false" returntype="any">
       <cfreturn variables.imageIO />
    </cffunction>	
</cfcomponent>
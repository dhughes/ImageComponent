<!--- working from http://java.sun.com/j2se/1.4.2/docs/guide/imageio/spec/apps.fm5.html --->

<cfcomponent displayname="ImageDev" hint="I am a CFC which can be used to create and edit images." output="no">
	<!--- Image: 			I am the image we're working with --->
	<cfset variables.Image = CreateObject("java", "java.awt.image.BufferedImage") />

	<cfset variables.ImageReader = "" />
	<cfset variables.ImageWriter = "" />
	
	<!--- readImage --->
	<cffunction name="readImage" access="public" output="true" returntype="void" hint="I read an image from disk.">
		<cfargument name="path" hint="I am the path of the image file to read." required="yes" type="string" />
		<cfset var fileType = ListLast(arguments.path, ".") />
		<cfset var InputStream = CreateObject("Java", "java.io.FileInputStream") />
		<cfset var Image = getImage() />
		<cfset var ImageIO = CreateObject("Java", "javax.imageio.ImageIO") />
		<cfset var Iterator = "" />
		<cfset var ImageReader = "" />
		
		<!--- verify that the requested file exists --->
		<cfif NOT fileExists(arguments.path)>
			<cfthrow message="Invalid path argument.  The path specified does not exist. (#arguments.path#)  Please provide a valid path to an image file." />
		</cfif>
		
		<!--- find/create an image reader for the correct type of file (gif, jpg, etc) --->
		<cfset Iterator = ImageIO.getImageReadersBySuffix(fileType) />
		<cfif Iterator.hasNext()>
			<!--- grab the ImageReader --->
			<cfset ImageReader = Iterator.next() />
		<cfelse>
			<!--- we couldn't find a valid image reader, throw an error --->
			<cfthrow message="An Image Reader could not be found for the image. (#arguments.path#)  Image is of an unsupported format." />
		</cfif>
		
		<cftry>
			<!--- grab an input stream for the image we're reading --->
			<cfset InputStream.init(arguments.path) />
			<cfset readImageData(InputStream, ImageIO, ImageReader) />
			<cfcatch>
				<cfthrow message="There was an error reading from the file. (#arguments.path#)" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!--- readImageFromURL --->
	<cffunction name="readImageFromURL" access="public" output="true" returntype="void" hint="I read an image from a URL.">
		<cfargument name="URL" hint="I am the URL of the image file to read." required="yes" type="string" />
		<cfset var fileType = ListLast(arguments.URL, ".") />
		<cfset var InputStream = "" />
		<cfset var URLStream = CreateObject("Java", "java.net.URL") />
		<cfset var ImageIO = CreateObject("Java", "javax.imageio.ImageIO") />
		<cfset var Iterator = "" />
		<cfset var ImageReader = "" />
			
		<!--- find/create an image reader for the correct type of file (gif, jpg, etc) --->
		<cfset Iterator = ImageIO.getImageReadersBySuffix(fileType) />
		<cfif Iterator.hasNext()>
			<!--- grab the ImageReader --->
			<cfset ImageReader = Iterator.next() />
		<cfelse>
			<!--- we couldn't find a valid image reader, throw an error --->
			<cfthrow message="An Image Reader could not be found for the image. (#arguments.path#)  Image is of an unsupported format." />
		</cfif>
		
		<cftry>
			<!--- grab an input stream for the image we're reading --->
			<cfset URLStream.init(arguments.URL) />
			<cfset InputStream = URLStream.openConnection().getInputStream() />
			<cfset readImageData(InputStream, ImageIO, ImageReader) />
			<cfcatch>
				<cfthrow message="There was an error reading from the URL. (#arguments.URL#)" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!--- readImageData --->
	<cffunction name="readImageData" access="private" output="true" returntype="void" hint="I read image data from an inputstream.">
		<cfargument name="InputStream" hint="I am the InputStream to read image data from." required="yes" type="any" />
		<cfargument name="ImageIO" hint="I am the ImageIO object to use when reading image data." required="yes" type="any" />
		<cfargument name="ImageReader" hint="I am the ImageReader object to use to read image data." required="yes" type="any" />
		<cfset var ImageInputStream = arguments.ImageIO.createImageInputStream(arguments.InputStream) />
		<cfset var Image = getImage() />
		
		<!--- set the input for the image reader to the input stream created in the caller --->
		<cfset arguments.ImageReader.setInput(ImageInputStream) />
		<!--- read the image --->
		<cfset Image = arguments.ImageReader.read(0) />
		<cfset setImageReader(ImageReader) />
		<cfset setImage(Image) />
	</cffunction>
	
	<!--- writeImage --->
	<cffunction name="writeImage" access="public" output="true" returntype="void" hint="I write the image to disk.">
		<cfargument name="path" hint="I am the path of the file to write to." required="yes" type="string"/>
		<!--- <cfargument name="format" hint="I am the format of the file to write to." required="no" type="string" /> --->
		<cfset var fileType = ListLast(arguments.path, ".") />
		<cfset var OutputStream = CreateObject("Java", "java.io.FileOutputStream") /> 
		<cfset var Image = getImage() />
		<cfset var ImageIO = CreateObject("Java", "javax.imageio.ImageIO") />
		<cfset var Iterator = "" />
		<cfset var ImageWriter = "" />
		<cfset var ImageOutputStream = "" />
		
		<!--- validate that the directory specified in path exists --->
		<cfif NOT DirectoryExists(getDirectoryFromPath(arguments.path))>
			<cfthrow message="Invalid path attribute.  The directory getDirectoryFromPath(arguments.path) does not exist." />
		</cfif>		
		
		<!--- find/create an image writer for the correct type of file (gif, jpg, etc) --->
		<cfset Iterator = ImageIO.getImageWritersBySuffix(fileType) />
		<cfif Iterator.hasNext()>
			<!--- grab the ImageWriter --->
			<cfset ImageWriter = Iterator.next() />
		<cfelse>
			<!--- we couldn't find a valid image writer, throw an error --->
			<cfthrow message="An Image Writer could not be found for the image. (#arguments.path#)  Image is of an unsupported format." />
		</cfif>
				
		<cftry>
			<!--- grab an output stream for the image we're reading --->
			<cfset OutputStream.init(arguments.path) />
			<cfset ImageOutputStream = ImageIO.createImageOutputStream(OutputStream) />
			<cfset ImageWriter.setOutput(ImageOutputStream) />
			<cfset ImageWriter.write(Image) />
			<cfcatch>
				<cfthrow message="There was an error writing to the file. (#arguments.path#)" />
			</cfcatch>
		</cftry>
		
		<!--- flush and finalize the image --->
		<cfset Image.flush() />
				
		<!--- close the output stream --->
		<cfset OutputStream.close() />
	</cffunction>
	
	<!--- setJPEGCompression
	<cffunction name="setJPEGCompression" access="private" output="true" returntype="any" hint="I set the image compression for JPEGs when writing to disk.">
		<cfargument name="ImageWriter" hint="I am the ImageWriter we're adjusting." required="yes" type="any"/>
		<!--- <cfset var ImageWriteParam = CreateObject("Java", "javax.imageio.ImageWriteParam") /> --->
		<cfset var ImageWriteParam = arguments.ImageWriter.getDefaultWriteParam() />
		<cfset var Locale = CreateObject("Java", "java.util.Locale") />
		
		<!--- <cfset ImageWriteParam.init(Locale.getDefault()) /> --->
		<cfset ImageWriteParam.setCompressionMode(ImageWriteParam.MODE_EXPLICIT) />
		<cfset ImageWriteParam.setCompressionQuality(0) />
		
		<cfreturn ImageWriteParam />
	</cffunction> --->
	
	<!--- getImageMetaData
	<cffunction name="getImageMetaData" access="private" output="true" returntype="any" hint="I return the ImageReader's getImageMetaData() results.">
		<cfreturn getImageReader().getImageMetaData(0) />
	</cffunction> --->
	
	<!--- getImageMetaDataXML
	<cffunction name="getImageMetaDataXML" access="public" output="true" returntype="any" hint="I return an XML structure of Image MetaData">
		<cfset var ImageReader = getImageReader() />
		<cfset var node = "" />
		<cfset var formats = ImageReader.getImageMetaData(0).getMetadataFormatNames() />
		<cfset var format = "" />
		<cfset var i = 0 />
		<cfset var Array = CreateObject("Java", "java.lang.reflect.Array") />

		<cfloop from="0" to="1" index="i">
			<cfset format = Array.get(formats, JavaCast("int", i)) />
			<cfset node = ImageReader.getImageMetaDataXML(0).getAsTree(JavaCast("string", format)) />
			<cfoutput>
				#getXMLModeData(node)#<br><Br>
			</cfoutput>
		</cfloop>
	</cffunction> --->
		
	<!--- getXMLNodeData
	<cffunction name="getXMLModeData" access="private" output="true" returntype="void">
		<cfargument name="node" required="false" type="any" />
		<cfargument name="level" required="true" type="numeric" default="0" />
		<cfset var map = "" />
		<cfset var lenght = 0 />
		<cfset var i = 0 />
		
		<cfset indent(arguments.level) />
		
		<cfoutput>
			&lt;#arguments.node.getNodeName()#
		</cfoutput>
			
		<cfset map = arguments.node.getAttributes() />
		<cfset length = map.getLength() />

		<cfloop from="1" to="#length#" index="i">
			<cfset attr = map.item(JavaCast("int", i-1)) />
			<cfif IsDefined("attr")>
				<cfoutput>
					#attr.getNodeName()#="#attr.getNodeValue()#"
				</cfoutput>
			</cfif>
		</cfloop>
	
		<cfset child = arguments.node.getFirstChild() />
		<cfif IsDefined("child")>
			<cfoutput>
				&gt;<br>
			</cfoutput>
			<cfset getXMLModeData(arguments.node.getFirstChild(), JavaCast("int", arguments.level + 1)) />
			<cfset indent(arguments.level) />
			<cfoutput>
				&lt;/#node.getNodeName()#&gt;<br>
			</cfoutput>
		<cfelse>
			<cfoutput>
				/&gt;<br>
			</cfoutput>
		</cfif>
	</cffunction> ---->
	
	<!--- indent 
	<cffunction name="indent" access="private" output="true" returntype="void">
		<cfargument name="level" required="true" type="numeric">
		<cfset var i = 0 />
		<cfloop from="0" to="#arguments.level#" index="i">
			<cfoutput>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</cfoutput>
		</cfloop>
	</cffunction> --->
	
	<!--- flipVertical
	<cffunction name="flipVertical" access="public" output="false" returntype="void" hint="I flip the image along the vertical axis.">
		<cfset var Image = getImage() />
		<cfset var FlippedImage = createObject("java", "java.awt.image.BufferedImage") />
		<cfset var Transform = CreateObject("Java", "java.awt.geom.AffineTransform") />
		<cfset var Operation = CreateObject("Java", "java.awt.image.AffineTransformOp") />
		
		<cfscript>
			FlippedImage.init(JavaCast("int", Image.getWidth()), JavaCast("int", Image.getHeight()), Image.TYPE_INT_ARGB);
			Transform = Transform.getScaleInstance(-1, 1);
			Transform.translate(-Image.getWidth(), 0);
			Operation.init(Transform, Operation.TYPE_NEAREST_NEIGHBOR);
			Operation.filter(Image, FlippedImage);
		</cfscript>
		
		<cfset setImage(FlippedImage) />	
	</cffunction> --->
	
	
	<!--- image --->
    <cffunction name="setImage" access="private" output="false" returntype="void">
       <cfargument name="image" hint="I am the image we're working with" required="yes" type="any" />
       <cfset variables.image = arguments.image />
    </cffunction>
    <cffunction name="getImage" access="private" output="false" returntype="any">
       <cfreturn variables.image />
    </cffunction>
	
	<cffunction name="setImageReader" access="private" output="false" returntype="void">
       <cfargument name="ImageReader" hint="I am the ImageReader we're working with" required="yes" type="any" />
       <cfset variables.ImageReader = arguments.ImageReader />
    </cffunction>
    <cffunction name="getImageReader" access="private" output="false" returntype="any">
       <cfreturn variables.ImageReader />
    </cffunction>
	
	<!--- <cffunction name="setImageWriter" access="private" output="false" returntype="void">
       <cfargument name="ImageWriter" hint="I am the ImageWriter we're working with" required="yes" type="any" />
       <cfset variables.ImageWriter = arguments.ImageWriter />
    </cffunction>
    <cffunction name="getImageWriter" access="private" output="false" returntype="any">
       <cfreturn variables.ImageWriter />
    </cffunction> --->
	
</cfcomponent>
<!------------------------------------------------------------------------------
Source Code Copyright © 2004 Alagad, Inc. www.alagad.com

  Application: Alagad Image Component 
  Supported CF Version: MX 6.1, BlueDragon 6.1 JX (or better)
  File Name: Image.cfc
  CFC Component Name: Image
  Created By: Doug Hughes (alagad@alagad.com)
  Created Date: 05/10/2004
  Description: I am a CFC which can be used to create and edit images.

Version History:
  
  mm/dd/yyyy	Author		Version		Comments
  05/10/2004	D.Hughes	?			Created
  05/25/2004	D.Hughes	?			Removed init()
  06/02/2004	D.Hughes	?			Readied for release
  06/21/2004	D.Hughes	?			Fixed error in getSimpleStringMetrics() where method was called on Graphics before Graphics was set.
  06/22/2004	D.Hughes	?			Removed all instances of intValue().
  06/23/2004	D.Hughes 	?			Various BD tunings.
  06/28/2004	D.Hughes	?			Added many more JavaCast()s.  May have a few that were missed.
  06/29/2004	D.Hughes	?			Removed reference to #cfcatch.RootCause.cause.Message#" in cfthrow tag when reading images for DB compatibility.
  07/02/2004	D.Hughes	?			Added capability to load Images from URL via java FileIO.  
  07/03/2004	D.Hughes	?			Added convenience methods for scaleHeight() and scaleWidth().
  07/03/2004	D.Hughes	?			Created an eyedropper tool to grab a color from any image pixel (getColorFromPixel).
  07/03/2004	D.Hughes	?			Added a trimEdges() method to remove pixels of the same color from the edges of an image.  (similar to ImageMagick and PhotoShop)
  07/04/2004	D.Hughes	?			Added writeToBase64() and readFromBase64() methods to write and read image data to/from base64 format.
  07/04/2004	D.Hughes	?			Added writeToBrowser() method to write the image we're working with directly to the browser.
  07/07/2004	D.Hughes	?			Added scaleToFit() method to scale images to fit within a pixel reigon.
  07/08/2004	D.Hughes 	?			Added key-based licensing system and image tagging for unlicensed images.
  08/16/2004	D.Hughes	?			Added methods: setAntialias, getAntialias, resetAntialias.
  08/28/2004	D.Hughes	2.0			Added methods and variables for version information.  Based on updates to 1.1 and lite.
  08/29/2004	D.Hughes	2.1			Changed how Indexed colors are handled.  Added method createComparableImage() and implemented it thoughout the component.
  09/01/2004	D.Hughes	2.2			Many changes.  Mostly to error messages and error checking.  Add process to verify that an image is loaded before we can call methods on it.
  09/02/2004	D.Hughes	2.3			Added fixes to varous setString methods so that negative numbers and numbers greater than the string length throw nicer errors.
  09/06/2004	D.Hughes	2.4			Fixed error messages in createColor 
  09/07/2004	D.Hughes	2.5			Fixed bug when reading image and then calling getWidth().  Made sure that the transparency settings and color were set in the code that "tags" unlicensed images.
  09/12/2004	D.Hughes	2.6			Fixed error in createImage which threw incrorred error message.  
  09/16/2004	D.Hughes	2.7			Removed requirement in drawString and drawSimpleString for x and y to be greater than 0.
  10/12/2004	D.Hughes	2.8			Implemented compression settings on all methods for writing.  Woo hoo!
  10/23/2004	D.Hughes	2.9			Compression updates so that it works when creating a new image.  Also added the capability to have a file aickey.txt in the same directory as the component to set the license key.
  										Added several other fixes/changes related to code due to unit testing results.
  10/28/2004	D.Hughes	2.10		Fixed problem with the AIC locking files being read and not releasing the lock.
  10/31/2004	D.Hughes	2.11		Fixed problems where alpha channels are writing to JPEGs and corrupting them.  This was bad.  This is fixed.  Yay.
  11/14/2004	D.Hughes	2.12		Added method setImageMode() and getImageMode() which set/get the image type (rgb, grayscale, etc).  Updated how grayscale() and writing images set image types.  
  02/08/2005	D.Hughes	2.13		Altered how image compression functions.  It used to place a 100px thumbnail in the image... this was not compressed and inflated the file size.  I changed this so that CF 6.1 uses a 1px thumbnail.  
  						MX 7 now adds no thumbnail at all.
  04/13/2005  	D.Hughes	2.14		Fixed bug when writing Tiff and other formats.
  04/19/2005	D.Hughes	2.15		Fixed bug with jpeg compresson on MX 6.1
  05/03/2005	D.Hughes	2.16		Fixed a few minor bugs related to BD 6.1 and 6.2.  Added beta support for 6.2.
  05/18/2005	D.Hughes	2.17		Added the following methods: createPath(), addPathLine(), addPathJump(), addPathQuadraticCurve() addPathBezierCurve(), closePath(), drawPath()
  06/15/2005	D.Hughes	2.18		Added getSize() method to return the size a file will be on disk.
  06/20/2005	D.Hughes	2.19		Changeed the setKey() method to return WEB-INF.cftags.component rather than Image.  This allows the CFC to be renamed.
  01/11/2006	D.Hughes	2.22		Several bug fixes and readFromBinary() and writeToBinary(). 
  02/07/2006	D.Hughes	2.23		Added scaleToBox()
  
Comments:

  mm/dd/yyyy	Author		Comment
  05/10/2004	D.Hughes	Variables which start with upper case letters are objects, lowercase are primitives.  (Usualy)
  05/10/2004	D.Hughes	Some getter/setter methods for java objects have a type of "any".  This is because specifying the java class name does not work in CF.
  07/02/2004	D.Hughes	While trying to read/write image meta data I discovered that this is NOT exif data.  What
							that means is that to edit exif data I'd have to do it manually, which would probably be a real pain.  This bears more looking into, but may not be worth
							the extra time.
  08/16/2004	D.Hughes	I've added setAntialias, getAntialias, resetAntialias.  I need to document these.
  10/12/2004	D.Hughes	I added the "quality" attribute to the writeImage methods.  I need to document these.
  10/20/2004	D.Hughes	Today I found a bug in writing compressed versions of images I created and drew using the image component.  I don't know at the moment what's going wrong.
  							in general either I get a null pointer error (which I think I fixed) or image colors are getting messed up).  See comress.cfm and compress2.cfm in the tests directory

To Do:

  mm/dd/yyyy	Status		Priority	Comment
  06/24/2004	Pending		Low			Check if image type supported when reading images for createTexture and drawImage. -- I'm not sure how to do this, or if I can.  I can tell the
  										user what image types are supported using getReadable/WritableFormats but I can't trust that the file extension for an image really corrisponds
										to the data in it.  For now, I updated ther error message recieved when reading images.  (May also want to check this against reading other file
										types like EXE, CFM, etc)
  07/02/2004	None		Medium		Add a flood fill method.  flood(x, y).  Ideally, this would be able to fill with a texture, gradient, or solid color.  This would antialias. This
  										whould have some sort of tolerance control to control what matches and what doesn't.  There are several resouces for algorythems on the web.  One
										possible idea is to have a method which takes one pixel, adds it to an array of pixels checked, fills it.  It then looks at all of the surrounding
										pixels and calls the same method on each.  These are filled only if their color is withing the tollerance levels.  This continues to recurse.  Each
										recursion is checked to insure that it's not duplicating effort.  Because of recursion this might be a bad idea to implement in this tag.  I'm not
										sure what the use case would even be for this.  However, it would be "cool".  Perhaps one could build a fairly robust image editing program out of
										this and a web page.
  07/15/2004	None		Medium		Add method to return various image properties.  Possibly from Buffered Images' getProperty() and getPropertyNames(). (EXIF data)
  07/15/2004	None		High		Insure that all drawing methods allow drawing outside the image bounds.  Many of these throw errors if you try to draw at -x or -y points.
  07/15/2004	None		Low			Add a sepia() method to convert the image to a sepia tone.
  07/15/2004	None		Low			Add a vignette() method to add a vinette effect to the image.  Might have different vinette strenghts and shapes as well as the ability to set
  										the color of the vingette.
  07/15/2004	None		Low			Add the ability to create selections within the image which are the only regions effected by calls to methods
  07/15/2004	None		Low			Add methods for working with image channels.  IE:  clearChannel()  erases all data in the channel, clearAllButChannel() to delete all
  										channels except the current one, setImageDataFromChannel() copies the data out of the channel and sets the entire image to it -- could be good
										for extracting alpha channels.  setChannel() sets the data in an alpha channel explicitly.... These are all just ideas and need more thought.
										It would be good to find a way to set active channels which calls to drawing methods would only effect.  They way I can shut off the green and
										red channels and only effect the blue and alpha.
  07/15/2004	None		Low			Add a method to return a structure of image data. Or add more methods to get more image data and then one uber-method to call all others and return t
  										their results as a struct.  Should return width, height, origionalFileSize, colorspace, etc, etc.  Look at BufferedImage and Image to see if there
										are any other properties we can extract.
  08/13/2004	Document!	High		Added a way to disable or enable antialiasing.  Currently, when drawing, the app looks at (approx) line 3022 where it sets VALUE_ANTIALIAS_ON 
  										for all drawing.  It's fine that this is defaulted to on, but add a method where this can at least be set. NOTE: I added setAntialias, getAntialias, resetAntialias.
										these methods need to be documented in the docs.
  09/05/2004	Note 		High		The drawImage and scale methods use bilinear interpolation (and this is noted in the docs).  I may want to add arguments to these methods to select
  										what type of interpolation to use.
  05/11/2005	Pending		Medium		Add the ability to stroke text.  Add the ability to draw abritrary java shape objects.
  
Canceled/On Indefinate Hold:

  07/02/2004	None		Low			Image Capture from a web cam.  I don't know why this would be needed, but it'd be cool to be able to just grab a picture from your webcam. I
  										can't do this -- I need the Java Media Kit installed to do this (I think this is seperate from the JRE)
  06/24/2004	On Hold		High		Create methods to read and edit image meta data (exif).  (Tried - Image metadata does NOT contain exif data.  Must read data manualy.) 
  										Update: began work on another component for reading and writing exif data.
								
------------------------------------------------------------------------------->
<cfcomponent displayname="Image" hint="I am a CFC which can be used to create and edit images." output="no">
	<!--- // -- // -- // -- // -- // -- // -- // -- // ---- 
	//
	//		instance variables
	//
	----- // -- // -- // -- // -- // -- // -- // -- // --->
	<!--- version --->
	<cfset variables.version = StructNew() />
	<cfset variables.version.product = "Alagad Image Component" />
	<cfset variables.version.version = "2.23" />
	<cfset variables.version.releaseDate = "2/6/2006" />

	<!--- Image: 			I am the image we're working with --->
	<cfset variables.Image = CreateObject("java", "java.awt.image.BufferedImage") />
	<!--- ImageIO: 			I am used to read, write and create images --->
	<cfset variables.ImageIO = CreateObject("Java", "javax.imageio.ImageIO") />
	<!--- typeList:			I hold a list of image types supported --->
	<cfset variables.typeList = "Grayscale,Gray,RGB,ARGB,BGR,INDEXED,BINARY" />
	<!--- imageLoaded (indicates if an image has been created or read) --->
	<cfset imageLoaded = false />
	
	<!---
		ImageReader:		I am the object used to read the initial image.  For now I'm not needed.  In the future
							I may be used to aid control of compression settings as well as writing image meta data
	<cfset variables.ImageReader = "" />--->
	
	<!--- BackgroundColor --->
	<cfset variables.BackgroundColor = 0 />
	<!--- Color --->
	<cfset variables.Color = 0 />
	<!--- Stroke --->
	<cfset variables.Stroke = 0 />
	<!--- Fill --->
	<cfset variables.Fill = 0 />
	<!--- Composite --->
	<cfset variables.composite = "srcOver" />
	<!--- alpha --->
	<cfset variables.transparency = 100 />
	<!--- Font --->
	<cfset variables.Font = 0 />
	<!--- rotate --->
	<cfset variables.rotate = 0 />
	<!--- rotateX --->
	<cfset variables.rotateX = 0 />
	<!--- rotateY --->
	<cfset variables.rotateY = 0 />
	<!--- shearX --->
	<cfset variables.shearX = 0 />
	<!--- shearY --->
	<cfset variables.shearY = 0 />
	<!--- Font --->
	<cfset variables.Font = CreateObject("Java", "java.awt.Font") />
	<!--- charString (for key) --->
	<cfset variables.charString = "0123456789ABCDEFGHJKLMNPQRTUVWXY" />
	<!--- licensed --->
	<cfset variables.licensed = false />
	<!--- antialias --->
	<cfset variables.antialias = true />
	
	<!--- // -- // -- // -- // -- // -- // -- // -- // ---- 
	//
	//		setKey
	//
	----- // -- // -- // -- // -- // -- // -- // -- // --->
	<cffunction name="setKey" access="public" output="false" returntype="WEB-INF.cftags.component" hint="I set the license key for the component.">
		<cfargument name="key" hint="I am the license key to use." required="yes" type="string" />
		
		<!--- validate the key. --->
		<cfif validateKey(arguments.key, "ImageComponent@l794o1WhatIsTheMeaningOfLifeTheUniverseAndEverthing?42.")>
			<!--- if this is licensed correctly, indicate so --->
			<cfset variables.licensed = true />
		<cfelse>
			<cfset variables.licensed = false />
		</cfif>
		
		<!--- return the image object. --->
		<cfreturn this />
	</cffunction>
	
	<!--- // -- // -- // -- // -- // -- // -- // -- // ---- 
	//
	//		public methods - I NEED TO MAKE A LIST OF THE METHODS USED INSIDE THE READIMAGE METHOD AND LEAVE THOSE IN.  GET IT ISOLATED AND WORKING TO RE-CREATE ERROR and SHOW WHEN FIXED.
	//
	----- // -- // -- // -- // -- // -- // -- // -- // --->
	
	<!--- readImage --->
	<cffunction name="readImage" access="public" output="false" returntype="void" hint="I read an image from disk.">
		<cfargument name="path" hint="I am the path of the image file to read." required="yes" type="string" />
		<cfargument name="mode" hint="I am an optional mode to convert the image to when reading.  Options are:Grayscale, RGB, ARGB, BGR, INDEXED, BINARY" default="" required="no" type="string" />
		<cfargument name="type" hint="I am an optional argument which can be used to manyally specify the type of image.  To get a list of options call the getReadableFormats() method." default="" required="no" type="string" />
		<cfset var fileExt = ListLast(arguments.path, ".") />
		<cfset var ImageReader = 0 />
		<cfset var InputStream = CreateObject("Java", "java.io.FileInputStream") />
		
		<!--- verify that the requested file exists --->
		<cfif NOT fileExists(arguments.path)>
			<cfthrow
				type="Alagad.Image.InvalidPath"
				message="Invalid path argument.  The path specified does not exist or is not accessible. (#arguments.path#)  Please provide a valid path to an image file." />
		</cfif>
		
		<cfif Len(arguments.type)>
			<cfset fileExt = arguments.type />
		</cfif>
		
		<!--- get the Image Reader --->
		<cfset ImageReader = getImageReadersBySuffix(fileExt) />
		
		<cftry>
			<!--- grab an input stream for the image we're reading --->
			<cfset InputStream.init(arguments.path) />
			
			<cfcatch>
				<!--- close the input stream! --->
				<cfset InputStream.close() />
				<cfthrow
					type="Alagad.Image.ErrorOpeningFile"
					message="There was an error opening the file #arguments.path#." />
			</cfcatch>
		</cftry>
		
		<cftry>
			<!--- read and set the image data --->
			<cfset setImage(readImageData(InputStream, ImageReader)) />
			<cfcatch>
				<!--- close the input stream! --->
				<cfset InputStream.close() />
				<cfrethrow />
			</cfcatch>
		</cftry>

		<!--- if openMode is provided convert to the requested type --->
		<cfif Len(arguments.mode)>
			<cfset setImageMode(arguments.mode) />
		</cfif>
		
		<!--- close the input stream! --->
		<cfset InputStream.close() />
	</cffunction>
	
	
	<!--- getImageReadersByInputStream --->
	<cffunction name="getImageReadersByInputStream" access="private" output="false" returntype="any" hint="I return an ImageReader based on an input stream.">
		<cfargument name="InputStream" hint="I am the InputStream to get a reader for." required="yes" type="string" />
		<cfset var ImageIO = getImageIO() />
		<cfset var ImageInputStream = getImageIO().createImageInputStream(arguments.InputStream) />
		<cfset var Iterator = 0 />
		<cfset var ImageReader = 0 />
		
		<!--- find an image reader based on the currnet inputstream --->
		<cfset Iterator = ImageIO.getImageReaders(ImageInputStream) />
		
		<!--- check to see if there is a next image reader, IE: is there any image reader? --->
		<cfif Iterator.hasNext()>
			<!--- grab the ImageReader --->
			<cfset ImageReader = Iterator.next() />
		<cfelse>
			<!--- we couldn't find a valid image reader, throw an error --->
			<cfthrow
				type="Alagad.Image.ImageReaderNotFound"
				message="An Image Reader could not be found based on file data. Image is of an unsupported format." />
		</cfif>
		
		<cfreturn ImageReader />
	</cffunction>
	
	<!--- getImageReadersBySuffix --->
	<cffunction name="getImageReadersBySuffix" access="private" output="false" returntype="any" hint="I return an ImageReader based on a file extension.">
		<cfargument name="fileExt" hint="I am the file extension to get a reader for" required="yes" type="string" />
		<cfset var ImageIO = getImageIO() />
		<cfset var Iterator = 0 />
		<cfset var ImageReader = 0 />
		
		<!--- find/create an image reader for the correct type of file (gif, jpg, etc) --->
		<cfset Iterator = ImageIO.getImageReadersBySuffix(arguments.fileExt) />
		
		<!--- check to see if there is a next image reader, IE: is there any image reader? --->
		<cfif Iterator.hasNext()>
			<!--- grab the ImageReader --->
			<cfset ImageReader = Iterator.next() />
		<cfelse>
			<!--- we couldn't find a valid image reader, throw an error --->
			<cfthrow
				type="Alagad.Image.ImageReaderNotFound"
				message="An Image Reader could not be found for the file type (#arguments.fileExt#). Image is of an unsupported format." />
		</cfif>
		
		<cfreturn ImageReader />
	</cffunction>
	
	<!--- readImageFromURL --->
	<cffunction name="readImageFromURL" access="public" output="false" returntype="void" hint="I read an image from a URL.">
		<cfargument name="URL" hint="I am the URL of the image file to read." required="yes" type="string" />
		<cfargument name="mode" hint="I am an optional mode to conver the image to when reading.  Options are:Grayscale, RGB, ARGB, BGR, INDEXED, BINARY" default="" required="no" type="string" />
		<cfset var fileExt = ListLast(arguments.URL, ".") />
		<cfset var ImageReader = 0 />
		<cfset var URLStream = CreateObject("Java", "java.net.URL") />
		<cfset var InputStream = 0 />
		
		<!--- get the Image Reader --->
		<cfset ImageReader = getImageReadersBySuffix(fileExt) />
		
		<cftry>
			<!--- grab an input stream for the image we're reading --->
			<cfset URLStream.init(arguments.URL) />
			<cfset InputStream = URLStream.openConnection().getInputStream() />
			
			<cfcatch>
				<cfthrow
					type="Alagad.Image.ErrorOpeningURL"
					message="There was an error reading from the URL. (#arguments.URL#)" />
			</cfcatch>
		</cftry>

		<cftry>
			<!--- read and set the image data --->
			<cfset setImage(readImageData(InputStream, ImageReader)) />		
			<cfcatch>
				<!--- close the input stream! --->
				<cfset InputStream.close() />
				<cfrethrow />
			</cfcatch>
		</cftry>
		
		<!--- if openMode is provided convert to the requested type --->
		<cfif Len(arguments.mode)>
			<cfset setImageMode(arguments.mode) />
		</cfif>
	</cffunction>
	
	<!--- readImageData --->
	<cffunction name="readImageData" access="private" output="false" returntype="Any" hint="I read image data from an inputstream and return an Image.">
		<cfargument name="InputStream" hint="I am the InputStream to read image data from." required="yes" type="any" />
		<cfargument name="ImageReader" hint="I am the ImageReader object to use to read image data." required="yes" type="any" />
		<cfset var ImageInputStream = getImageIO().createImageInputStream(arguments.InputStream) />
		<cfset var Image = getImageForLoad() />
		
		<!--- <cftry>--->
			<!--- set the input for the image reader to the image input stream --->
			<cfset arguments.ImageReader.setInput(ImageInputStream) />
			
			<!--- read the image --->
			<cfset Image = arguments.ImageReader.read(JavaCast("int", 0)) />
			
			<!--- set the image reader (used by some write methods to get metadata)
			<cfset setImageReader(arguments.ImageReader) /> --->
						
			<!--- close the input stream.  prevents memory leaks and locked files --->
			<cfset ImageInputStream.close() />
			<cfset arguments.ImageReader.dispose() />
			
			<!--- <cfcatch>
				<!--- close the input stream.  prevents memory leaks and locked files. --->
				<cfset ImageInputStream.close() />
				<cfset arguments.ImageReader.dispose() />
			
				<cfthrow
					type="Alagad.Image.ErrorReadingImage"
					message="There was an error reading the image.  Image may be corrupted?" />
			</cfcatch>
		</cftry> --->
				
		<!--- return the image --->
		<cfreturn Image />
	</cffunction>
	
	<!--- getImageMode --->
	<cffunction name="getImageMode" access="public" output="false" returntype="string" hint="I return the image mode.  Returns one of: Grayscale, RGB, ARGB, BGR, INDEXED, BINARY, or Unrecognized.">
		<cfset var imageType = "" />
		
		<cfswitch expression="#getImage().getType()#">
			<cfcase value="10,11">
				<cfset imageType = "Grayscale" />
			</cfcase>
			<cfcase value="1">
				<cfset imageType = "RGB" />
			</cfcase>
			<cfcase value="2">
				<cfset imageType = "ARGB" />
			</cfcase>
			<cfcase value="4,5">
				<cfset imageType = "BGR" />
			</cfcase>
			<cfcase value="13">
				<cfset imageType = "INDEXED" />
			</cfcase>
			<cfcase value="12">
				<cfset imageType = "BINARY" />
			</cfcase>
			<cfdefaultcase>
				<cfset imageType = "Unrecognized" />
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn imageType />
	</cffunction>
	
	<!--- setImageMode --->
	<cffunction name="setImageMode" access="public" output="false" returntype="void" hint="I convert the images mode.  Options are: Grayscale, RGB, ARGB, BGR, INDEXED, BINARY">
		<cfargument name="mode" hint="I am the mode to convert the image to.  Options are: Grayscale, RGB, ARGB, BGR, INDEXED, BINARY" required="yes" type="string" />
		<cfset var Image = getImage() />
		<cfset var NewImage = CreateObject("Java", "java.awt.image.BufferedImage") />
		<cfset var Graphics = 0 />
		<cfset var Operation = CreateObject("Java", "java.awt.image.AffineTransformOp") />
		<cfset var Transform = CreateObject("Java", "java.awt.geom.AffineTransform") />
		
		<cfscript>
			NewImage.init(JavaCast("int", Image.getWidth()), JavaCast("int", Image.getHeight()), JavaCast("int", getColorModeId(arguments.mode)));
			Graphics = NewImage.getGraphics();
			
			Graphics.fillRect(0, 0, JavaCast("int", Image.getWidth()), JavaCast("int", Image.getHeight()));
			
			Transform.scale(1, 1);
			Operation.init(Transform, Operation.TYPE_BILINEAR);
			Graphics.drawImage(Image, Operation, JavaCast("int", 0), JavaCast("int", 0));
		</cfscript>
		
		<cfset setImage(NewImage) />
	</cffunction>
	
	<!--- getColorModeId --->
	<cffunction name="getColorModeId" access="private" output="false" returntype="numeric" hint="Based on a name, I return the int representing a color mode.">
		<cfargument name="mode" hint="I am the color mode name. Options are: Grayscale, RGB, ARGB, BGR, INDEXED, BINARY" required="yes" type="string" />
		<cfset var imageMode = 0 />
		
		<!--- validate the modes --->
		<cfset verifyImageMode(arguments.mode) />
		
		<!--- get the mode ID --->
		<cfswitch expression="#arguments.mode#">
			<cfcase value="Grayscale,Gray">
				<cfset imageMode = Image.TYPE_BYTE_GRAY />
			</cfcase>
			<cfcase value="RGB">
				<cfset imageMode = Image.TYPE_INT_RGB />
			</cfcase>
			<cfcase value="ARGB">
				<cfset imageMode = Image.TYPE_INT_ARGB />
			</cfcase>
			<cfcase value="BGR">
				<cfset imageMode = Image.TYPE_INT_BGR />
			</cfcase>
			<cfcase value="INDEXED">
				<cfset imageMode = Image.TYPE_BYTE_INDEXED />
			</cfcase>
			<cfcase value="BINARY">
				<cfset imageMode = Image.TYPE_BYTE_BINARY />
			</cfcase>
		</cfswitch>
		
		<!--- return the mode ID --->
		<cfreturn imageMode />
	</cffunction>
	
	<!---- getSize --->
	<cffunction name="getSize" access="public" output="false" returntype="numeric" hint="I return the size the image would be if written to disk.">
		<cfargument name="format" hint="I am the format of the file to write to." required="yes" type="string" />
		<cfargument name="quality" hint="I am set the compression quality when writing the image." required="no" type="numeric" />
		<cfset var OutputStream = CreateObject("Java", "java.io.ByteArrayOutputStream").init() /> 
		
		<cftry>
			<cfif IsDefined("arguments.quality")>
				<!--- the user wants to controll the quality of the image --->
				<cfset writeToOutputStream(arguments.format, OutputStream, arguments.quality) />
			<cfelse>
				<!--- the user wants to use the defaults (or has a non-jpeg image) --->
				<cfset writeToOutputStream(arguments.format, OutputStream) />
			</cfif>
			
			<!--- catch any errors and clean up --->
			<cfcatch>
				<!--- close the outputstream --->
				<cfset OutputStream.close() />
				
				<cftry>
					<!--- clean up any files which may have been created --->
					<cffile action="delete"
						file="#arguments.path#" />
					<cfcatch></cfcatch>
				</cftry>				
				
				<!--- rethrow our error --->
				<cfrethrow />
			</cfcatch>
		</cftry>
		
		<!--- return the resulting size of the image --->
		<cfreturn OutputStream.size() />		
	</cffunction>




	<!--- verifyReadableFormat --->
	<cffunction name="verifyReadableFormat" access="private" output="false" returntype="boolean">
		<cfargument name="format" hint="I am the write format to validate" required="no" type="string" />
		<cfreturn ListFindNoCase(getReadableFormats(), arguments.format) />
	</cffunction>
	<!--- verifyWritableFormat --->
	<cffunction name="verifyWritableFormat" access="private" output="false" returntype="boolean">
		<cfargument name="format" hint="I am the write format to validate" required="no" type="string" />
		<cfreturn ListFindNoCase(getWritableFormats(), arguments.format) GT 0 />
	</cffunction>
	
	<!--- key related --->
	<cffunction name="validateKey" access="private" output="false" returntype="boolean">
		<cfargument name="key" required="true" type="string" />
		<cfargument name="appText" required="true" type="string" />
		<cfset var initialChars = "" />
		
		<!--- fix the key (remove all hyphens) --->
		<cfset arguments.key = Replace(arguments.key, "-", "", "all") />
	
		<!--- grab the first 9 chars --->
		<cfset initialChars = Left(arguments.key, 9) />
			
		<!--- get a key and compare to our current key  --->
		<cfreturn Replace(getKey(initialChars, arguments.appText), "-", "", "all") IS arguments.key />
	</cffunction>
	
	<cffunction name="getKey" access="private" output="false" returntype="string">
		<cfargument name="initialChars" required="true" type="string" />
		<cfargument name="appText" required="true" type="string" />
		<cfset var md5String = "" />
		<cfset var key = "" />
		
		<!--- get a hash of the string --->
		<cfset md5String = hash(initialChars & arguments.appText) />
		<cfset key = arguments.initialChars />
		
		<!--- 
			Loop over the has, grabing 2 chars on each look, convert them to base 10 and mod 32 the results.
			This value is the character in the list of valid chars we will be using for this char in the resulting key.
		--->
		<cfloop from="1" to="32" index="i" step="2">
			<cfset key = key & Mid(variables.charString, (InputBaseN(Mid(md5String, i, 2),16) Mod 32) + 1, 1) />
		</cfloop>
		
		<cfif Len(key) IS 25>
			<!--- add dashes --->
			<cfset key = Insert("-", key, 20) />
			<cfset key = Insert("-", key, 15) />
			<cfset key = Insert("-", key, 10) />
			<cfset key = Insert("-", key, 5) />
		</cfif>
		
		<cfreturn key />
	</cffunction>
	
	<cffunction name="tagImage" access="private" output="false" returntype="void">
		<cfset var String1 = "- The Alagad Image Component -" />
		<cfset var String2 = "A CFC for editing images." />
		<cfset var String3 = "http://www.alagad.com" />
		<cfset var String4 = "Alagad" />
		<cfset var top = 0 />
		<cfset var white = CreateColor(255, 255, 255) />
		
		<!--- load the license if it exists in aickey.txt --->
		<cfset loadLicenseFile() />
		
		<cfif NOT variables.licensed>
			<cfset m1 = GetSimpleStringMetrics(String1) />
			<cfset m2 = GetSimpleStringMetrics(String2) />
			<cfset m3 = GetSimpleStringMetrics(String3) />
			<cfset totalHeight = m1.height + m2.height + m3.height + 10 />
			
			<cfset setFill(white) />
			<cfset setTransparency(100) />
						
			<cfset top = Round((getHeight() - totalHeight)/2) />
			
			<!--- 
				I'm wrapping this block of code in a try/catch because I want to insure that we 
				get though this gracefuly.  If for some unforseen reason this bombs out I think 
				that we'd be better skipping it than throwing an error.
			--->
			<cftry>
				<cfif getWidth() LTE 50 OR getHeight() LTE 50>
					<cfset drawSimpleString(String4, 2, getHeight() - 2) />
				<cfelse>
					<cfset drawSimpleString(String1, Round((getWidth() - m1.width)/2), top + m1.height) />
					<cfset drawSimpleString(String2, Round((getWidth() - m2.width)/2), top + m1.height + 5 + m2.height) />
					<cfset drawSimpleString(String3, Round((getWidth() - m3.width)/2), top + m1.height + 5 + m2.height + 5 + m3.height) />
				</cfif>
				<cfcatch>
					<!--- do nothing --->
				</cfcatch>
			</cftry>
		</cfif>
	</cffunction>
	
	<!--- loadLicenseFile --->
	<cffunction name="loadLicenseFile" access="private" output="false" returntype="void" hint="I check for the existance of (and contents of) aickey.txt and load it as the license key, if it exists.">
		<cfset var cfcKey = getDirectoryFromPath(getCurrentTemplatePath()) & "aickey.txt" />
		<cfset var key = "" />
		
		<!--- look for a file named aickey.txt --->
		<cfif FileExists(cfcKey)>
			<!--- read the key file, if possible --->
			<cffile action="read"
				file="#cfcKey#"
				variable="key" />
			<!--- set the key (if not valid it won't be licensed) --->
			<cfset setKey(trim(key)) />
		</cfif>
	</cffunction>
	
	<!--- createComparableImage --->
	<cffunction name="createComparableImage" access="private" output="false" returntype="any">
		<cfargument name="Image" hint="I am the image to sample" required="yes" type="any" />
		<cfargument name="width" hint="I set the width of the image" required="no" default="0" type="numeric" />
		<cfargument name="height" hint="I set the height of the image" required="no" default="0" type="numeric" />
		<cfset var NewImage = CreateObject("java", "java.awt.image.BufferedImage") />
		<cfset var type = Iif(arguments.Image.getType(), DE(arguments.Image.getType()), DE(Image.TYPE_INT_ARGB)) />
		<cfset var ColorModel = arguments.Image.getColorModel() />
		<cfset arguments.width = Iif(arguments.width, DE(arguments.width), DE(arguments.Image.getWidth())) />
		<cfset arguments.height = Iif(arguments.height, DE(arguments.height), DE(arguments.Image.getHeight())) />
		
		<!--- based on the image's type, init it --->
		<cfif type IS 12 OR type is 13>
			<!--- the color model is indexed or binary (per http://java.sun.com/j2se/1.4.2/docs/api/java/awt/image/BufferedImage.html) --->
			<cfset NewImage.init(JavaCast("int", arguments.width), JavaCast("int", arguments.height), JavaCast("int", type), ColorModel) />
		<cfelse>
			<!--- the image is not indexed --->
			<cfset NewImage.init(JavaCast("int", arguments.width), JavaCast("int", arguments.height), JavaCast("int", type)) />
		</cfif>
		
		<!--- return the new image --->
		<cfreturn NewImage />
	</cffunction>
	
	<cffunction name="getImageForLoad" access="private" output="false" returntype="any">
		<cfset setImageLoaded(true) />
		<cfreturn getImage() />
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
       <cfif NOT getImageLoaded()>
			<cfthrow
				type="Alagad.Image.NoImageLoaded"
				message="There was an error accessing image data. Before calling methods to work with image data you must first read or create an image with readImage() or createImage() respectively." />
		</cfif>
		<cfreturn variables.image />
    </cffunction>
	
	<!--- setImageReader
	<cffunction name="setImageReader" access="private" output="false" returntype="void">
       <cfargument name="ImageReader" hint="I am the ImageReader we're working with" required="yes" type="any" />
       <cfset variables.ImageReader = arguments.ImageReader />
    </cffunction>
    <cffunction name="getImageReader" access="private" output="false" returntype="any">
       <cfreturn variables.ImageReader />
    </cffunction> --->
	
	<!--- imageIO --->
    <cffunction name="setImageIO" access="private" output="false" returntype="void">
       <cfargument name="imageIO" hint="I am used to read, write and create images" required="yes" type="any" />
       <cfset variables.imageIO = arguments.imageIO />
    </cffunction>
    <cffunction name="getImageIO" access="private" output="false" returntype="any">
       <cfreturn variables.imageIO />
    </cffunction>		
	
	<!--- imageLoaded --->
    <cffunction name="setImageLoaded" access="private" output="false" returntype="void">
       <cfargument name="imageLoaded" hint="I indicate if an image has been loaded." required="yes" type="boolean" />
       <cfset variables.imageLoaded = arguments.imageLoaded />
    </cffunction>
    <cffunction name="getImageLoaded" access="private" output="false" returntype="boolean">
       <cfreturn variables.imageLoaded />
    </cffunction>
</cfcomponent>
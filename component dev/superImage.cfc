<cfcomponent displayname="SuperImage"
	extends="Image"
	hint="I add a few methods to the Alagad Image Component.">
	
	<cffunction name="writeGif" access="public" hint="I write a gif Image!" output="false" returntype="void">
		<cfargument name="path" hint="I am the path to write the GIF image to." required="yes" type="string" />
		<cfset var BufferedImage = getBufferedImage() />
		<cfset var FileOutputStream = CreateObject("Java", "java.io.FileOutputStream").init(JavaCast("string", arguments.path)) />
		<cfset var GifEncoder = CreateObject("Java", "Acme.JPM.Encoders.GifEncoder").init(BufferedImage, FileOutputStream) />

		<!--- write the gif image! --->
		<cfset GifEncoder.encode() />
	</cffunction>
		
	<cffunction name="drawImageInCenterBottom" access="public" hint="I draw an image into the center bottom of the current Image." output="false" returntype="void">
		<cfargument name="path" hint="I am the path of the image to draw." required="yes" type="string" />
		<cfset var myWatermark = CreateObject("Component", "SuperImage") />
		<!--- get the image's width and height --->
		<cfset var imgWidth = getWidth() />
		<cfset var imgHeight = getHeight() />
		<!--- declare the watermark's width and height --->
		<cfset var waterWidth = 0 />
		<cfset var waterHeight = 0 />
		<!--- declare x and y --->
		<cfset x = 0 />
		<cfset y = 0 />
		
		<!--- read the watermark --->
		<cfset myWatermark.readImage(arguments.path) />
				
		<!--- get the watermark's width and height --->
		<cfset waterWidth = myWatermark.getWidth() />
		<cfset waterHeight = myWatermark.getHeight() />
		
		<!--- get the coordinates to draw into --->
		<cfset x = Round((imgWidth - waterWidth)/2) />
		<cfset y = imgHeight - waterHeight />
		
		<!--- draw the watermark into the image --->
		<cfset drawImage(arguments.path, x, y) />
	</cffunction>
	 
</cfcomponent>
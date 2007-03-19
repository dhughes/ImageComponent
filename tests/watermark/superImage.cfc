<cfcomponent displayname="SuperImage"
	extends="Image2.Image"
	hint="I add a few methods to the Alagad Image Component.">
	
	<cffunction name="writeGif" access="public" hint="I write a gif Image!" output="false" returntype="void">
		<cfargument name="path" hint="I am the path to write the GIF image to." required="yes" type="string" />
		<cfset var BufferedImage = getBufferedImage() />
		<cfset var FileOutputStream = CreateObject("Java", "java.io.FileOutputStream").init(JavaCast("string", arguments.path)) />
		<cfset var GifEncoder = CreateObject("Java", "Acme.JPM.Encoders.GifEncoder").init(BufferedImage, FileOutputStream) />

		<!--- write the gif image! --->
		<cfset GifEncoder.encode() />
	</cffunction>
	
	<!--- 
	<cffunction name="drawImageInCenterBottom" access="public" hint="I draw an image into the center bottom of the current Image." output="false" returntype="void">
		<cfargument name="path" hint="I am the path of the image to draw." required="yes" type="string" />
		<cfset var newImage = CreateObject("Component", "SuperImage").setKet(getKey()) />
	</cffunction>
	 --->
	 
</cfcomponent>
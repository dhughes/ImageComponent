<cfcomponent name="readImageFromURL" extends="aicTestRoot" output="false" hint="This tests the AIC readImageFromURL methods">
	
	<cffunction name="test_readImageFromURL" returntype="void" access="public" output="false" hint="I read supported image formats.">
		<cfset myImage.readImageFromURL(getInputUrl() & getGIF()) />
		<cfset myImage.readImageFromURL(getInputUrl() & getJPEG()) />
		<cfset myImage.readImageFromURL(getInputUrl() & getPNG()) />
	</cffunction>
	
	<cffunction name="test_readImageFromURL_fromBadURL" returntype="void" access="public" output="false" hint="I attempt to read an image from a bad URL.">
		<cftry>
			<cfset myImage.readImageFromURL(getInputUrl() & getImageBadPath()) />
			<cfset fail("Alagad.Image.InvalidPath not thrown.") />
			
			<cfcatch type="Alagad.Image.ErrorOpeningURL"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_readImageFromURL_fromCorruptFile" returntype="void" access="public" output="false" hint="I attempt to read an image from a corrupted file.">
		<cftry>
			<cfset myImage.readImageFromURL(getInputUrl() & getCorruptFile()) />
			<cfset fail("Alagad.Image.ErrorReadingFile not thrown.") />
			
			<cfcatch type="Alagad.Image.ErrorReadingImage"></cfcatch>
		</cftry>
	</cffunction>
		
	<cffunction name="test_readImageFromURL_fromNonImage" returntype="void" access="public" output="false" hint="I attempt to read a number of non-image formats.">
		<cftry>
			<cfset myImage.readImageFromURL(getInputUrl() & getNonImage1()) />
			<cfset fail("No Image Reader Found error not thrown.") />
			
			<cfcatch type="Alagad.Image.ImageReaderNotFound"></cfcatch>
		</cftry>
		
		<cftry>
			<cfset myImage.readImageFromURL(getInputUrl() & getNonImage2()) />
			<cfset fail("No Image Reader Found error not thrown.") />
			
			<cfcatch type="Alagad.Image.ImageReaderNotFound"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_readImageFromURL_fromUnreadableFile" returntype="void" access="public" output="false" hint="I attempt to read an image from a file which I do not have permissions on.  This is intended to test the ErrorReadingFile error.">
		<cftry>
			<cfset myImage.readImageFromURL(getInputUrl() & getNoPermissionsFile()) />
			<cfset fail("File Read Error not thrown.") />
			
			<cfcatch type="Alagad.Image.ErrorOpeningURL"></cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>
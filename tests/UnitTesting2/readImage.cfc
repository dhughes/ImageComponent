<cfcomponent name="readImage" extends="aicTestRoot" output="false" hint="This tests the AIC readImage methods">
	
	<cffunction name="test_readImage" returntype="void" access="public" output="false" hint="I read supported image formats.">
		<cfset myImage.readImage(getInputDirectory() & getGIF()) />
		<cfset myImage.readImage(getInputDirectory() & getJPEG()) />
		<cfset myImage.readImage(getInputDirectory() & getPNG()) />
	</cffunction>
	
	<cffunction name="test_readImage_fromBadPath" returntype="void" access="public" output="false" hint="I attempt to read an image from a bad path.">
		<cftry>
			<cfset myImage.readImage(getInputDirectory() & getImageBadPath()) />
			<cfset fail("Alagad.Image.InvalidPath not thrown.") />
			
			<cfcatch type="Alagad.Image.InvalidPath"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_readImage_fromCorruptFile" returntype="void" access="public" output="false" hint="I attempt to read an image from a corrupted file.">
		<cftry>
			<cfset myImage.readImage(getInputDirectory() & getCorruptFile()) />
			<cfset fail("Alagad.Image.ErrorReadingFile not thrown.") />
			
			<cfcatch type="Alagad.Image.ErrorReadingImage"></cfcatch>
		</cftry>
	</cffunction>
		
	<cffunction name="test_readImage_fromNonImage" returntype="void" access="public" output="false" hint="I attempt to read a number of non-image formats.">
		<cftry>
			<cfset myImage.readImage(getInputDirectory() & getNonImage1()) />
			<cfset fail("No Image Reader Found error not thrown.") />
			
			<cfcatch type="Alagad.Image.ImageReaderNotFound"></cfcatch>
		</cftry>
		
		<cftry>
			<cfset myImage.readImage(getInputDirectory() & getNonImage2()) />
			<cfset fail("No Image Reader Found error not thrown.") />
			
			<cfcatch type="Alagad.Image.ImageReaderNotFound"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_readImage_fromUnreadableFile" returntype="void" access="public" output="false" hint="I attempt to read an image from a file which I do not have permissions on.  This is intended to test the ErrorReadingFile error.">
		<cftry>
			<cfset myImage.readImage(getInputDirectory() & getNoPermissionsFile()) />
			<cfset fail("File Read Error not thrown.") />
			
			<cfcatch type="Alagad.Image.ErrorOpeningFile"></cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>
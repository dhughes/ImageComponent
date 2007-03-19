<cfcomponent name="readFromBase64" extends="aicTestRoot" output="false" hint="This tests the AIC readFromBase64 method">
	
	<cffunction name="test_readFromBase64" returntype="void" access="public" output="false" hint="I read supported image formats.">
		<cfset myImage.readFromBase64(getBase64GIF()) />
		<cfset myImage.readFromBase64(getBase64JPEG()) />
		<cfset myImage.readFromBase64(getBase64PNG()) />
	</cffunction>
	
	<cffunction name="test_readFromBase64_fromBadData" returntype="void" access="public" output="false" hint="I attempt to read an image from non-base64 data.">
		<cftry>
			<cfset myImage.readFromBase64("sdasdfsdadfsdf") />
			<cfset fail("Alagad.Image.Base64ConversionError not thrown.") />
			
			<cfcatch type="Alagad.Image.Base64ConversionError"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_readFromBase64_fromCorruptFile" returntype="void" access="public" output="false" hint="I attempt to read an image from a corrupted file.">
		<cftry>
			<cfset myImage.readFromBase64(getBase64CorruptFile()) />
			<cfset fail("Alagad.Image.ErrorReadingFile not thrown.") />
			
			<cfcatch type="Alagad.Image.ErrorReadingImage"></cfcatch>
		</cftry>
	</cffunction>
		
	<cffunction name="test_readFromBase64_fromNonImage" returntype="void" access="public" output="false" hint="I attempt to read base64 encoded non-image formats.">
		<cftry>
			<cfset myImage.readFromBase64(getBase64NonImage()) />
			<cfset fail("No Image Reader Found error not thrown.") />
			
			<cfcatch type="Alagad.Image.ImageReaderNotFound"></cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>
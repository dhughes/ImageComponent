<cfcomponent name="writeToBase64" extends="aicTestRoot" output="false" hint="This tests the AIC writeToBase64 methods">
	
	<!--- generic setup --->
	<cffunction name="setUp" returntype="void" access="private">
		<cfset variables.myImages = ArrayNew(1) />
		
		<cfset variables.myImages[1] = CreateObject("component", variables.image) />
		<cfset variables.myImages[1].readImage(getInputDirectory() & getGIF()) />
		
		<cfset variables.myImages[2] = CreateObject("component", variables.image) />
		<cfset variables.myImages[2].readImage(getInputDirectory() & getJPEG()) />
		
		<cfset variables.myImages[3] = CreateObject("component", variables.image) />
		<cfset variables.myImages[3].readImage(getInputDirectory() & getPNG()) />
	</cffunction>
		
	<!--- write to invalid formats --->
	<cffunction name="test_writeToBase64_toInvalidFormat" returntype="void" access="public" output="false" hint="I try to write to an invalid image type">
		<cftry>
			<cfset variables.myImages[1].writeToBase64("badFormat") />
			<cfset fail("Alagad.Image.InvalidFormat not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidFormat"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_writeToBase64_quality" returntype="void" access="public" output="false" hint="I test the quality setting.">
		<!--- -10, 0, 50, 100, 110 --->
		<cftry>
			<cfset variables.myImages[1].writeToBase64("jpg", -10) />
			<cfset fail("Alagad.Image.InvalidQualitySetting not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidQualitySetting"></cfcatch>
		</cftry>
		
		<cfset variables.myImages[1].writeToBase64("jpg", 0) />
		<cfset variables.myImages[1].writeToBase64("jpg", 50) />
		<cfset variables.myImages[1].writeToBase64("jpg", 100) />
	
		<cftry>
			<cfset variables.myImages[1].writeToBase64("jpg", 110) />
			<cfset fail("Alagad.Image.InvalidQualitySetting not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidQualitySetting"></cfcatch>
		</cftry>
	</cffunction>
	
	<!--- write all read formats with to all writable formats --->
	<cffunction name="test_writeToBase64_allFormats" returntype="void" access="public" output="false" hint="I attempt to write to all formats.">
		<cfset var x = 0 />
		<cfset var imageFormats = "jpg,png" />
		<cfset var format = "" />
		
		<cfloop from="1" to="#ArrayLen(variables.myImages)#" index="x">
			<!--- loop over the supported formats --->
			<cfloop list="#imageFormats#" index="format">
				<!--- write to this format (no compression) --->
				<cfset variables.myImages[x].writeToBase64(format) />
			</cfloop>
		</cfloop>
	</cffunction>
	
	<cffunction name="test_writeToBase64_noImageLoaded" returntype="void" access="public" output="false" hint="I attempt to write an image when no image has been loaded or created">
		<!--- write image which hasn't been read or created --->
		<cfset myImageTest = CreateObject("component", variables.image) />
		<cftry>
			<cfset myImageTest.writeToBase64("jpg") />
			<cfset fail("Alagad.Image.NoImageLoaded not thrown") />
			
			<cfcatch type="Alagad.Image.NoImageLoaded"></cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>
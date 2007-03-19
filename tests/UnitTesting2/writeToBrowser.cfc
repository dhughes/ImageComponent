<cfcomponent name="writeToBrowser" extends="aicTestRoot" output="false" hint="This tests the AIC writeToBrowser methods">
	
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
	<cffunction name="test_writeToBrowser_toInvalidFormat" returntype="void" access="public" output="false" hint="I try to write to an invalid image type">
		<cftry>
			<cfset variables.myImages[1].writeToBrowser("badFormat") />
			<cfset fail("Alagad.Image.InvalidFormat not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidFormat"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_writeToBrowser_quality" returntype="void" access="public" output="false" hint="I test the quality setting.">
		<!--- -10, 0, 50, 100, 110 --->
		<cftry>
			<cfset variables.myImages[1].writeToBrowser("jpg", -10) />
			<cfset fail("Alagad.Image.InvalidQualitySetting not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidQualitySetting"></cfcatch>
		</cftry>
		
		<!--- I can't test these because when they work they overwrite the output buffer --->
		<!--- <cfset variables.myImages[1].writeToBrowser("jpg", 0) />
		<cfset variables.myImages[1].writeToBrowser("jpg", 50) />
		<cfset variables.myImages[1].writeToBrowser("jpg", 100) /> --->
	
		<cftry>
			<cfset variables.myImages[1].writeToBrowser("jpg", 110) />
			<cfset fail("Alagad.Image.InvalidQualitySetting not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidQualitySetting"></cfcatch>
		</cftry>
	</cffunction>
		
	<cffunction name="test_writeToBrowser_noImageLoaded" returntype="void" access="public" output="false" hint="I attempt to write an image when no image has been loaded or created">
		<!--- write image which hasn't been read or created --->
		<cfset myImageTest = CreateObject("component", variables.image) />
		<cftry>
			<cfset myImageTest.writeToBrowser("jpg") />
			<cfset fail("Alagad.Image.NoImageLoaded not thrown") />
			
			<cfcatch type="Alagad.Image.NoImageLoaded"></cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>
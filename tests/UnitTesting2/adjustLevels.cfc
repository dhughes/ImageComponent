<cfcomponent name="writeToBrowser" extends="aicTestRoot" output="false" hint="This tests the AIC writeToBrowser methods">
	
	<!--- generic setup --->
	<cffunction name="setUp" returntype="void" access="private">
		<cfset super.setup() />

		<cfset variables.myImage.readImage(getInputDirectory() & getJPEG()) />
		
	</cffunction>
	
	<!--- test a number of legal values --->
	<cffunction name="test_adjustLevels_legalValues" returntype="void" access="public" output="false" hint="I test a number of legal values">
		<cfset variables.myImage.adjustLevels(0, 255) />
		<cfset variables.myImage.adjustLevels(0, 255) />
		<cfset variables.myImage.adjustLevels(255, 255) />
		<cfset variables.myImage.adjustLevels(255, 0) />
		
		<cfset variables.myImage.adjustLevels(10, 10) />
		<cfset variables.myImage.adjustLevels(10, 245) />
		<cfset variables.myImage.adjustLevels(245, 245) />
		<cfset variables.myImage.adjustLevels(245, 10) />
	</cffunction>
	
	<!--- try to adjust indexed image --->
	<cffunction name="test_adjustLevels_indexedImage" returntype="void" access="public" output="false" hint="I try to adjust an indexed image.">
		<cfset myImage2 = CreateObject("component", variables.image) />
		<cfset myImage2.readImage(getInputDirectory() & getGIF()) />
		
		<cftry>
			<cfset myImage2.adjustLevels(0, 255) />
			<cfset fail("Alagad.Image.IndexedImageCanNotBeConvolved error not thrown") />
			
			<cfcatch type="Alagad.Image.IndexedImageCanNotBeConvolved"></cfcatch>
		</cftry>
	</cffunction>
	
	<!--- test a number of illegal values --->
	<cffunction name="test_adjustLevels_illegalValues" returntype="void" access="public" output="false" hint="I test a number of legal values">
		<cftry>
			<cfset variables.myImage.adjustLevels(-10, 245) />
			<cfset fail("Alagad.Image.InvalidArgumentValue not thrown") />
			<cfcatch type="Alagad.Image.InvalidArgumentValue"></cfcatch>
		</cftry>

		<cftry>
			<cfset variables.myImage.adjustLevels(10, 265) />
			<cfset fail("Alagad.Image.InvalidArgumentValue not thrown") />
			<cfcatch type="Alagad.Image.InvalidArgumentValue"></cfcatch>
		</cftry>

		<cftry>
			<cfset variables.myImage.adjustLevels(-10, 265) />
			<cfset fail("Alagad.Image.InvalidArgumentValue not thrown") />
			<cfcatch type="Alagad.Image.InvalidArgumentValue"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="tearDown" returntype="void" access="private">
		<cfset var dir = 0 />
		
		<!--- get a list of files in the directory --->
		<cfdirectory name="dir"
			directory="#getOutputDirectory()#" />
		
		<!--- loop over the files and delete them --->
		<cfloop query="dir">
			<cfif dir.type IS NOT "dir">
				<!--- delete the file --->
				<cffile action="delete"
					file="#getOutputDirectory()##name#" />
			</cfif>
		</cfloop>
	</cffunction>
	
</cfcomponent>
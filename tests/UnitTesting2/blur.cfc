<cfcomponent name="blur" extends="aicTestRoot" output="false" hint="This tests the AIC blur method">
	
	<!--- generic setup --->
	<cffunction name="setUp" returntype="void" access="private">
		<cfset super.setup() />

		<cfset variables.myImage.readImage(getInputDirectory() & getJPEG()) />
	</cffunction>
	
	<!--- test a number of legal values --->
	<cffunction name="test_blur_legalValues" returntype="void" access="public" output="false" hint="I test a number of legal values">
		<cfset variables.myImage.blur(0) />
		<cfset variables.myImage.blur(5) />
		<cfset variables.myImage.blur(10) />
		<cfset variables.myImage.blur(15) />
		<cfset variables.myImage.blur(20) />
		<cfset variables.myImage.blur(33) />
		<cfset variables.myImage.blur(50) />
	</cffunction>
	
	<!--- test a number of illegal values --->
	<cffunction name="test_blur_illegalValues" returntype="void" access="public" output="false" hint="I test a number of illegal values">
		<cftry>
			<cfset variables.myImage.blur(-1) />
			<cfset fail("Alagad.Image.InvalidArgumentValue not thrown") />
			<cfcatch type="Alagad.Image.InvalidArgumentValue"></cfcatch>
		</cftry>

		<cftry>
			<cfset variables.myImage.blur(-10, 265) />
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
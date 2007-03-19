<cfcomponent name="writeImage" extends="aicTestRoot" output="false" hint="This tests the AIC writeImage methods">
	
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
	
	<cffunction name="test_writeImage_toInvalidPath" returntype="void" access="public" output="false" hint="I try to write an an invalid paths.">
		<cftry>
			<!--- try to write to a directory --->
			<cfset variables.myImages[1].writeImage(getOutputDirectory(), "jpeg") />
			<cfset fail("Alagad.Image.InvalidPath not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidPath"></cfcatch>
		</cftry>
		
		<cftry>
			<!--- try to write to a drive that doesn't exist --->
			<cfset variables.myImages[1].writeImage("q:\DirectoryDoesNotExist\test.jpg", "jpeg") />
			<cfset fail("Alagad.Image.InvalidPath not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidPath"></cfcatch>
		</cftry>
		
		<cftry>
			<!--- try to write to a folder that does not exist. --->
			<cfset variables.myImages[1].writeImage("c:\DirectoryDoesNotExist\test.jpg", "jpeg") />
			<cfset fail("Alagad.Image.InvalidPath not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidPath"></cfcatch>
		</cftry>
	</cffunction>
	
	<!--- write to invalid formats --->
	<cffunction name="test_writeImage_toInvalidFormat" returntype="void" access="public" output="false" hint="I try to write to an invalid image type">
		<cftry>
			<cfset variables.myImages[1].writeImage(getOutputDirectory() & "file.badformat", "badFormat") />
			<cfset fail("Alagad.Image.InvalidFormat not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidFormat"></cfcatch>
		</cftry>
	</cffunction>
		
	<cffunction name="test_writeImage_toDirWithoutPerms" returntype="void" access="public" output="false" hint="I try to write an image to a directory without permissions.">
		<cftry>
			<cfset variables.myImages[1].writeImage(getNoPermsDir() & getJPEG(), "jpg", 50) />
			<cfset fail("Alagad.Image.InvalidPath not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidPath"></cfcatch>
		</cftry>
		
		<cftry>
			<cfset variables.myImages[1].writeImage(getNoPermsDir() & getJPEG(), "jpg") />
			<cfset fail("Alagad.Image.InvalidPath not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidPath"></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="test_writeImage_quality" returntype="void" access="public" output="false" hint="I test the quality setting.">
		<!--- -10, 0, 50, 100, 110 --->
		<cftry>
			<cfset variables.myImages[1].writeImage(getOutputDirectory() & getJPEG(), "jpg", -10) />
			<cfset fail("Alagad.Image.InvalidQualitySetting not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidQualitySetting"></cfcatch>
		</cftry>
		
		<cfset variables.myImages[1].writeImage(getOutputDirectory() & getJPEG(), "jpg", 0) />
		<cfset variables.myImages[1].writeImage(getOutputDirectory() & getJPEG(), "jpg", 50) />
		<cfset variables.myImages[1].writeImage(getOutputDirectory() & getJPEG(), "jpg", 100) />
	
		<cftry>
			<cfset variables.myImages[1].writeImage(getOutputDirectory() & getJPEG(), "jpg", 110) />
			<cfset fail("Alagad.Image.InvalidQualitySetting not thrown") />
			
			<cfcatch type="Alagad.Image.InvalidQualitySetting"></cfcatch>
		</cftry>
	</cffunction>
	
	<!--- write all read formats with to all writable formats --->
	<cffunction name="test_writeImage_allFormats" returntype="void" access="public" output="false" hint="I attempt to write to all formats.">
		<cfset var x = 0 />
		<cfset var imageFormats = "jpg,png" />
		<cfset var format = "" />
		
		<cfloop from="1" to="#ArrayLen(variables.myImages)#" index="x">
			<!--- loop over the supported formats --->
			<cfloop list="#imageFormats#" index="format">
				<!--- write to this format (no compression) --->
				<cfset variables.myImages[x].writeImage(getOutputDirectory() & "testimg", format) />
			</cfloop>
		</cfloop>
	</cffunction>
	
	<cffunction name="test_writeImage_noImageLoaded" returntype="void" access="public" output="false" hint="I attempt to write an image when no image has been loaded or created">
		<!--- write image which hasn't been read or created --->
		<cfset myImageTest = CreateObject("component", variables.image) />
		<cftry>
			<cfset myImageTest.writeImage(getOutputDirectory() & getJPEG(), "jpg") />
			<cfset fail("Alagad.Image.NoImageLoaded not thrown") />
			
			<cfcatch type="Alagad.Image.NoImageLoaded"></cfcatch>
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
<cfcomponent name="aictests" extends="org.cfcunit.framework.TestCase"output="false" hint="This tests the AIC">
	<cfset variables.image = "Image2.Image" />
	<cfset variables.InputDir = "input" />
	<cfset variables.OutputDir = "output" />
	<cfset variables.NoPermsDir = "noperms" />
	<cfset variables.RootURL = "http://aic2/tests/UnitTesting2/" />	
	<cfset variables.GIFImage = "AIC2HomePageButton.gif" />
	<cfset variables.JPEGImage = "forest1.jpg" />
	<cfset variables.PNGImage = "dynamicHeaderBackground.png" />
	<cfset variables.ImageBadPath = "IDontExist.gif" />
	<cfset variables.NonImage1 = "helloWorld.cfm" />
	<cfset variables.NonImage2 = "Document.doc" />
	<cfset variables.NoPermissionsFile = "NoPermissions.jpg" />
	<cfset variables.CorruptFile = "badImage.jpg" />
	<cfset variables.Base64GIFImage = "base64gif.txt" />
	<cfset variables.Base64JPEGImage = "base64jpg.txt" />
	<cfset variables.Base64PNGImage = "base64png.txt" />
	<cfset variables.Base64CorruptImage = "validBase64butBadImage.txt" />
	<cfset variables.Base64NonImage = "base64NonImage.txt" />
	
	<!--- generic setup --->
	<cffunction name="setUp" returntype="void" access="private">
		<cfset variables.myImage = CreateObject("component", variables.image) />
	</cffunction>
	
	<!----------------------->
	<!--- support methods --->
	<!----------------------->
	<cffunction name="getGIF" output="false" returntype="string">
		<cfreturn variables.GIFImage />
	</cffunction>
	
	<cffunction name="getJPEG" output="false" returntype="string">
		<cfreturn variables.JPEGImage />
	</cffunction>
	
	<cffunction name="getPNG" output="false" returntype="string">
		<cfreturn variables.PNGImage />
	</cffunction>
	
	<cffunction name="getImageBadPath" output="false" returntype="string">
		<cfreturn variables.imageBadPath />
	</cffunction>
	
	<cffunction name="getNonImage1" output="false" returntype="string">
		<cfreturn variables.nonImage1 />
	</cffunction>
	
	<cffunction name="getNonImage2" output="false" returntype="string">
		<cfreturn variables.nonImage2 />
	</cffunction>
		
	<cffunction name="getNoPermissionsFile" output="false" returntype="string">
		<cfreturn variables.NoPermissionsFile />
	</cffunction>
		
	<cffunction name="getCorruptFile" output="false" returntype="string">
		<cfreturn variables.CorruptFile />
	</cffunction>
	
	<cffunction name="getBase64GIF" output="false" returntype="string">
		<cfset var base64Data = "" />
		<cffile action="read"
			file="#getInputDirectory()##variables.Base64GIFImage#"
			variable="base64Data" />
		<cfreturn base64Data/>
	</cffunction>
	
	<cffunction name="getBase64JPEG" output="false" returntype="string">
		<cfset var base64Data = "" />
		<cffile action="read"
			file="#getInputDirectory()##variables.Base64JPEGImage#"
			variable="base64Data" />
		<cfreturn  base64Data/>
	</cffunction>
	
	<cffunction name="getBase64PNG" output="false" returntype="string">
		<cfset var base64Data = "" />
		<cffile action="read"
			file="#getInputDirectory()##variables.Base64PNGImage#"
			variable="base64Data" />
		<cfreturn  base64Data/>
	</cffunction>
	
	<cffunction name="getBase64CorruptFile" output="false" returntype="string">
		<cfset var base64Data = "" />
		<cffile action="read"
			file="#getInputDirectory()##variables.Base64CorruptImage#"
			variable="base64Data" />
		<cfreturn  base64Data/>
	</cffunction>
	
	<cffunction name="getBase64NonImage" output="false" returntype="string">
		<cfset var base64Data = "" />
		<cffile action="read"
			file="#getInputDirectory()##variables.Base64NonImage#"
			variable="base64Data" />
		<cfreturn  base64Data/>
	</cffunction>
	
	<cffunction name="getInputDirectory" output="false" returntype="string">
		<cfreturn getDirectory() & variables.InputDir & "\" />
	</cffunction>
	
	<cffunction name="getOutputDirectory" output="false" returntype="string">
		<cfreturn getDirectory() & variables.OutputDir & "\" />
	</cffunction>
	
	<cffunction name="getNoPermsDir" output="false" returntype="string">
		<cfreturn getOutputDirectory() & variables.NoPermsDir & "\" />
	</cffunction>

	<cffunction name="getInputUrl" output="false" returntype="string">
		<cfreturn getRootUrl() & variables.InputDir & "/" />
	</cffunction>

	<cffunction name="getRootUrl" output="false" returntype="string">
		<cfreturn variables.RootURL />
	</cffunction>
	
	<cffunction name="getDirectory" output="false" returntype="string">
		<cfreturn getDirectoryFromPath(getCurrentTemplatePath()) />
	</cffunction>
</cfcomponent>
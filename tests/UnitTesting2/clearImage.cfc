	<cfcomponent name="clearImage" extends="aicTestRoot" output="false" hint="This tests the AIC clearImage method">
	
	<!--- generic setup --->
	<cffunction name="setUp" returntype="void" access="private">
		<cfset super.setup() />

		<cfset variables.myImage.readImage(getInputDirectory() & getJPEG()) />
	</cffunction>
	
	<!--- test to make sure I can call this before I've set a background color --->
	<cffunction name="test_clearImage_noBeforeBackgroundSet" returntype="void" access="public" output="false" hint="I test to make sure I can call this before I've set a background color.">
		<cfset variables.myImage.clearImage() />
	</cffunction>
	
	<!--- set a background and test it --->
	<cffunction name="test_clearImage_withBackgroundColor" returntype="void" access="public" output="false" hint="I test a clearing the image after a background has been set.">
		<cfset red = variables.myImage.getColorByName("red") />
		<cfset variables.myImage.setBackgroundColor(red) />
		<cfset variables.myImage.clearImage() />
	</cffunction>
	
</cfcomponent>
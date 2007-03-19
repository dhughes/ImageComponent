	<cfcomponent name="clearRectangle" extends="aicTestRoot" output="false" hint="This tests the AIC clearRectangle method">
	
	<!--- generic setup --->
	<cffunction name="setUp" returntype="void" access="private">
		<cfset super.setup() />

		<cfset variables.myImage.readImage(getInputDirectory() & getJPEG()) />
	</cffunction>
	
	<!--- test to make sure I can call this before I've set a background color --->
	<cffunction name="test_clearRectangle_noBeforeBackgroundSet" returntype="void" access="public" output="false" hint="I test to make sure I can call this before I've set a background color.">
		<cfset variables.myImage.clearRectangle(10, 10, 10, 10) />
	</cffunction>
	
	<!--- set a background and test it --->
	<cffunction name="test_clearRectangle_withBackgroundColor" returntype="void" access="public" output="false" hint="I test a clearing the image after a background has been set.">
		<cfset red = variables.myImage.getColorByName("red") />
		<cfset variables.myImage.setBackgroundColor(red) />
		<cfset variables.myImage.clearRectangle(10, 10, 10, 10) />
	</cffunction>
	
	<!--- test a number of legal values --->
	<cffunction name="test_clearRectangle_legalValues" returntype="void" access="public" output="false" hint="I test a number of ways to legally call this method.">
		<cfset variables.myImage.clearRectangle(-5, -5, -5, -5) />
		<cfset variables.myImage.clearRectangle(-5, -5, -5, 5) />
		<cfset variables.myImage.clearRectangle(-5, -5, 5, -5) />
		<cfset variables.myImage.clearRectangle(-5, 5, -5, -5) />
		<cfset variables.myImage.clearRectangle(5, -5, -5, -5) />
		<cfset variables.myImage.clearRectangle(5, -5, -5, 5) />
		<cfset variables.myImage.clearRectangle(5, 5, 5, 5) />
		<cfset variables.myImage.clearRectangle(myImage.getWidth() + 5, myImage.getHeight() + 5, myImage.getWidth() + 5, myImage.getHeight() + 5) />
	</cffunction>
	
</cfcomponent>
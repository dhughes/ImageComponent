<cfcomponent name="allTests" extends="org.cfcunit.Object" output="false" hint="Runs all unit tests in package.">

	<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false" hint="">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite").init("All cfcUnit Tests")>

		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.readImage"))>
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.readImageFromUrl"))>
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.readFromBase64"))>
		
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.writeImage"))>
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.writeToBase64"))>
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.writeToBrowser"))>
		
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.adjustLevels"))>
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.blur"))>
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.clearImage"))>
		<cfset testSuite.addTestSuite(newObject("tests.UnitTesting2.clearRectangle"))>
		
		<cfreturn testSuite/>
	</cffunction>	

</cfcomponent>
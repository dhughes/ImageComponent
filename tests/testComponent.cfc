<cfcomponent displayname="testComponent">

	<cffunction name="testGettingMetaData" access="public" output="false" returntype="string">
		<cfargument name="Font" hint="I am the font to use." required="no" type="any" default="" />
		<cfset var success = false />
		
		<cfreturn getMetaData(arguments.Font).getName() />
	</cffunction>

</cfcomponent>
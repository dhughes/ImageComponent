<cfset myImage = CreateObject("Component", "Image2.Image").setKey("4QDGB-ANJ39-8L2QX-BJL15-67YQB") />

<cfset myString = "test" />
<cfset myStringLen=len(myString)>

<!--- create string --->
<cfset advancedString = myImage.createString(myString) /> 

<cfdump var="#advancedString#" />
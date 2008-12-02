


 Image component in CF8

<cfset thisPhoto = CreateObject("Component","Image")/>
<cfset thisPhoto.setKey("HL7BA-21CJ8-YTGM5-BMB6D-GPMAG")/>
<cfset thisPhoto.readImage("c:\inetpub\imagecomponent\tests\vrydertests\glynn\vicpotato2.jpg","RGB","JPG")/>

<!---
<cfset thisPhoto.readImage("c:\inetpub\imagecomponent\tests\vrydertests\glynn\fails2.jpg")/> 
--->

<cfoutput>
<p><b>Get Size:</b> #thisPhoto.getSize("jpg")# Bytes</p>

</cfoutput>



<!---

<cfset myImage=ImageRead("c:\inetpub\imagecomponent\tests\vrydertests\glynn\fails2.jpg")>

<cfimage action="writeToBrowser" source="#myImage#">

--->






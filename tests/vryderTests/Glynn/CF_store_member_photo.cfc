<cfcomponent>

<cffunction name = "CF_store_member_photo" hint="insert member profile"    returntype="any"
    access="remote">
<cfargument name = "flash_MEMBER_ID" type="any" required="true" default="0"> 
<cfargument name = "flash_CUR_PHOTO" type="any" required="true" default="0">
<cfargument name = "flash_OLD_PHOTO_NAME" type="any" required="true" default="0">   
<cfargument name = "flash_NEW_PHOTO_NAME" type="any" required="true" default="0">           
<cfargument name = "flash_PHOTO_SIZE" type="any" required="true" default="0">
 
<cfif flash_CUR_PHOTO IS NOT 'no photo'>
    <cfif FileExists("c:\inetpub\imagecomponent\tests\vrydertests\glynn\#flash_CUR_PHOTO#")>
         <cffile action = "delete"  file = "c:\inetpub\imagecomponent\tests\vrydertests\glynn\#flash_CUR_PHOTO#">
    </cfif>
</cfif>

<!---<cfargument name = "flash_GROUP_DIRECTORY" type="any" required="true" default="0">--->
 
        <!--- P H O T O --->
    <!--- create the object --->
        <cfset thisPhoto = CreateObject("Component","Image")/>
        <cfset thisPhoto.setKey("HL7BA-21CJ8-YTGM5-BMB6D-GPMAG")/>
        
   <!--- open the image to resize /g:/sites/gaggleputz/groups/--->
   <cfset thisPhoto.readImage("c:\inetpub\imagecomponent\tests\vrydertests\glynn\#flash_OLD_PHOTO_NAME#")/>
   
   <!--- get image W & H --->
        <cfset thisPhotoW = thisPhoto.getWidth()>
        <cfset thisPhotoH = thisPhoto.getHeight()>
 
 
   <!--- resize the image to a specific width and height --->
   <cfset thisPhoto.scaleToBox(170, 340) />
 
   <!--- output the image in JPG format --->
   <cfset thisPhoto.writeImage("c:\inetpub\imagecomponent\tests\vrydertests\glynn\#flash_NEW_PHOTO_NAME#", "jpg", 80)/>
   
    <!--- get image size to db --->
    <cfset thisPhotoSize = thisPhoto.getSize("jpg") />

<!---        
        <cfquery name = "doInsertSQL" datasource="gagglePUTZ_sql"> 
         UPDATE GP_MEMBER_PROFILE
         SET PHOTO_NAME = '#flash_NEW_PHOTO_NAME#'
         WHERE ID = #flash_MEMBER_ID#
        </cfquery>
        
        <cffile   action = "delete"  file = "g:\sites\gaggleputz\members\images\#flash_OLD_PHOTO_NAME#">
--->
 
 <cfreturn '#thisPhotoSize#'>
 
 
 
</cffunction>

</cfcomponent>
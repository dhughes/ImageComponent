<!--- create the object --->


<!--- set args --->
<cfset flash_MEMBER_ID = "21" />
<cfset flash_CUR_PHOTO = "currentphoto.jpg" />
<cfset flash_OLD_PHOTO_NAME = "fastUpSloProc.jpg" />
<cfset flash_NEW_PHOTO_NAME = "fastUpSlowProcAfter.jpg" />
<cfset flash_PHOTO_SIZE = 0 />

<cfset myPhotoTest = CreateObject("Component","glynncomponent") />

<cfdump var="#myPhotoTest#">


<!---
<!--- output the images --->
<table>
<tr>
	<td>
		<b>Before</b><br>
		<img src="FastUpSloProc.jpg">
	</td>
	<td>
		<b>After</b><br>
		<img src="FastUpSloProcAfter.jpg">
	</td>
</tr>
</table>
--->
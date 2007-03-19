<cfobject component="Image2.Image" name="MmyImage" />
<cfset MmyImage.setKey('JTTQ6-XLRGJ-2T6CY-YBEYM-NPTNU') />

 

<cfset MmyImage.readImage(expandPath("test.gif")) />

 

<cfset MmyImage.writeToBrowser("jpg") />

 


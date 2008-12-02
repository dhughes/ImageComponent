<!--- Issue being addressed: The 2 remaining photos are copies of each other.  Prior to upgrading to Coldfusion 8 the one entitled “fails” uploaded and processed with no problems.  After upgrading to Coldfusion 8 it uploads no problem but does not process according to the script I sent you.  I had to open it in Photoshop and “save for web” adjusting to get roughly the same size and then it uploads and process no problem. 

Started exploring why this might happen by looking through the various read functions and options in the AIC docs.  However, I'm thinking more likely it is banging heads with something in CF8.  Why would it be readable before CF8 and not after.  Tho, it still could be something that needs now to be specified.  --->

<!--- create the object --->
<cfset thisPhoto = CreateObject("Component","Image")/>
<cfset thisPhoto.setKey("HL7BA-21CJ8-YTGM5-BMB6D-GPMAG")/>

<!--- This gives a little more detail on readable formats, but nothing that suggests why this jpg might be corrupt while a copy "adjusted for web" does not.

<cfset foo = thisPhoto.getReadableFormats()>
<cfdump var = "#foo#">
<cfabort> 
--->

<!--- Read the source image. --->

<cfset thisPhoto.readImage("c:\inetpub\imagecomponent\tests\vrydertests\glynn\fails2.jpg", "jpg")/>


<!--- Get width and height. --->

<cfset thisPhotoW = thisPhoto.getWidth()>
<cfset thisPhotoH = thisPhoto.getHeight()>

<!--- resize the image to a specific width and height --->
   
<cfset thisPhoto.scaleToBox(170, 340) />


<cfset thisPhoto.writeImage("c:\inetpub\imagecomponent\tests\vrydertests\glynn\failsAfter.jpg", "jpg", 80)/>

<cfset thisPhotoSize = thisPhoto.getSize("jpg") />

<!--- output both images --->

<p>

<b>failing pic before:</b><br>

<img src="fails.jpg">

</p>

 

<p>

<b>failing pic after</b><br>

<img src="failsAfter.jpg">

</p>


<p>
Photo size: <cfoutput>#thisPhotoSize#</cfoutput> 

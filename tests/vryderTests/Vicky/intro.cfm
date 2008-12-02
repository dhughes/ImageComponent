

<!--- create the object --->

<cfset myImage = CreateObject("Component","Image") />



 <!---
<!--- read the source GIF image --->

<cfset myImage.readImage("c:\inetpub\imagecomponent\tests\vrydertests\vicky\original.jpg") />


<cfoutput>#myImage.getImageMode()#</cfoutput>

 output the image in PNG format 
<cfset myImage.writeImage("c:\inetpub\imagecomponent\tests\vrydertests\vicky\riverpic.png", "png") />
--->
 

<!--- output both images --->

<p>

<b>original.jpg:</b><br>

<img src="original.jpg">

</p>


<p>

<b>hisprocessed.jpg:</b><br>

<img src="testimage_processed.jpg">

</p>


<p>

<b>Mine converted then processed:</b><br>

<img src=".jpg">

</p>
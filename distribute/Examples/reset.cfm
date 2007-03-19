<cfset files = "
/Control Image Compression Quality/example0.jpg
/Control Image Compression Quality/example10.jpg
/Control Image Compression Quality/example20.jpg
/Control Image Compression Quality/example30.jpg
/Control Image Compression Quality/example40.jpg
/Control Image Compression Quality/example50.jpg
/Control Image Compression Quality/example60.jpg
/Control Image Compression Quality/example70.jpg
/Control Image Compression Quality/example80.jpg
/Control Image Compression Quality/example90.jpg
/Control Image Compression Quality/example100.jpg
/Creating and Drawing Into a New Image/newImage.png
/Draw Images into an Image/wineRoseLogo.jpg
/Draw Text on an Image/catCupAndText.jpg
/Reading and Writing an Image/shells.png
/Resize an Image/fatherAndSon-small.jpg
" />

<cfloop list="#files#" index="fileItem" delimiters="#chr(13)##chr(10)#">
	<cftry>
		<cffile action="delete"
			file="#expandPath(trim(fileItem))#" />
		<cfcatch></cfcatch>
	</cftry>
</cfloop>

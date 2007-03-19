<cfset directory = expandPath(".\") />
<cfset directory2 = expandPath(".\") />
<cfset FileServerFile = "20P nailheads1.jpeg" />
<cfset selected_orderdetailID = 1 />
<cfset position = 1 />
<cfset epoch = "test" />

<!--- first, create an instance of the Image Component --->
<cfset myImage = CreateObject("Component", "Image2.Image").setKey("7HFWP-M00KR-8VX9R-0EBLW-VF01C") />

<!--- read the uploaded image --->
<cfset myImage.readImage(directory & FileServerFile) />

<!--- check to see if the image is larger than 150x150 --->
<cfif myImage.getWidth() GT 150 OR myImage.getHeight() GT 150>
	<!--- resize the image to fit within 150x150 --->
	<cfset myImage.scaleToFit(144) />
</cfif>
<!--- set the image background color and create a border --->
<cfset gray = myImage.CreateColor(223,223,223) />
<cfset myImage.setBackgroundColor(gray) />
<cfset myImage.setImageSize(myImage.getWidth() + 6, myImage.getHeight() + 6, "middleCenter") />
<!--- sharpen the image (removed because it adds a border arround the image
<cfset myImage.sharpen(2, 2) /> --->

<!--- output the thumbnail image --->
<cfset myImage.writeImage("#directory##selected_orderdetailID##position##epoch#.jpg", "jpg") />

<!--- create the fullsize image --->
			
<!--- read the uploaded image --->
<cfset myImage.readImage(directory & FileServerFile) />
<!--- set the background color --->
<cfset myImage.setBackgroundColor(gray) />
<!--- check to see if the image is larger than 530x530 --->
<cfif myImage.getWidth() GT 530 OR myImage.getHeight() GT 530>
	<!--- resize the image to fit within 530x530 --->
	<cfset myImage.scaleToFit(524) />
</cfif>
<!--- set the image background color and create a border --->
<cfset white = myImage.CreateColor(0,0,0) />
<cfset myImage.setImageSize(myImage.getWidth() + 6, myImage.getHeight() + 6, "middleCenter") />
<!--- output the thumbnail image --->
<cfset myImage.writeImage("#directory2##selected_orderdetailID##position##epoch#.jpg", "jpg") />

<!--- create the two image objects --->
<cfset myImage = CreateObject("Component", "Image2.Image") />
<cfset myWatermark = CreateObject("Component", "Image2.Image") />

<!--- read the image and watermark --->
<cfset myImage.readImage(expandPath("forest1.jpg")) />
<cfset myWatermark.readImage(expandPath("watermark.png")) />

<!--- get the image's width and height --->
<cfset imgWidth = myImage.getWidth() />
<cfset imgHeight = myImage.getHeight() />

<!--- get the watermark's width and height --->
<cfset waterWidth = myWatermark.getWidth() />
<cfset waterHeight = myWatermark.getHeight() />

<!--- get the coordinates to draw into --->
<cfset x = Round((imgWidth - waterWidth)/2) />
<cfset y = imgHeight - waterHeight />

<!--- draw the watermark into the image --->
<cfset myImage.drawImage(expandPath("watermark.png"), x, y) />

<!--- write the new image to disk --->
<cfset myImage.writeImage(expandPath("watermarkedImage.jpg"), "jpg") />

<img src="watermarkedImage.jpg">





<!--- create the object --->
<cfset myImage = CreateObject("Component", "Image2.Image") />
	
<!--- crate a new image --->
<cfset myImage.createImage(450, 150) />

<!--- create a font and color --->
<cfset times = myImage.loadSystemFont("Times New Roman", 50, "bold") />
<cfset lightGray = myImage.getColorByName("lightGray") />
<cfset darkBlue = myImage.getColorByName("darkBlue") />

<!--- fill the background --->
<cfset myImage.setBackgroundColor(lightGray) />
<cfset myImage.clearImage() />

<!--- draw text into the images --->
<cfset myImage.setFill(darkBlue) />
<cfset myImage.drawSimpleString("This is an example!", 20, 50, times) />

<!--- write and display the image --->
<cfset myImage.writeImage(expandPath("example1.png"), "png") />
<p>Before trimming:</p>
<img src="example1.png" />

<!--- trim the edges off the image --->
<cfset myImage.trimEdges("topLeft", true, true, true, true) />

<!--- write and display the trimmed image --->
<cfset myImage.writeImage(expandPath("example2.png"), "png") />
<p>After trimming:</p>
<img src="example2.png" />
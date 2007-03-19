<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />
<cfset myImage.setKey("5815C-Q7X8K-F99X1-A0Q9Y-UDW0V") />

<!--- open the eyewear image --->
<cfset myImage.readImage(expandPath('CK198s_flex_polycarbonate_small.png')) />
<cfset myImage.scalePixels(80, 30) />
<!--- output the new image --->
<cfset myImage.writeImage(expandPath('test.png'), 'png') />


<cfset myImage.readImage(expandPath('uploadpicture.jpeg')) />

<!--- draw the image into the picture --->
<cfset myImage.drawImage(expandPath('test.png'), 70, 84) />

<!--- output the new image --->
<cfset myImage.writeImage(expandPath('test.jpg'), 'jpg') />

<img src="test.jpg" />
<cfset myImage = CreateObject('Component', 'Image2.Image') />

<cfset myImage.readImage(expandPath('unitTesting/forest1.jpg')) />


<cfset myImage.writeImage(expandPath('testImage.jpg'), 'jpg') />


<img src="testImage.jpg">
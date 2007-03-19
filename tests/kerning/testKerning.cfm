
<!--- create the image --->
<cfset myImage = CreateObject("component", "Image2.NeuImage") />
<cfset myImage.createImage(600,200) />

<!--- read the sample image --->
<cfset myImage.readImage(expandPath("pskerning.png")) />

<!--- create a color --->
<cfset red = myImage.getColorByName("red") />

<!--- times new roman text --->
<cfset tnr = myImage.loadSystemFont("Times New Roman", 28, "bold") />
<cfset myImage.setFill(red) />
<cfset myImage.drawSimpleString("THE COMMUNITY FOUNDATION", 9, 59, tnr, 590) />

<!--- arial text --->
<cfset arial = myImage.loadSystemFont("Arial", 28, "bold") />
<cfset myImage.setFill(red) />
<cfset myImage.drawSimpleString("THE COMMUNITY FOUNDATION", 9, 229, arial, 570) />


<cfset myImage.writeImage(expandPath("kerning.png"), "png") />

<img src="kerning.png">

<cfdump var="#myImage.getSimpleStringMetrics("THE COMMUNITY FOUNDATION", arial)#" />
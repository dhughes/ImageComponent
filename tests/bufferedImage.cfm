<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- create a new BufferedImage --->
<cfset BufferedImage = CreateObject('java', 'java.awt.image.BufferedImage') />
<cfset BufferedImage.init(JavaCast("int", 100), JavaCast("int", 100), JavaCast("int", BufferedImage.TYPE_INT_RGB)) />

<!--- set the BufferedImage ---->
<cfset myImage.setBufferedImage(BufferedImage) />

<!--- draw into the image --->
<cfset myImage.drawOval(10, 10, 80, 80) />

<!--- output the image --->
<cfset myImage.writeImage("d:\examples\example.png", "png") />

<!--- show the images --->
<b>New Image</b><br>
<img src="/examples/example.png"><Br>
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />
<cfset myImage.setKey("4QDGB-ANJ39-8L2QX-BJL15-67YQB") />

<!--- open the image to resize --->
<cfset myImage.readImage("d:\examples\fatherAndSon.jpg") />

<!--- resize the image Proportionately to 50 pixels wide --->
<cfset myImage.scaleWidth(100) />

<!--- output the image in JPG format --->
<cfset myImage.writeImage("d:\examples\fatherAndSon-small.jpg", "jpg") />

<!--- the new images --->
<p>
<b>fatherAndSon.jpg:</b><br>
<img src="/examples/fatherAndSon.jpg">
</p>
<p>
<b>fatherAndSon-small.jpg:</b><br>
<img src="/examples/fatherAndSon-small.jpg">
</p>

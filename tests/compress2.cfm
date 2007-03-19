<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />
<cfset myImage.setKey("4QDGB-ANJ39-8L2QX-BJL15-67YQB") />

<!--- create a new image --->
<cfset myImage.readImage(expandPath("compressWalking.jpg")) />

<!--- output the image in JPG format with example compression settings--->
<cfset myImage.writeImage(expandPath("example90.jpg"), "jpg", 100) />

<!--- output both images --->
<p>
<b>example90.jpg:</b><br>
<img src="example90.jpg">
</p>
<!--- 
<p>
<b>example90.jpg:</b><br>
<img src="example90.jpg">
</p>


 --->
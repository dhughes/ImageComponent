<!--- create the object --->
<cfset myImage = CreateObject("Component","Image.Image") />

<!--- create some colors --->
<cfset red = myImage.getColorByName("red") />
<cfset yellow = myImage.getColorByName("yellow") />
<cfset green = myImage.getColorByName("green") />

<!--- set the background color --->
<cfset myImage.setBackgroundColor(red) />

<!--- create a new image --->
<cfset myImage.createImage(60, 60, "rgb") />

<!--- draw a circle --->
<cfset myImage.setFill(green) />
<cfset myImage.setStroke(2, yellow) />
<cfset myImage.drawOval(5, 5, 50, 50) />
<cfset myImage.drawOval(10, 10, 40, 40) />
<cfset myImage.drawOval(15, 15, 30, 30) />

<!--- loop 11 times and output low to high quality --->
<cfloop from="100" to="0" step="-10" index="x">
 <cfset myImage.writeImage(expandPath("example#x#.jpg"), "jpg", x) />
 <cfoutput>
  <span style="float: left; padding: 10px;">
  <b>#x#:</b><br>
  <img src="example#x#.jpg">
  </span>
 </cfoutput>
</cfloop>

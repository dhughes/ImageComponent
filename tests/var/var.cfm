<cfloop from="1" to="5" index="x">
	<cfset joe = "#x#">
</cfloop>
<cfoutput>#joe#</cfoutput><!--- joe = x = 5 --->

I call the function to create a new image
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- Create a new image --->
<cfset red = myImage.getColorByName("red") />
<cfset myImage.setBackgroundColor(red) />
<cfset myImage.createImage(400, 400) />
<cfset myImage.writeImage(expandPath("test.jpg"), "jpg") />

I open the new image to add the text
<!--- open the image to inspect --->
<cfset myImage.readImage(expandPath("test.jpg")) />

<!--- set the font --->
<cfset timesNewRoman = myImage.loadSystemFont("Times New Roman", 40, "boldItalic") />

<!--- create a string to write into the image the value is from joe---> 
<cfset myString = joe />
<!--- myString = joe = x = 5 --->

<!--- draw the text, centered at the top of the image ---> 
<cfset myImage.drawSimpleString(JavaCast("string", myString), 20, 30, timesNewRoman) />

Save and view new image
<!--- output the new image --->
<cfset myImage.writeImage(expandPath("newTest.jpg"), "jpg") />

<!--- the new image --->
<p>
<b>newtest.jpg:</b><br>
<img src="newTest.jpg"><br>
</p>

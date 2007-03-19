<!--- create the object --->
<cfset myImage = CreateObject("Component","Image2.Image") />

<!--- create some colors --->
<cfset randomColor1 = myImage.createColor(randrange(0,255),  randrange(0,255), randrange(0,255)) />
<cfset randomColor2 = myImage.createColor(randrange(0,255),  randrange(0,255), randrange(0,255)) />
<cfset randomColor3 = myImage.createColor(randrange(0,255),  randrange(0,255), randrange(0,255)) />
<cfset randomColor4 = myImage.createColor(randrange(0,255),  randrange(0,255), randrange(0,255)) />

<!--- create three random fonts --->
<cfset fontArray = myImage.getSystemFonts() />
<cfset fontIndex = randRange(1, ArrayLen(fontArray)) />
<cfset randomFont1 = myImage.loadsystemFont(fontArray[fontIndex],  randRange(25, 45), "bold") />
<cfset fontIndex = randRange(1, ArrayLen(fontArray)) />
<cfset randomFont2 = myImage.loadsystemFont(fontArray[fontIndex],  randRange(25, 45), "italic") />
<cfset fontIndex = randRange(1, ArrayLen(fontArray)) />
<cfset randomFont3 = myImage.loadsystemFont(fontArray[fontIndex],  randRange(25, 45), "boldItalic") />

<!--- create a new image --->
<cfset myImage.setBackgroundColor(randomColor1) />

<!--- create an advanced string --->
<cfset myString = "It was a dark and stormy night." />
<cfset advancedString = myImage.createString(myString) />

<!--- set some font and size settings --->
<cfset myImage.setStringFont(advancedString, randomFont1, 0, 8) />
<cfset myImage.setStringFont(advancedString, randomFont2, 9, 17) />
<cfset myImage.setStringFont(advancedString, randomFont3, 18, 30) />

<!--- set some font colors --->
<cfset myImage.setStringForeground(advancedString, randomColor3, 0,  14) />
<cfset myImage.setStringForeground(advancedString, randomColor4, 14,  30) />

<!--- get the string's metrics --->
<cfset metrics = myImage.getStringMetrics(advancedString) >

<!--- create an image the width and height of the text --->
<cfset myImage.createImage(metrics.width, metrics.height) />

<!--- draw the text into the image --->
<cfset myImage.drawString(advancedString, 0, metrics.height -  metrics.descent) />

<!--- output the new image --->
<cfset myImage.writeImage(expandPath("textExample.png"), "png") />

<!--- the new images --->
<p>
<b>Results:</b><br>
<img src="textExample.png"><br>
</p>

<cfset ImageIO = CreateObject("Java", "javax.imageio.ImageIO") />
<cfset fos = CreateObject("Java", "java.io.FileOutputStream").init("c:\test.png") /> 
 
<cfset background = CreateObject("Java", "java.awt.Color") />
<cfset background.init(1000) />
 
<cfset buffer = createObject( "java", "java.awt.image.BufferedImage" ) />
<cfset buffer.init( 200, 200, buffer.TYPE_INT_RGB ) />
 
<cfset g = buffer. () />
<cfset g.setColor(background) />
<cfset g.fillRect(50,50,100,100) />
 
<cfset ImageIO.write(buffer, "png", fos) />
 
<cfset fos.close() />

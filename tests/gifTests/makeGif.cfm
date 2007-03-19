<cfset myImage = CreateObject("Component", "Image2.Image") />

<cfset myImage.readImage(expandPath("transparentImage.png")) />

<cfset BufferedImage = myImage.getBufferedImage() />

<!------->

<cfset FileOutputStream = CreateObject("Java", "java.io.FileOutputStream").init(JavaCast("string", expandPath("mylogo.gif"))) />

<cfset GifEncoder = CreateObject("Java", "Acme.JPM.Encoders.GifEncoder").init(BufferedImage, FileOutputStream) />
<cfset GifEncoder.encode() />

<div style="background-color:#0000CC ">
<img src="mylogo.gif">
</div>
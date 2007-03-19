 
<cfset myImage = CreateObject("component", "Image").init() />

<cfscript>
	//myImage.CreateImage(250, 150);
	myImage.readImage("d:\pictures\christmas 2002\liz and mia.jpg");
	myImage.setBackgroundColor(myImage.getColorByName("yellow") );
	
	myImage.scalepixels(300, 400);
	myImage.setImageSize(350, 450);
	
	myImage.createString("I love Liz and Collin!");
	
	myImage.setStringFont(myImage.loadSystemFont("Arial Black", 25, "Plain"), 7, 10);
	myImage.setStringFont(myImage.loadSystemFont("Arial Black", 25, "Plain"), 15, 21);
	myImage.drawString(20, 150);
	metrics = myImage.getStringMetrics();
	myImage.drawRectangle(20,150, metrics.width, metrics.height);
	
	myImage.setFill(myImage.createTexture("d:\examples\buy-now.gif", 0, 0, 40, 40));
	myImage.createPolygon();
	myImage.addPolygonPoint(20,40);
	myImage.addPolygonPoint(61,302);
	myImage.addPolygonPoint(232,432);
	myImage.addPolygonPoint(123,12);
	myImage.drawPolygon();
	
	
	myImage.writeImage("d:\Inetpub\JavaImage\test1.png", "png");
	
</cfscript>

<img src="test1.png">
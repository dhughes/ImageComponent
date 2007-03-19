<!--- create the object --->
  <cfset newImage = CreateObject("Component","Image2.Image") />
  <!--- open the image to inspect --->
  <cfset newImage.readImage(expandPath("forest1.jpg")) />
  <!--- set to grayscale if selected ---->
  <cfif isDefined("Form.Gray")>
     <cfset newImage.grayscale() />  
  </cfif>
  <!--- flip the image horizontally if selected ---->
  <cfif isDefined("Form.FlipH")>
     <cfset newImage.flipHorizontal() />
  </cfif>
  <!--- flip the image vertically if selected ---->
  <cfif isDefined("Form.FlipV")>
     <cfset newImage.flipVertical() />
  </cfif>
  <!--- get the width --->
  <cfset width = newImage.getWidth() />
  <!--- get the height --->
  <cfset height = newImage.getHeight() />
  <!--- Scale the image down if it's either wider or higher than 400 pixels --->
  <cfif width GT 400 OR height GT 400>
     <!--- resize the image to fit a specific width and height --->
     <cfset newImage.scaleToFit(400) />
     <!--- Get new width and height --->
     <cfset width = newImage.getWidth() />
     <cfset height = newImage.getHeight() />
  </cfif>
  <!--- write out the new image --->
  <cfset newImage.writeImage(expandPath("forest_400.jpg"), "jpg") />
  <!--- resize the image to thumbnail --->
  <cfset newImage.scaleToFit(100) />
  <!--- write out the new image --->
  <cfset newImage.writeImage(expandPath("forest_100.jpg"), "jpg") />

<img src="forest_400.jpg"><br><Br>
<img src="forest_100.jpg"><br><Br>
<cfcomponent>
<!--- Obtain input data from Flash to create Try on image to save into the server --->
            <CFFUNCTION NAME="SaveImage" HINT="Saving of a Try-on Image" ACCESS="remote" RETURNTYPE="string">
                        <cfargument name="MembersID" type="string" required="true">
                        <cfargument name="UploadedPic" type="string" required="true">
                        <cfargument name="SelectedEyewear" type="string" required="true">
                        <cfargument name="UploadedPic_X" type="numeric" required="true">
                        <cfargument name="UploadedPic_Y" type="numeric" required="true">
                        <cfargument name="UploadedPic_Size_X" type="numeric" required="true">
                        <cfargument name="UploadedPic_Size_Y" type="numeric" required="true">             
                        <cfargument name="Eyewear_X" type="numeric" required="true">
                        <cfargument name="Eyewear_Y" type="numeric" required="true">
                        <cfargument name="Eyewear_Size_X" type="numeric" required="true">
                        <cfargument name="Eyewear_Size_Y" type="numeric" required="true">
                        <cfargument name="Eyewear_Rotate" type="numeric" required="true">
                        <cfargument name="Eyewear_GotResize" type="numeric" required="true">
                        <cfargument name="Eyewear_OriX" type="numeric" required="true">
                        <cfargument name="Eyewear_OriY" type="numeric" required="true">
                        <cfargument name="Pic_OriX" type="numeric" required="true">
                        <cfargument name="Pic_OriY" type="numeric" required="true">
                        <cfargument name="Pic_SizeOriX" type="numeric" required="true">
                        <cfargument name="Pic_SizeOriY" type="numeric" required="true">             
                                    
<!--- ----------------------------------------------------------------------------------- --->
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />
<cfset myImage.setKey("5815C-Q7X8K-F99X1-A0Q9Y-UDW0V") />
 
<!--- open the eyewear image --->
<cfset myImage.readImage(#ARGUMENTS.SelectedEyewear#) />
 
            <cfset transparent = myImage.createColor(0,0,0,0) />
            <cfset myImage.setBackgroundColor(transparent) /> 
 
<cfif #ARGUMENTS.Eyewear_Rotate# eq 0>
            <!--- If there's no rotating for the input Pic (Eyewear), set the size of it --->
            <cfset myImage.scalePixels(#ARGUMENTS.Eyewear_Size_X#, #ARGUMENTS.Eyewear_Size_Y#) />
<cfelse>
            <!--- If there's rotating for the input Pic (Eyewear), set the size of it after rotating --->
            <cfset myImage.rotate(#ARGUMENTS.Eyewear_Rotate#, true) />
            <cfset myImage.scalePixels(#ARGUMENTS.Eyewear_Size_X#, #ARGUMENTS.Eyewear_Size_Y#) />
</cfif>
            <!--- Save it to as a temp image file, but as png so as to keep the transparent background --->
            <cfset TempSavedFile = "D:/web/eyesimage/html/TryonSave/#ARGUMENTS.MembersID#-EyewearTemp.png">
            <cfset myImage.writeImage(#TempSavedFile#, "png") />
 
 
<!--- open a the uploaded face image of the user --->
<cfset myImage.readImage(#ARGUMENTS.UploadedPic#) />
<cfset myImage.scalePixels(#ARGUMENTS.UploadedPic_Size_X#, #ARGUMENTS.UploadedPic_Size_Y#) />
 
<!--- Get the offset for the location of the Uploaded Pic --->
<cfset PicoffsetX = #ARGUMENTS.Pic_OriX# - #ARGUMENTS.UploadedPic_X#>
<cfset PicoffsetY = #ARGUMENTS.Pic_OriY# - #ARGUMENTS.UploadedPic_Y#>
 
<!--- Get the offset for the size of the Uploaded Pic --->
<!--- Currently not in use 
<cfset PicoffsetSizeX = #ARGUMENTS.Pic_SizeOriX# - #ARGUMENTS.UploadedPic_Size_X#>
<cfset PicoffsetSizeY = #ARGUMENTS.Pic_SizeOriY# - #ARGUMENTS.UploadedPic_Size_Y#>
--->
 
<!--- Get the offset for the size of the input Pic (Eyewear) --->
<cfset offsetX = #ARGUMENTS.Eyewear_OriX# - #ARGUMENTS.Eyewear_Size_X#>
<cfset offsetY = #ARGUMENTS.Eyewear_OriY# - #ARGUMENTS.Eyewear_Size_Y#>
 
<!--- draw an image into the image --->
<cfif #ARGUMENTS.Eyewear_Rotate# eq 0>
            <!--- If there's no rotating for the input Pic (Eyewear) --->
            <cfif offsetY neq 0>
            <!--- If there's resizing for the input pic (Eyewear) --->
                        <cfif #ARGUMENTS.Pic_SizeOriX# gt #ARGUMENTS.UploadedPic_Size_X#>
                                    <!--- If the uploaded pic's size is smaller then its original size --->
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-647+(#offsetX#/2)+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-76+(#offsetY#/2)+(#PicoffsetY#)) />
                        <cfelse>
                                    <!--- If the uploaded pic's size is bigger then its original size --->
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-647+(#offsetX#/2)+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-76+(#offsetY#/2)+(#PicoffsetY#)) />
                        </cfif>
            <cfelse>
            <!--- If there's no resizing for the input pic (Eyewear), means the pic is at it's original size --->
                        <cfif #ARGUMENTS.Pic_SizeOriX# lt #ARGUMENTS.UploadedPic_Size_X#>
                                    <!--- If the uploaded pic's size is smaller then its original size --->
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-647+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-76+(#PicoffsetY#)) />
                        <cfelse>
                                    <!--- If the uploaded pic's size is bigger then its original size --->
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-647+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-76+(#PicoffsetY#)) />
                        </cfif>
            </cfif>
<cfelse>
            <!--- If there's rotating for the input Pic (Eyewear) --->
            <cfif offsetY neq 0>
                        <cfif #ARGUMENTS.Pic_SizeOriX# gt #ARGUMENTS.UploadedPic_Size_X#>
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-648+(#offsetX#/2)+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-80+(#offsetY#/2)+(#PicoffsetY#)) />
                        <cfelse>
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-648+(#offsetX#/2)+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-80+(#offsetY#/2)+(#PicoffsetY#)) />
                        </cfif>
            <cfelse>
                        <cfif #ARGUMENTS.Pic_SizeOriX# lt #ARGUMENTS.UploadedPic_Size_X#>
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-648+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-80)+(#PicoffsetY#) />
                        <cfelse>
                                    <cfset myImage.drawImage(#TempSavedFile#, #ARGUMENTS.Eyewear_X#-648+(#PicoffsetX#), #ARGUMENTS.Eyewear_Y#-80)+(#PicoffsetY#) />
                        </cfif>   
            </cfif>   
</cfif>
 
<!--- output the new image --->
<cfoutput>
            <cfset SavedFile = "D:/web/eyesimage/html/TryonSave/#ARGUMENTS.MembersID#.jpg">
            <cfset myImage.writeImage(#SavedFile#, "jpg") />
            <cfset FinalSavedFile = "http://202.56.144.40/eyesimage/html/TryonSave/#ARGUMENTS.MembersID#.jpg">
</cfoutput>
 
                        <!--- Return the saved combined file location back to Flash application. --->
                        <cfreturn FinalSavedFile>
            </cffunction>
            
</cfcomponent>

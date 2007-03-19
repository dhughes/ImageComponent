<!--- 
image hosting upload
img_upload.cfm

 --->

<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">
<cfset epoch="">
<!--- Load this module for creating unique IDs --->
<CFMODULE TEMPLATE="../functions/epoch.cfm">
 
<cfif isdefined("session.RepID")>
	<cfset session.RepID = session.RepID>
<cfelseif not isdefined("session.RepID")>
	<cflocation url="../index.cfm" addtoken="No">
</cfif>

<cfset directory = "#replace(ExpandPath(".\"),"\my_photos\","\my_photos\thumbs\","ALL")#">
<cfset directory2 = "#replace(ExpandPath(".\"),"\my_photos\","\my_photos\images\","ALL")#">

<cfparam name="error_message" default="">
<cfparam name="error_images" default="">
<!--- <cfif isDefined('quality1')><cfset quality = quality1>
<cfelseif  isDefined('quality2')><cfset quality = quality2>
<cfelseif  isDefined('quality3')><cfset quality = quality3>
<cfelseif  isDefined('quality4')><cfset quality = quality4>
</cfif>
<cfparam name="quality" default="1"> --->
<cftry>
	<cfif isDefined('thumb') and thumb neq "">
	
		<cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
			<cffile action="upload"
				filefield="form.thumb"
				destination="#directory#"
				nameconflict="makeunique" 
				accept="image/jpg,image/jpeg,image/pjpg,image/gif">
		<cfelse>
			<cffile action="upload"
				filefield="form.thumb"
				destination="#directory#"
				nameconflict="makeunique" 
				accept='image/*'>
		</cfif>
		
		<!--- check to see if the uploaded file is too big.  Delete if true --->
		<cfset pic_weight = 1000000>
		<!--- <cfset pic_file2big = 0> --->
		
		<cfif File.FILESIZE GT pic_weight>
			<cffile action="delete"	file="#directory##File.ServerFile#">
			<!---  <cfset #pic_size# = #pic_fileRead.size# / 1000> 
			<cfset #pic_file2big# = 1>--->
			<cfset error_images = "#File.ServerFile#,"> 
			<cfset #error_message# = "<font color=ff0000>The image [#error_images#] size is bigger than the allowed size.  please resubmit an image less than 1000KB.</font>">
			<!--- <cfelse>
			<cfset img_hosting = #URLEncodedFormat(File.ServerFile)#>
			<cfset serverfile = #File.ServerFile#> --->
		</cfif>
		
		<!--- grab the uploaded file name
		<cfset uploadedFileName = File.ServerFile /> --->
		
		<!--- rename files so that spaces are removed 
		<cfif Find(" ", uploadedFileName)>
			<cfset uploadedFileName = Replace(File.ServerFile, " ", "_", "all") />
			<cffile action="rename"
				source="#directory##File.ServerFile#"
				destination="#directory##uploadedFileName#" />				
		</cfif>--->
		
		<cfif error_message is "" and fileexists("#directory##File.ServerFile#")>
		
			<cfquery name="get_images" datasource="#DATASOURCE#" dbtype="ODBC">
				SELECT image1, image2, image3, image4 
				FROM order_details
				WHERE OrderdetailID = #selected_orderdetailID#
			</cfquery>
	
			<cfif position eq "a">
				<cfset del_image = "#get_images.image1#">
			<cfelseif position eq "b">
				<cfset del_image = "#get_images.image2#">
			<cfelseif position eq "c">
				<cfset del_image = "#get_images.image3#">
			<cfelseif position eq "d">
				<cfset del_image = "#get_images.image4#">
			</cfif>
			  
			<cfif fileExists('#directory##del_image#')>
				<cffile action="DELETE" file="#directory##del_image#"> 
			</cfif>
			<cfif fileExists('#directory2##del_image#')>
				<cffile action="DELETE" file="#directory2##del_image#"> 
			</cfif>
			
			<!--- <cfset thumbName="#File.ServerFile#"> --->
	 
	 		<!--- create the thumbnail image --->
			
			<!--- first, create an instance of the Image Component --->
			<cfset myImage = CreateObject("Component", "Image").setKey("7HFWP-M00KR-8VX9R-0EBLW-VF01C") />
	 		
			<!--- read the uploaded image --->
			<cfset myImage.readImage(directory & File.ServerFile) />
			<!--- check to see if the image is larger than 150x150 --->
			<cfif myImage.getWidth() GT 150 OR myImage.getHeight() GT 150>
				<!--- resize the image to fit within 150x150 --->
				<cfset myImage.scaleToFit(144) />
			</cfif>
			<!--- set the image background color and create a border --->
			<cfset gray = myImage.CreateColor(223,223,223) />
			<cfset myImage.setBackgroundColor(gray) />
			<cfset myImage.setImageSize(myImage.getWidth() + 6, myImage.getHeight() + 6, "middleCenter") />
			<!--- sharpen the image (removed because it adds a border arround the image
			<cfset myImage.sharpen(2, 2) /> --->
			
			<!--- output the thumbnail image --->
			<cfset myImage.writeImage("#directory##selected_orderdetailID##position##epoch#.jpg", "jpg") />
			
			<!--- create the fullsize image --->
			
			<!--- read the uploaded image --->
			<cfset myImage.readImage(directory & File.ServerFile) />
			<!--- set the background color --->
			<cfset myImage.setBackgroundColor(gray) />
			<!--- check to see if the image is larger than 530x530 --->
			<cfif myImage.getWidth() GT 530 OR myImage.getHeight() GT 530>
				<!--- resize the image to fit within 530x530 --->
				<cfset myImage.scaleToFit(524) />
			</cfif>
			<!--- set the image background color and create a border --->
			<cfset white = myImage.CreateColor(0,0,0) />
			<cfset myImage.setImageSize(myImage.getWidth() + 6, myImage.getHeight() + 6, "middleCenter") />
			<!--- output the thumbnail image --->
			<cfset myImage.writeImage("#directory2##selected_orderdetailID##position##epoch#.jpg", "jpg") />
			
			<!--- 
			<cfabort>
			
	
			<!--- <CF_MagickTag action="convert"
				timeout="30"
				inputtype="file"
				inputfile="#directory##File.ServerFile#"
				outputType="file"
				outputFile="#directory##selected_orderdetailID##position##epoch#.jpg">
					<CF_MagickAction action="Geometry"	width="150"	height="150" percent="no"		scaleIf="larger">		
					<CF_MagickAction action="Border" width="3" height="3">
					<CF_MagickAction action="bordercolor" color = "##000000"> 
					<CF_MagickAction action="sharpen" radius="3" sigma="5"> 
					<!---  <CF_MagickAction action="quality" value = "#quality#">  --->
				</CF_MagickTag> --->
	
			<cfif Right(thumbName, 4) IS ".jpg"> 
				<!--- Rename thumb 
					<cfif FileExists("#directory##thumbName#")>
					  <cffile action="delete" file="#directory##thumbName#">
				</cfif>--->
			</cfif>
			
			<!--- <cfoutput>#directory##thumbName#</cfoutput>
			<cfabort> --->
	  
	  
			<cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
				<cffile action="upload"
					filefield="form.thumb"
					DESTINATION="#directory2#"
					nameconflict="overwrite" 
					accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
			<cfelse>
				<cffile action="upload"
					filefield="form.thumb"
					DESTINATION="#directory2#"
					nameconflict="overwrite" 
					accept='image/*'>
			</cfif>
	   
			<cfset imageName="#File.ServerFile#">
	   
			<CF_MagickTag action="convert"
				timeout="30"
				inputtype="file"
				inputfile="#directory##File.ServerFile#"
				outputType="file"
				outputFile="#directory2##selected_orderdetailID##position##epoch#.jpg">
					<CF_MagickAction action="Geometry" width="530" height="530" percent="no" scaleIf="larger">	
					<CF_MagickAction action="Border" width="3" height="3">
					<CF_MagickAction action="bordercolor" color = "##000000"> 
					<!--- <CF_MagickAction action="sharpen" radius="5" sigma="5">  --->
					<!---  <CF_MagickAction action="quality" value = "#quality#">  ---> 
			</CF_MagickTag> 
	  		---> 
	  
			<cfquery name="stor_img" datasource="#DATASOURCE#" dbtype="ODBC">
				UPDATE Order_Details
				<cfif position eq 'a'> 
					SET image1 = '#selected_orderdetailID##position##epoch#.jpg'
				<cfelseif position eq 'b'>
					SET image2='#selected_orderdetailID##position##epoch#.jpg'
				<cfelseif position eq 'c'>
					SET image3='#selected_orderdetailID##position##epoch#.jpg'
				<cfelseif position eq 'd'>
					SET image4='#selected_orderdetailID##position##epoch#.jpg'
				</cfif> 
				WHERE OrderDetailID = #selected_orderdetailID#
			</cfquery>
	
			<cfif fileExists('#directory##File.ServerFile#')>
				<cffile action="DELETE" file="#directory##File.ServerFile#"> 
			</cfif>
			<cfif fileExists('#directory2##File.ServerFile#')>
				<cffile action="DELETE" file="#directory2##File.ServerFile#"> 
			</cfif>
		</cfif>   
	</cfif>  
   
	<!--- </cfif>
	</cfif> --->
	<cfcatch type="Any">
		<cfoutput>#cfcatch.message#<hr></cfoutput><!-- Do Nothing -->
	</cfcatch> 
</cftry>

<!--- run query get expired week --->
<cfquery name="expired_week" datasource=#DATASOURCE# username=#db_username# password=#db_password#>
	SELECT pair FROM dbo.defaults WHERE name = 'expired_wk'
</cfquery>

<!--- get order id and client name --->
<cfif isdefined("selected_orderdetailID") and selected_orderdetailID neq "">
	<!--- Run query to find all clients --->
	<CFQUERY name="Get_selected_orderID" dataSource="#dataSource#">
		SELECT order_details.*,C.firstname, C.lastname, C.phone, C.address1, C.address2, C.city, C.state, C.zip, C.Company, orders.orderdate
		FROM order_details, clients C, orders
		WHERE order_details.RepID = #session.RepID#
		AND order_details.clientID = C.client_id
		AND order_details.orderid = orders.orderid
		AND order_details.orderdetailID = #selected_orderdetailID#
	</CFQUERY>
	
	<cfif Get_selected_orderID.recordcount eq 1>
	
		<cfset client_id = Get_selected_orderID.clientid>
		<cfset orderID = Get_selected_orderID.orderID>
		<cfset first_name = Get_selected_orderID.firstname>
		<cfset last_name = Get_selected_orderID.lastname>
		<cfset auctionid = Get_selected_orderID.auctionid>
		<cfset auctionsite = Get_selected_orderID.auctionsite>
		<cfset item = Get_selected_orderID.item>
		<cfset quantity = Get_selected_orderID.quantity>
		<cfset html_text = Get_selected_orderID.html_text>
		<cfset company = Get_selected_orderID.company>
	</cfif>		
<cfelse>
	<cfif error_message eq "" and not isdefined("upload")>
	
	  <!--- <cfset client_id = ""> --->
	  <cfset first_name = "">
	  <cfset last_name = "">
	  <cfset orderID = "">
	  <cfset auctionid = "">
	  <cfset auctionsite = "">
	  <cfset item = "">
	  <cfset quantity = "">
	  <cfset html_text = "">
	  
	</cfif>
</cfif>

<cfset exp_date = dateadd("ww", -#expired_week.pair#, timenow)>

<!--- Run query to find all orders --->
<CFQUERY name="Get_total_orderID" dataSource="#dataSource#">
	SELECT order_details.*,C.firstname, C.lastname, orders.orderdate
	FROM clients C, order_details, orders
	WHERE order_details.RepID = #session.RepID#
		AND order_details.clientID = C.client_id
		AND order_details.clientID = #client_id#
		AND order_details.orderid = orders.orderid
		<!--- AND orders.orderdate >= #exp_date# --->
		AND order_details.exclude = 0
		AND order_details.pricesold = 0
		AND order_details.unsalable = 0
	 ORDER BY orders.OrderID, order_details.OrderDetailID asc
</CFQUERY>

<cfoutput query="Get_total_orderID">
	<cfif isdefined("URL.selected_orderdetailID") and #URL.selected_orderdetailID# eq orderID>
		<cfset current_row = #Get_total_orderID.currentrow#>
	</cfif>
</cfoutput>

<cfif isdefined("url.client_id")>
	<cfquery name="get_client" datasource="#dataSource#">
		SELECT firstname, lastname, Company
		FROM dbo.clients
		WHERE client_id = #URL.client_id# 
	</cfquery>
	<cfif get_client.recordcount eq 1>
		<cfset first_name = get_client.firstname>
		<cfset last_name = get_client.lastname>
		<cfset company = get_client.company>
	</cfif>
</cfif>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<title>Estates On Line image hosting</title>
<script language="JavaScript">
  function jumpPage(newLoc){
  			newPage = newLoc.options[newLoc.selectedIndex].value
			if (newPage != ""){
				window.location.href = newPage
				}
		}

		
	function ShowBigPic(ThisPic) {
    if (document.images) {
		//document.write("<blink><strong>"+ThisPic+"</strong></blink>");
        ThisFile = "/my_photos/images/" + ThisPic;
        document.nowshowing.src = ThisFile
		
    }
}

</script>
<style>
<!--
.hide { position:absolute; visibility:hidden; }
.show { position:absolute; visibility:visible; }
-->
</style>

<SCRIPT LANGUAGE="JavaScript">

//Progress Bar script- by Todd King (tking@igpp.ucla.edu)
//Modified by JavaScript Kit for NS6, ability to specify duration
//Visit JavaScript Kit (http://javascriptkit.com) for script

var duration=20 // Specify duration of progress bar in seconds
var _progressWidth = 50;	// Display width of progress bar

var _progressBar = new String("");
var _progressEnd = 10;
var _progressAt = 0;


// Create and display the progress dialog.
// end: The number of steps to completion
function ProgressCreate(end) {
	// Initialize state variables
	_progressEnd = end;
	_progressAt = 0;

	// Move layer to center of window to show
	if (document.all) {	// Internet Explorer
		progress.className = 'show';
		progress.style.left = (document.body.clientWidth/2) - (progress.offsetWidth/2);
		progress.style.top = document.body.scrollTop+(document.body.clientHeight/2) - (progress.offsetHeight/2);
	} else if (document.layers) {	// Netscape
		document.progress.visibility = true;
		document.progress.left = (window.innerWidth/2) - 100;
		document.progress.top = pageYOffset+(window.innerHeight/2) - 40;
	} else if (document.getElementById) {	// Netscape 6+
		document.getElementById("progress").className = 'show';
		document.getElementById("progress").style.left = (window.innerWidth/2)- 100;
		document.getElementById("progress").style.top = pageYOffset+(window.innerHeight/2) - 40;
	}

	ProgressUpdate();	// Initialize bar
}

// Hide the progress layer
function ProgressDestroy() {
	// Move off screen to hide
	if (document.all) {	// Internet Explorer
		progress.className = 'hide';
	} else if (document.layers) {	// Netscape
		document.progress.visibility = false;
	} else if (document.getElementById) {	// Netscape 6+
		document.getElementById("progress").className = 'hide';
	}
}

// Increment the progress dialog one step
function ProgressStepIt() {
	_progressAt++;
	if(_progressAt > _progressEnd) _progressAt = _progressAt % _progressEnd;
	ProgressUpdate();
}

// Update the progress dialog with the current state
function ProgressUpdate() {
	var n = (_progressWidth / _progressEnd) * _progressAt;
	if (document.all) {	// Internet Explorer
		var bar = dialog.bar;
 	} else if (document.layers) {	// Netscape
		var bar = document.layers["progress"].document.forms["dialog"].bar;
		n = n * 0.55;	// characters are larger
	} else if (document.getElementById){
                var bar=document.dialog.bar
        }
	var temp = _progressBar.substring(0, n);
	bar.value = temp;
}

// Demonstrate a use of the progress dialog.
function Demo() {
	ProgressCreate(10);
	window.setTimeout("Click()", 100);
}

function Click() {
	if(_progressAt >= _progressEnd) {
		ProgressDestroy();
		return;
	}
	ProgressStepIt();
	window.setTimeout("Click()", (duration-1)*1000/10);
}

function CallJS(jsStr) { //v2.0
  return eval(jsStr)
}

</script>

<SCRIPT LANGUAGE="JavaScript">

// Create layer for progress dialog
document.write("<span id=\"progress\" class=\"hide\">");
	document.write("<FORM name=dialog>");
	document.write("<TABLE border=2  bgcolor=\"#FFFFCC\">");
	document.write("<TR><TD ALIGN=\"center\">");
	document.write("Progress<BR>");
	document.write("<input type=text name=\"bar\" size=\"" + _progressWidth/2 + "\"");
	if(document.all||document.getElementById) 	// Microsoft, NS6
		document.write(" bar.style=\"color:navy;\">");
	else	// Netscape
		document.write(">");
	document.write("</TD></TR>");
	document.write("</TABLE>");
	document.write("</FORM>");
document.write("</span>");
ProgressDestroy();	// Hides

</script>
 <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	 <!---  <meta HTTP-EQUIV="Expires" CONTENT="Fri, 1 Jun 2001 00:01:00 GMT">  --->

 <META HTTP-EQUIV="Expires" CONTENT="-1">  
 <LINK REL=stylesheet HREF="../eol.css" TYPE="text/css">
</head>

<body onLoad="if ('Navigator' == navigator.appName) document.forms[0].reset();">
<!--- 
<cfinclude template="../includes/bodytag.html">
 --->

<cfoutput>
<center>

<table width="700">
	<tr>
		<td colspan="2" align="left">
			<center><FONT SIZE=2>
				<cfinclude template="../headers-footers/memheader.cfm">
			</FONT></center>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<font size=4><b>My Photos</b></font>
		</td>
	</tr>

	<tr>
		<td colspan="2">
			<hr size=2 noshade>
		</td>
	</tr>
	<tr>
		
		<td colspan="2">
			<font face="Helvetica" size=2>Note: Limit 4 images per 
			item. Valid for any active item in your database.</font> <font color="blue"><b>Note: </b>images must be no larger than 1 Meg </font>.
			</font> 
			<cfif #error_message# is not "">
				<br>
				<font face="Helvetica" size=2 color=ff0000><b>ERROR:</b> #error_message#<br></font>
			</cfif>
	  </td>
	</tr>
	
	<tr>
		<td colspan="2">
			<table border=0 cellspacing=0 cellpadding=2 width=640>
			
				<form action="img_upload.cfm" method="post" name="page_jump" ENCTYPE="multipart/form-data">
					<cfif isdefined("url.selected_orderdetailID")>
						<input name="orderID" type="hidden" value="#url.selected_orderdetailID#">
					</cfif>
					<input name="client_id" type="hidden" value="#client_id#">
					<tr>
						<TD colspan="2" align="center"><font size=3 color="0000ff"><b>Select item:</b></font>
							<select name="search_orderID" onChange="jumpPage(this.form.search_orderID)">
								<option value="">Select one
								<cfloop query="Get_total_orderID">
									<cfset short_txt = left(item, 50)>
									<option value="img_upload.cfm?selected_orderdetailID=#orderdetailID#" <cfif isdefined("selected_orderdetailID") and #selected_orderdetailID# eq #orderdetailid#>selected</cfif>>#short_txt#<cfif len(short_txt) gt 50>...</cfif>&nbsp;<cfif auctionID neq "">(#auctionID#)</cfif><!---<cfif datediff("ww", orderdate, timenow) gte 8> **</cfif>---><!--- &nbsp;#numberformat(listfeedue, '9$99999999.99')# ---></option>
								</cfloop>
							</select>
						</TD>
					</tr>
				</form>
			</table>
		</td>
	</tr>
	<!--- get new order --->
	<tr bgcolor="##99CCFF"> 
		<td colspan="2" > 
			<table border=0 cellspacing=0 cellpadding=2 width=737>
				<!--DWLayoutTable-->
				<tr> 
					<td width=4 height="4"></td>
					<td width=728></td>
				</tr>
				<tr>
					<td height="77"></td>
					<td valign="top"> 
						<table border=0 cellspacing=0 cellpadding=2 width=728>
							<!--DWLayoutTable-->
							<tr> 
								<td width="135" height="23">Client Name: </td>
								<td width="199" valign="top"><strong>#first_name#</strong> &nbsp;<strong>#last_name#</strong></td>
								<cfif isdefined("company") and #company# neq "">
									<td width="380" valign="top">Company: <strong>#company#</strong></td>
								</cfif>
							</tr>
							<tr> 
								<td>Item:</td>
								<td colspan="2">#item#</td>
							</tr>
							<tr>
								<td height="4"></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<cfif isdefined("selected_orderdetailID")>
	<!---<cfif datediff("ww", Get_selected_orderID.orderdate, timenow) lt 8>--->

	<table border=0 cellpadding=2 cellspacing=0 width=680>
		<tr>
			<td align=center valign=top width=530>
				<cfif fileExists('#directory2##Get_selected_orderID.image1#')>
					<img alt="[Photo of #selected_orderdetailID#]" src="/my_photos/images/#Get_selected_orderID.image1#" name="nowshowing" hspace="0" vspace="0" border="0">
					
				<cfelse>
					No Image
				</cfif>
	
				<img alt="" src="/my_photos/images/530space.gif" width="530" height="1" hspace="0" vspace="0" border="0">
			</td>
			<td width=152 valign=top align=right>
				<!--- Put thumbs into two rows and two columns --->
				<table cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td>

							<!--- <table border=0 width=152 cellpadding=0 cellspacing=0>
							
							<tr><td valign=top> <cfif fileExists('#directory##Get_selected_orderID.image1#')>	
								<a href="javascript:ShowBigPic('#Get_selected_orderID.image1#')"><img alt="[Image 1]" border=0 name="thumba"
								src="/my_photos/thumbs/#Get_selected_orderID.image1#"></a><cfelse>&nbsp; </cfif> </td></tr>                                                              </table> --->	
						</td>
						<td>
						 <!--- <table border=0 cellpadding=0 cellspacing=0>
							
							<tr><td><cfif fileExists('#directory##Get_selected_orderID.image2#')>	
								<a href="javascript:ShowBigPic('#Get_selected_orderID.image2#')"><img alt="[Image 2]" border=0 name="thumbb" src="/my_photos/thumbs/#Get_selected_orderID.image2#"></a><cfelse>&nbsp;</cfif></td></tr>
							</table> ---> 
						</td>
					</tr>
					<tr>
						<td>
							<!--- <table border=0 cellpadding=0 cellspacing=0>
							
							<tr><td><cfif fileExists('#directory##Get_selected_orderID.image3#')>	
								<a href="javascript:ShowBigPic('#Get_selected_orderID.image3#')"><img alt="[Image 3]" border=0 name="thumbc"
								src="/my_photos/thumbs/#Get_selected_orderID.image3#"></a><cfelse>&nbsp;</cfif></td></tr>
						
							</table> --->
						</td>
						<td>
							<!--- <table border=0 cellpadding=0 cellspacing=0>
							
							<tr><td><cfif fileExists('#directory##Get_selected_orderID.image4#')>	
								<a href="javascript:ShowBigPic('#Get_selected_orderID.image4#')"><img alt="[Image 4]" border=0 name="thumb"
								src="/my_photos/thumbs/#Get_selected_orderID.image4#"></a><cfelse>&nbsp;</cfif></td></tr>
							</table> --->
						</td>
					</tr>
				</table>	

				<!--- End putting thumbs into rows and columns --->

			</td>
		</tr>
		<tr>
			<td colspan=2>
				
				<table border=0 cellpadding=0 cellspacing=0>
					<tr>
						<cfloop from="1" to="4" index="imageNum">
							<cfswitch expression="#imageNum#">
								<cfcase value="1">
									<cfset image = Get_selected_orderID.image1 />
									<cfset imageLetter = "a" />
								</cfcase>
								<cfcase value="2">
									<cfset image = Get_selected_orderID.image2 />
									<cfset imageLetter = "b" />
								</cfcase>
								<cfcase value="3">
									<cfset image = Get_selected_orderID.image3 />
									<cfset imageLetter = "c" />
								</cfcase>
								<cfcase value="4">
									<cfset image = Get_selected_orderID.image4 />
									<cfset imageLetter = "d" />
								</cfcase>
							</cfswitch>
						
							<td valign=top align=center>
								<table border=0 width=152 cellpadding=0 cellspacing=0>
									<tr><td valign=top>
										<cfif fileExists(directory & image)>	
											<a href="javascript:ShowBigPic('#image#')"><img alt="[Image #imageNum#]" border=0 name="thumba" src="/my_photos/thumbs/#image#"></a>
										<cfelse>
											&nbsp;
										</cfif>
									</td></tr>
								</table>
	
								<form action="img_upload.cfm?selected_orderdetailID=#url.selected_orderdetailID#" method="post" enctype="multipart/form-data" name="image_#imageLetter#" target="_top">
									<input type="file" name="thumb" size="15" accept="image/jpeg"><br>
									<!---Quality:<input type='text' name='quality1' size=3 value='<cfif isDefined('quality1')>#quality1#</cfif>'> --->
									<input type="submit" name="Submit" value="Load Image #imageNum#" onClick="CallJS('Demo()')">
									<!--- <input type='submit' name='Submit' value='Load Image 1' > --->
									<cfif isDefined('position') and position eq imageLetter and #image# neq "">
										<br><font color="blue" size=2><b>Image Loaded Successfully</b></font>
									<cfelseif isDefined('position') and position eq imageLetter and #Get_selected_orderID.image1# eq "">
										<br><font color="red" size=2>Image did not load</font>
									</cfif>
									<input type="hidden" name="selected_orderdetailID" value="#selected_orderdetailID#">
									<input type="hidden" name="position" value="#imageLetter#">
								</form>
							</td>
						</cfloop>
					</tr>
				</table>
	<font size=3>
<a class="uarial11pxboldorg" href="auc_builder.cfm?selected_orderdetailID=#selected_orderdetailID#&client_id=#client_id#"><b>Click here to combine your images with a compelling ad</b></a></font>
			</td>
		</tr>
	</table> 

		
	<!---</cfif>--->
</cfif>
  <br>
  <br><br>
	<cfinclude template="../headers-footers/memfooter.cfm"><br>
</center>

</cfoutput>
</body>
</html>

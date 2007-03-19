<!------------------------------------------------------------------------------
Source Code Copyright © 2004 Alagad, Inc. www.alagad.com

  Application: Kerning Extension to Alagad Image Component 
  Supported CF Version: MX 6.1 or later
  File Name: NeuImage.cfc
  CFC Component Name: Image
  Created By: Doug Hughes (alagad@alagad.com)
  Created Date: 04/26/2005
  Description: I am a CFC which extends the Alagad Image Component to add support for kerning.

Version History:
  
  mm/dd/yyyy	Author		Version		Comments
  04/21/2005	D.Hughes	1.0			Created per contract with Neulogic.  This was a paid enhancement and was Not Easy!!
  05/01/2005	D.Hughes	1.1			Worked to fine tune kerning.
  							
------------------------------------------------------------------------------->
<cfcomponent displayname="NeuImage"
	hint="I am a CFC which extends the Alagad Image Component to add support for kerning."
	extends="Image"
	output="no">
	
	<!--- drawSimpleString --->
	<cffunction name="drawSimpleString" access="public" output="false" returntype="void" hint="I am a simple method to draw a string on the image.">
		<cfargument name="string" hint="I am the string to write onto the image." required="yes" type="string" />
		<cfargument name="x" hint="I am the x coordinate of the top left corner of the rectangle." required="yes" type="numeric" />
		<cfargument name="y" hint="I am the y coordinate of the top left corner of the rectangle." required="yes" type="numeric" />
		<cfargument name="Font" hint="I am the font to use." required="no" type="any" default="" />
		<cfargument name="kerning" hint="I am the amount of kerning to apply." required="no" type="numeric" default="0" />
		<cfset var Image = getImage() />
		<cfset var Graphics = Image.getGraphics() />
		<cfset var GlyphVector = 0 />
		<cfset var Transform = CreateObject("Java", "java.awt.geom.AffineTransform").init() />
		<cfset var i = 0 />
		
		<cftry>
			<cfif (IsObject(arguments.Font) AND arguments.Font.getClass().getName() IS NOT "java.awt.Font") OR (NOT IsObject(arguments.Font) AND Len(arguments.Font))>
				<cfthrow message="Invalid Font attribute.  The Font attibute must be a Font object.  These can be loaded with loadSystemFont() or loadTTFFile()." />
			</cfif>
			<cfcatch>
				<cfthrow message="Invalid Font attribute.  The Font attibute must be a Font object.  These can be loaded with loadSystemFont() or loadTTFFile()." />
			</cfcatch>
		</cftry>
				
		<cfif IsObject(arguments.Font)>
			<cfset Graphics.setFont(Font) />			
		</cfif>
		
		<!--- apply any other graphic settings --->
		<cfset applyGrapicsSettings(Graphics) />
		
		<!--- in the case that we get a fill , we want to first draw a filled object --->
		<cfif IsObject(getFill())>
			<cfset Graphics.setPaint(getFill()) />
		</cfif>
		
		<cfset GlyphVector = Font.createGlyphVector(Graphics.getFontRenderContext(), JavaCast("string", arguments.string)) />
		<cfif arguments.kerning IS NOT 0>
			<cfloop from="1" to="#Len(arguments.string) - 1#" index="i">
				<cfset Transform.setToTranslation( JavaCast("double", (kerning/100) * i), JavaCast("double", 0) ) />
			
				<!--- get the previous character's glyph's metrics and position and... do nothing with it. (I don't know why, but this line needs to be here)--->
				<cfset GlyphVector.getGlyphPosition(JavaCast("int",  1)) />
				
				<!--- set the transformation on this character --->
				<cfset GlyphVector.setGlyphTransform(JavaCast("int", i), Transform) /> 
			</cfloop>
		</cfif>
		
		<cfset Graphics.drawGlyphVector(GlyphVector, javaCast("int", arguments.x), javaCast("int", arguments.y)) />	
	</cffunction>
	
	<!--- getSimpleStringMetrics --->
	<cffunction name="getSimpleStringMetrics" access="public" output="false" returntype="struct" hint="I return a structure of font metrics for a simple string.">
		<cfargument name="string" hint="I am the string to get the metrics of." required="yes" type="string" />
		<cfargument name="Font" hint="I am the font to use." required="no" type="any" default="" />
		<cfargument name="kerning" hint="I am the amount of kerning to apply." required="no" type="numeric" default="0" />
		<cfset var Image = CreateObject("Java", "java.awt.image.BufferedImage") />
		<cfset var Graphics = 0 />
		<cfset var GlyphVector = 0 />
		<cfset var FontMetrics = 0 />
		<cfset var LineMetrics = 0 />
		<cfset var Bounds = 0 />
		<cfset var metrics = StructNew() />
		<cfset var Transform = CreateObject("Java", "java.awt.geom.AffineTransform").init() />
		
		<!--- validate the font argument --->
		<cftry>
			<cfif (IsObject(arguments.Font) AND arguments.Font.getClass().getName() IS NOT "java.awt.Font") OR (NOT IsObject(arguments.Font) AND Len(arguments.Font))>
				<cfthrow message="Invalid Font attribute.  The Font attibute must be a Font object.  These can be loaded with loadSystemFont() or loadTTFFile()." />
			</cfif>
			<cfcatch>
				<cfthrow message="Invalid Font attribute.  The Font attibute must be a Font object.  These can be loaded with loadSystemFont() or loadTTFFile()." />
			</cfcatch>
		</cftry>
		
		<!---
			init the "holder" image
			-- we don't want to have created an image just to get the size of text
			-- what if we wanted to create an image based on the size of some text?
		--->
		<cfset Image.init(JavaCast("int", 1), JavaCast("int", 1), JavaCast("int", Image.TYPE_INT_ARGB)) />
		<cfset Graphics = Image.getGraphics() />
		
		<!--- validate font --->
		<cfif IsObject(arguments.Font)>
			<cfset Graphics.setFont(arguments.Font) />
		</cfif>
		
		<!--- apply any other graphic settings --->
		<cfset applyGrapicsSettings(Graphics) />
		
		<!--- load the font metrics --->
		<cfset FontMetrics = Graphics.getFontMetrics() />
		
		<!--- get the font metrics, etc --->
		<cfset Bounds = FontMetrics.getStringBounds(arguments.string, Graphics) />
		<cfset LineMetrics = FontMetrics.getLineMetrics(arguments.string, Graphics) />
		<cfset metrics.height = ceiling(bounds.getHeight()) />
		<cfset metrics.ascent = ceiling(LineMetrics.getAscent()) />
		<cfset metrics.descent = ceiling(LineMetrics.getDescent()) />
		<cfset metrics.leading = ceiling(LineMetrics.getLeading()) />
		
		
		<cfif arguments.kerning IS NOT 0>
			<cfset GlyphVector = Font.createGlyphVector(Graphics.getFontRenderContext(), JavaCast("string", arguments.string)) />
			
			<cfloop from="1" to="#Len(arguments.string) - 1#" index="i">
				<cfset Transform.setToTranslation( JavaCast("double", (kerning/100) * i), JavaCast("double", 0) ) />
			
				<!--- get the previous character's glyph's metrics and position and... do nothing with it. (I don't know why, but this line needs to be here)--->
				<cfset GlyphVector.getGlyphPosition(JavaCast("int",  1)) />
				
				<!--- set the transformation on this character --->
				<cfset GlyphVector.setGlyphTransform(JavaCast("int", i), Transform) /> 
			</cfloop>
			
			<cfset metrics.width = round(GlyphVector.getVisualBounds().getWidth()) />
		<cfelse>
			<cfset metrics.width = ceiling(bounds.getWidth()) />
		</cfif>
		
		<cfdump var="#metrics.width#" />
		
		<cfreturn metrics />
	</cffunction>
	
	
	
</cfcomponent>
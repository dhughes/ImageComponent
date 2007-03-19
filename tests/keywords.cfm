<cfset keywordArray = ListToArray("alagad,image,component,edit,images,coldfusion,manipulate,cfc,read,write,cfml,cf,draw,text,logo,overlay,watermark,logos,create,picture,pictures,create,resize,width,height,inspect,image size,size,editing,how to write,how to read,how to create,gallery,methods,jpeg,jpg,png,gif,file,conversion")/>
<cfset KWlist = "">
<cfset keyPhrases = ArrayNew(1) />

<cfset requiredWords = "image,coldfusion,cf,draw,text,logo,picture" />

<!--- loop 1 --->
<cfloop from="1" to="#ArrayLen(keywordArray)#" index="x">
	<!--- loop 2 --->
	<cfloop from="1" to="#ArrayLen(keywordArray)#" index="y">
		<!--- loop 3 --->
		<cfloop from="1" to="#ArrayLen(keywordArray)#" index="z">
			<cfif keywordArray[x] IS NOT keywordArray[y]
				AND keywordArray[x] IS NOT keywordArray[z]
				AND keywordArray[y] IS NOT keywordArray[z]>
				
				<cfset phrase = "#keywordArray[x]# #keywordArray[y]# #keywordArray[z]#"> 
				<cfset found = false>
				<!--- loop over the list and insure that at least one of the required words is present --->
				<cfloop list="#requiredWords#" index="word">
					<cfif Find(word, phrase)>
						<cfset found = true>
					</cfif>
				</cfloop>
	
				<cfif found>
					<cfif NOT (
						ListFind(KWlist, "#keywordArray[x]# #keywordArray[y]# #keywordArray[z]#") AND
						ListFind(KWlist, "#keywordArray[x]# #keywordArray[z]# #keywordArray[y]#") AND
						ListFind(KWlist, "#keywordArray[y]# #keywordArray[x]# #keywordArray[z]#") AND
						ListFind(KWlist, "#keywordArray[y]# #keywordArray[z]# #keywordArray[x]#") AND
						ListFind(KWlist, "#keywordArray[z]# #keywordArray[y]# #keywordArray[x]#") AND
						ListFind(KWlist, "#keywordArray[z]# #keywordArray[x]# #keywordArray[y]#"))>
						<cfset ArrayAppend(keyPhrases, "#keywordArray[x]# #keywordArray[y]# #keywordArray[z]#") />
						<cfset KWlist = ArrayToList(keyPhrases)>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>	
	</cfloop>
</cfloop>

<cfoutput>
	<cfloop from="1" to="#arraylen(keyPhrases)#" index="x">
		#keyPhrases[x]#<Br>
	</cfloop>
</cfoutput>
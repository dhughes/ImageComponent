<cfset path = "c:\test.txt" />

<cfset OutputStream = CreateObject("Java", "java.io.FileOutputStream") /> 
<cfset OutputStream = OutputStream.init(path) />

<cfset OutputStream.close() />
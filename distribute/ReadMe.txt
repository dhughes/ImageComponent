Alagad Image Component 2.0 for ColdFusion and BlueDragon CD-ROM		
ReadMe Notes

http://www.alagad.com/index.cfm/name-aic/cd-2

==========================================================================
Table of Contents
This read me file contains the following information.

  Installation Instructions
  Registration Instructions
  CD-ROM Contents
  Known Issues

Installation Instructions
====================
Instructions for installing and using the Alagad Image Component can be found in
the documentation folder.

To run the examples in the examples folder you will need to create a mapping
named "/Image" which points to the folder where you placed the Image.cfc file.

Purchasing Instructions
====================
The Alagad Image Component is not free software.  Subject to the terms and
conditions of this license you are hereby granted licensed by Alagad Inc. to
install and use one copy of the Alagad Image Component on one computer for a
period of no more than 30 days from the initial installation.  If you use this
software after the 30 days have lapsed you are required to pay a fee of $75.00
per installation.  Payments can be made at 
http://www.alagad.com/index.cfm/name-buyl/prod-aic.

For more information see the document 
"Alagad Image Component 30 Day EvaluationLicense.rtf"

CD-ROM Contents
====================
This CD-ROM contains a trial version of the Alagad Image Component and related 
materials.  The folders on this CD-ROM contain the following items.

BlueDragon JX 6.1 Version (Beta)
This version of the Image Component has been removed and is no longer supported.

BlueDragon JX 6.2 Version (Beta)
A beta version of the Alagad Image Component.  The ReadMe.txt file in this 
directory contains information on this version of the Image Component.

ColdFusion MX 6.1 and MX 7 Version
The Alagad Image Component for ColdFusion MX 6.1, MX 7 or later.

Documentation
Documentation for the Alagad Image Component.  Documentation provided in 
Acrobat, HTML and Microsoft Word formats.

Examples
This folder contains 7 examples demonstrating common usages for the Image
Component.  Be sure to create a ColdFusion mapping named "/Image" pointing to
the directory containing the Image.cfc file so that the examples will work.

Known Issues
====================

Some Users get an error like this: "This graphics environment can be used only 
in the software emulation"

This error was addressed in Macromedia technote 18747 
(http://www.macromedia.com/support/coldfusion/ts/documents/graphics_unix_141jvm.htm) 
and is addressed in the documentation.

I have had several reports of this.  

One user has claimed that the link above fixes the problems for JPEGs and not 
GIFs.  I have not been able to reproduce.

Another good resource for resolving this problem can be found at: 
http://www.doughughes.net/index.cfm/page-blogLink/entryId-29

----------------------------------------------------------------------

One user has reported that Red and Blue color channels are swapped in PNG 
images.

When reading and then writing a specific PNG image, the image came out with the 
red and blue channels swapped so that everything blue in the image was red and 
everything red was blue.

This problem is cropping up because java doesn't recognize the image's color 
model.  

When reading an image, the following objects are created:

BufferedImage - the java object which will hold the image data.
FileIO - the object used to read files off disk 
ImageIO - the object which translates FileIO into the BuffedImage (more or less)

When writing images to disk I do the same thing in reverse.

The problem arises when moving data around between these objects.  The PNG in 
question's type (RGB, BRG, Grayscale, indexed, etc) is not recognized by Java.  
This appears to be because the Image type is actually BRG and not RGB.  And, 
because Java doesn't correctly identify the image type, when ImageData is 
manipulated the red channel's data will end up in the resulting image's blue and 
the blue in the red.

----------------------------------------------------------------------

Some users have reported errors on very minimal RedHat installations.

Some systems with very minimal (router-like) installations can not use the 
component.  They get messages like:
/opt/coldfusionmx/runtime/jre/lib/i386/libawt.so: libXp.so.6: cannot open shared 
object file: No such file or directory

This appears to be due to dependencies which Java.awt has on the underlying 
system.

I reproduced this error.  I have a barebones minimal installation of RedHat 9.  
This install added absolutely none of the X server libraries.  When I tried to 
use the AIC on this server I produced the error.

Because the system is "headless" I followed the instructions from macromedia 
technote 18747 at 
http://www.macromedia.com/support/coldfusion/ts/documents/graphics_unix_141jvm.htm 
which shows how to fix another error which seemed related.  (This is the fabled 
"headless system" error messages.)  This did not fix the problem.

All in all, it appears that even when Java is running in a headless mode it 
still relies on some libraries from the underlying system.  Without these calls 
to java.awt classes will error out.  

Only one users has reported this problem.  Last I knew this user was attempting 
to fix the problem by installing a virtual frame buffer.  I was not able to 
solve the problem.

Users who experience this problem may want to try installing PJA as documented 
here: http://www.doughughes.net/index.cfm/page-blogLink/entryId-29

----------------------------------------------------------------------

Some Images "turn red"

One user reported an error when a large number of images he was processing were 
turning red.  To describe the problem, the resulting image was still 
recognizable but had a strong red tint, as if you held red cellophane over the 
image.

When looking at the resulting image in PhotoShop I found that the green and blue 
channels had lost most of their data and were a mostly an even middle gray 
color.

After much experimenting I noticed that the Images don't appear to be standard 
JPEG Images.  If you open a standard JPEG in a hex editor and compare it to an 
image which is producing the bug, you will notice that there are big 
differences.

In general, and without getting into too much detail, JPEG images are broken 
down into multiple sections.  The first 16 section (markers) in the JPEGs can be 
used to store data.  Typically the data stored is EXIF or IPTC or other such 
meta data.  These are also typically always stored in the same sections.  The 
problem images appear to not be storing these first 16 sections in the standard 
way.  It appears to be cramming EXIF data right at the beginning of the image, 
which is atypical.

The result of this is that Java's JPEG ImageReader chokes and corrupts the image 
data as described.

For some, but not all of these images, I was able to fix the problem by putting 
the JAI into the ColdFusion class path.  This changes the ImageReaders used by 
the Java.awt package.  The JAI readers seem to be more robust and fixed the 
problem 50% of the time.  However, some images still had the red cast.  
Instructions for installing the JAI can be found at: 
http://www.alagad.com/index.cfm/name-aicformats

All of the problem images were taken with a Canon PowerShot G1 (according to 
EXIF data).

=======================================================================

Copyright (c) 2004 Alagad Inc. All rights reserved. 

=======================================================================
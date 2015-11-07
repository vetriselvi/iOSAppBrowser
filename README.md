# iOSAppBrowser
Ali Baba's Browser - Passcode enabled Private iOS browser application with a floating toolbar


"Say open sesame (aka input your passcode) and enter the treasure cave 
(No, actually you get access to your Private browser)"
To test the application:

1. Download the repository zip file and unzip the contents
2. Open the xcode file and run it in xcode
3. Use the passcode : 0112358 to access entry to the Private Browser
4. Additionaly, change the passcode to you're desired one at line:63 in viewController.m
P.S. Since this app uses HTTP request and if you have updated Xcode recently to 7.1 and 
if you face any error pertaining to App Transport Security do look into 
https://forums.developer.apple.com/thread/3544 and do the edit mentioned in the thread in the Info.plist. 
This will disable ATS and let you test the app.

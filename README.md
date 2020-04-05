# ForceBindIP-Gui
A GUI For ForceBindIP

A Simple Application Written With AutoIt Programming language   
![alt text](https://github.com/mhasanjb/ForceBindIP-Gui/blob/master/Preview2.png  "(Preview)ForceBindIP - By M.Hasan Jabbari")


1. Download ForceBindIP ( https://r1ch.net/projects/forcebindip )    
2. Copy ForceBindIP To C:\Windows\system32 (for x86)    
3. Copy ForceBindIP To C:\Windows\sysWOW64 (for x64)    
4. Run ForceBindIP-Gui.exe ( or compile it then open if u want )    
5. Enjoy :)

## Google Chrome Compatibility
Chrome requires additional configuration to run under ForceBindIP. This is because Chrome 72 or later blocks 3rd party programs from injecting DLLs. To allow ForceBindIP to work, install this enterprise policy registry file to re-enable DLL injection, then open Chrome and go to chrome://flags/#network-service-in-process and enable the setting (Chrome 76+) or chrome://flags#network-service and disable the setting (Chrome 75-).    


## Firefox Compatibility
Firefox requires the about:config?filter=browser.launcherProcess.enabled preference set to false, otherwise ForceBindIP attaches to the launcher and not the actual program.

## Copying ForceBindIP
If you install ForceBindIP it might be in     
C:\Program Files (x86)\ForceBindIP    
or    
C:\Program Files\ForceBindIP   

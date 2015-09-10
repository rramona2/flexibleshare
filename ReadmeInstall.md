## Web Scripts Installation ##
  1. In Alfreso Explorer (Web Client) use the Import action and import integratedsemantics.zip into /Company Home/Data Dictionary/Web Scripts Extensions/
  1. restart Alfresco server or use the "Refresh Web Scripts" button on http://localhost:8080/alfresco/service/ on the web script home page
  1. verify install of webscripts on the web script home page by "Browse by Web Script Package" and you should see bunch of /integratedsemantics packages

## FlexibleShare "In Browser" Installation ##
  1. web script installation required first
  1. copy "flexible-share" folder to <alfresco install dir>/tomcat/webapps
  1. configure default domain (hostname or ip address) and port in FlexibleShareConfig.xml (users can override in preferences dialog)
  1. run  http://localhost:8080/flexible-share/FlexibleShare.html

## FlexibleShare AIR Installation ##
  1. web script installation required first
  1. Run FlexibleShareAir.air to install but don't launch right after install if changing config file
  1. configure domain (hostname or ip address) and port in FlexibleShareConfig.xml or use preferences dialog
  1. on 32 bit Windows FlexibleShareConfig.xml is in c:\Program Files\FlexibleShareAIR
  1. on 64 bit Windows FlexibleShareConfig.xml is in C:\Program Files (x86)\FlexibleShareAir
  1. on Mac: In finder choose "Show Package Contents" on installed FlexibleShareAir.app, FlexibleShareConfig.xml is in contents/resources/
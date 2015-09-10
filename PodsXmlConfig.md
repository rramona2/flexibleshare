## data/flexibleShareAirPods.xml ##
  1. configures what pods to have
  1. see data/flexibleShareAirPodsAll.xml for all possible pods
  1. some pods are commented out, can be added back in
  1. xml files used for in browser non air FlexibleShare is data/flexibleSharePods.xml (with example of all possible pods in data/flexibleSharePodsAll.xmll)


## Overall pod xml structure ##
  1. each view section sets up a tab view
  1. can add, change, delete views the default view config in flexibleShareAirPods.xml
  1. can choose to have any of the pods in a given view
  1. same as esria dashboard

## FlexSpaces pods ##
  1. further along than the rest, runs flexspaces views in different portlets/pods
  1. doclib, search, tasks (workflow), wcm, flexspaces (pod with all views in one)
  1. simplesearch and search are the same functionality currently
  1. files from local files pod can be dragged into doclib pod (air only)
  1. files from your desktop can be dragged into doclib pod (air only)
  1. files from your desktop can be pasted into doclib pod (air only)
  1. (Alfresco server needs to be running, integratedsemantics.zip webscripts need to be installed,and FlexSpacesConfig.xml needs to be configured)

## Share pods ##
  1. Flex UI with Alfresco Share collaboration backend
  1. no commenting in blog, discussions, doclib yet
  1. calendar doesn't have read of info from share calendar, or add events yet (can load a us\_holiday.ics, other ics) (calendar from Ely Greenfield's quietlyscheming.com)
  1. the share pods are protypes
  1. the default share site for thse pods can be set in pods xml: siteUrlName="s1" (this is currently not used, need to select site in selection selection dropdown at the top left of share pods
  1. (Alfresco server needs to be running, integratedsemantics.zip webscripts need to be installed,and FlexSpacesConfig.xml needs to be configured)

## Charting pods ##
  1. from esria dashboard, uses quietlyscheming chart animations

## Pentaho pod ##
  1. uses code from James Ward's port of pentaho dashboard to flex
  1. built version uses sample data, code that can call pentaho server is commented out

## JasperReports pod ##
  1. displays reports/WebappReport.jrpxml
  1. uses code from JasperReports flash viewer, changed to read from file instead of server

## BlazedDS pods ##
  1. There are two pods that run samples from BlazeDS
  1. BlazeDS pods need blazeds samples.war in your tomcat webapps dir
  1. They also need the the BlazeDS sampledb/startdb.bat running before starting tomcat

## HTML pods ##
  1. works better in AIR since can use air html webkit control
  1. in browser version uses iframe, should stick to using tile mode and don't use cascade button
  1. in pod xml set url to url of web page

## Liferay pods (AIR only) ##
  1. (Each can display a given portlet from a running Liferay server)
  1. the url of liferay can be set with portalUrl in the pod xml
  1. the url of a liferay portlet is set with the portletUrl pod xml. To get the liferay widget url for a given portlet, choose edit configuration on portlet in liferay / sharing tab / any website tab
  1. Also "Look and Feel" config on the portlet in liferay in first tab, unselecting show borders will hide liferay's portlet title and border from showing in these pods
  1. to run liferay in a separate tomcat at the same time as alfresco in another tomcat, I usually change in the liferay conf/server.xml all the ports 80xx to 90xx

## Local files pod (AIR only) ##
  1. displays a tree and list of local files
  1. useful for dragging files into other pods with native air drag/drip support (such as the doclib pods in flexibleshareair)

## Google Gadget pods (AIR only) ##
  1. NOTE: Something has changed where gadget urls from google gmodules.com only display as outlines currently
  1. maybe it would work if you have your own gadget server
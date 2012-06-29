package org.integratedsemantics.flexibleshare.share.wiki
{
    import com.esria.samples.dashboard.view.PodContentBase;
    
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    import mx.collections.ArrayCollection;
    import mx.controls.Tree;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;
    
    import org.integratedsemantics.flexibleshare.share.rte.RichTextEdit;
    import org.integratedsemantics.flexibleshare.share.wiki.create.CreateWikiPageView;
    import org.integratedsemantics.flexibleshare.share.wiki.edit.EditWikiPageView;
    import org.integratedsemantics.flexspaces.control.event.ui.DeleteNodesUIEvent;
    import org.integratedsemantics.flexspaces.control.event.ui.TagsCategoriesUIEvent;
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.model.tree.TreeNode;
    
    import spark.components.Button;
    import spark.components.DropDownList;
    import spark.events.IndexChangeEvent;


    public class WikiPodBase extends PodContentBase
    {               
        public var newWikiPageBtn:Button;
        public var wikiTree:Tree;
        public var rte:RichTextEdit;
        public var editBtn:Button;
        public var deleteBtn:Button;
        public var tagBtn:Button;
		public var siteListDropDown:DropDownList;

        [Bindable]
        protected var treeRoot:TreeNode = new TreeNode("Pages", "Pages");

		[Bindable]
		protected var siteList:ArrayCollection = new ArrayCollection();
        
        private var recentlyModifiedNode:TreeNode;
        private var allTreeNode:TreeNode;
        private var recentlyAddedTreeNode:TreeNode;
        private var myPagesTreeNode:TreeNode;
                
        private var model:AppModelLocator = AppModelLocator.getInstance();
        
        [Embed(source="images/filetypes/_default.png")]
        private var pageIcon:Class;
        
        private var editView:EditWikiPageView;
        private var createView:CreateWikiPageView;
        
        private var site:String;     
        

        public function WikiPodBase()
        {
            super();
        }
                                
        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);

			// todo: use initial site configured if not empty string or null
            site = properties.@siteUrlName;    

            recentlyModifiedNode = new TreeNode("Recently Modified", "recentlymodified");
            treeRoot.children.addItem(recentlyModifiedNode);

            allTreeNode = new TreeNode("All", "all");
            treeRoot.children.addItem(allTreeNode);

            recentlyAddedTreeNode = new TreeNode("Recently Added", "recentlyadded");
            treeRoot.children.addItem(recentlyAddedTreeNode);

            myPagesTreeNode = new TreeNode("My Pages", "mypages");
            treeRoot.children.addItem(myPagesTreeNode);
           
            wikiTree.expandChildrenOf(treeRoot, true);   
			
			getSites();
		}
		
		protected function getSites():void
		{
			var service:HTTPService = new HTTPService;
			service.url = model.ecmServerConfig.urlPrefix + "/api/sites";
			service.resultFormat = "text";
			service.addEventListener(ResultEvent.RESULT, onJSONSites);            
			service.addEventListener(FaultEvent.FAULT, onFault);
			var result:AsyncToken = null;
			var parameters:Object = new Object();
			parameters.alf_ticket = model.userInfo.loginTicket;
			result = service.send(parameters);                  
		}

		protected function getRecentlyModifiedPages():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/slingshot/wiki/pages/" + site;
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadRecentlyModified);           
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            parameters.filter = "recentlyModified";
            result = service.send(parameters);                       
        }

        protected function getAllPages():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/slingshot/wiki/pages/" + site;
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadAll);            
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            parameters.filter = "all";
            result = service.send(parameters);                       
        }

        protected function getRecentlyAddedPages():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/slingshot/wiki/pages/" + site;
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadRecentlyAdded);            
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            parameters.filter = "recentlyAdded";
            result = service.send(parameters);                  
        }

        protected function getMyPages():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/slingshot/wiki/pages/" + site;
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadMyPages);         
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            parameters.filter = "myPages";
            result = service.send(parameters);                       
        }
                
        protected function updateAll():void
        {
            recentlyModifiedNode.children.removeAll();
            allTreeNode.children.removeAll();
            recentlyAddedTreeNode.children.removeAll();
            myPagesTreeNode.children.removeAll();
            getRecentlyModifiedPages();
            getAllPages(); 
            getRecentlyAddedPages();
            getMyPages();
        }

		private function onJSONSites(event:ResultEvent):void
		{
			addSites(event.result);        
		}
				
        private function onJSONLoadRecentlyModified(event:ResultEvent):void
        {
            addPages(event.result, recentlyModifiedNode);        
        }

        private function onJSONLoadAll(event:ResultEvent):void
        {
            addPages(event.result, allTreeNode);        
        }

        private function onJSONLoadRecentlyAdded(event:ResultEvent):void
        {
            addPages(event.result, recentlyAddedTreeNode);                    
        }

        private function onJSONLoadMyPages(event:ResultEvent):void
        {
            addPages(event.result, myPagesTreeNode);                    
        }

        private function onFault(event:FaultEvent):void
        {
            trace("get topics fault");           
        }
        
		private function addSites(data:Object):void
		{
			var dataStr:String = String(data);
			var obj:Object = JSON.parse(dataStr);      
			siteList.source = obj as Array;
		}		
		
        private function addPages(data:Object, parent:TreeNode):void
        {
            var dataStr:String = String(data);
            var obj:Object = JSON.parse(dataStr);      
            var items:Array = obj.pages as Array;
            for each (var item:Object in items)
            {
                var wikiPage:WikiPage = new WikiPage();
                wikiPage.title = item.title;
                wikiPage.label = wikiPage.title;
                wikiPage.content = item.text;
                //wikiPage.nodeRef = item.nodeRef;
                wikiPage.name = item.name;
                //wikiPage.id = wikiPage.nodeRef.substr(24);
                parent.children.addItem(wikiPage);
                wikiTree.setItemIcon(wikiPage, pageIcon, null);       
            }                        
        }
                     
        protected function onTreeChange(event:Event):void
        {
            if (wikiTree.selectedItem is WikiPage)
            {
                var wikiPage:WikiPage = wikiTree.selectedItem as WikiPage;
                var content:String = wikiPage.content;
                rte.htmlText = content;
                editBtn.enabled = true;
                //deleteBtn.enabled = true;
                //tagBtn.enabled = true;                           
            }      
            else
            {
                rte.htmlText = ""; 
                editBtn.enabled = false;
                deleteBtn.enabled = false;
                tagBtn.enabled = false;                                                                                     
            }     
        }

        protected function onEdit(event:Event):void
        {
            if (wikiTree.selectedItem is WikiPage)
            {                            
                var wikiPage:WikiPage = wikiTree.selectedItem as WikiPage;
                if (this.editView == null)
                {
                    editView = EditWikiPageView(PopUpManager.createPopUp(this, EditWikiPageView, false));
                    editView.onComplete = editWikiPageDialogComplete;
                    editView.wikiPage = wikiPage;
                }   
                else
                {
                   PopUpManager.addPopUp(editView, this);
                   editView.titleTextInput.text = wikiPage.title;
                   editView.setContent(wikiPage.content);
                   editView.onComplete = editWikiPageDialogComplete;
                   editView.wikiPage = wikiPage;
                }
            }      
        }

        private function editWikiPageDialogComplete(wikiPage:WikiPage):void
        {
            var content:String = wikiPage.content;
            rte.htmlText = content;
            
            var url:String = model.ecmServerConfig.urlPrefix + "/slingshot/wiki/page/" + site + "/" + wikiPage.title;
            url = url + "?alf_ticket=" + model.userInfo.loginTicket + "&alf_method=PUT";
            var obj:Object = new Object();
            obj.container = "wiki";
            obj.pagecontent = wikiPage.content;
            obj.site = site;            
            obj.title = wikiPage.title;
            obj.forceSave = "true";
            obj.page = "wiki-page";
            var jsonStr:String = JSON.stringify(obj);      
            
            var request:URLRequest = new URLRequest(url);
            request.contentType = "application/json";
            request.data = jsonStr;
            request.method = "POST";
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onEditWikiPageComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorEditWikiPage);
            loader.load(request);
        }
               
        private function onEditWikiPageComplete(event:Event):void 
        {
            //trace("URLLoader onEditWikiPageComplete()");
        }        

        private function onIOErrorEditWikiPage(e:IOErrorEvent):void 
        {
            trace("URLLoader onIOErrorEditWikiPage()");
        }

        protected function onDelete(event:Event):void
        {
            if (wikiTree.selectedItem is WikiPage)
            {                            
                var wikiPage:WikiPage = wikiTree.selectedItem as WikiPage;
                var items:Array = new Array();
                items.push(wikiPage);
                var deleteEvent:DeleteNodesUIEvent = new DeleteNodesUIEvent(DeleteNodesUIEvent.DELETE_NODES_UI, null, items, this, onDeleteComplete);
                deleteEvent.dispatch();                                                            
            }                  
        }
        
        private function onDeleteComplete():void
        {
            rte.htmlText = "";
            wikiTree.selectedItem = null;

            updateAll();
        }

        protected function onTag(event:Event):void
        {
            if (wikiTree.selectedItem is WikiPage)
            {                            
                var wikiPage:WikiPage = wikiTree.selectedItem as WikiPage;
                var tagEvent:TagsCategoriesUIEvent = new TagsCategoriesUIEvent(TagsCategoriesUIEvent.TAGS_CATEGORIES_UI, null, wikiPage, this, null);
                tagEvent.dispatch();
            }             
        }

        protected function onNewWikiPage(event:Event):void
        {
            if (this.createView == null)
            {
                createView = CreateWikiPageView(PopUpManager.createPopUp(this, CreateWikiPageView, false));
                createView.onComplete = createWikiPageDialogComplete;
                createView.wikiPage = new WikiPage();
            }   
            else
            {
               PopUpManager.addPopUp(createView, this);
               createView.onComplete = createWikiPageDialogComplete;
               createView.wikiPage = new WikiPage;
            }            
        }

        private function createWikiPageDialogComplete(wikiPage:WikiPage):void
        {
            rte.htmlText = "";
            wikiTree.selectedItem = null;

            var content:String = wikiPage.content;
            
            var url:String = model.ecmServerConfig.urlPrefix + "/slingshot/wiki/page/" + site + "/" + wikiPage.title;
            url = url + "?alf_ticket=" + model.userInfo.loginTicket + "&alf_method=PUT";
            var obj:Object = new Object();
            obj.container = "wiki";
            obj.pagecontent = wikiPage.content;
            obj.site = site;            
            obj.title = wikiPage.title;
            obj.forceSave = "true";
            obj.page = "wiki-page";
            var jsonStr:String = JSON.stringify(obj);                        
            
            var request:URLRequest = new URLRequest(url);
            request.contentType = "application/json";
            request.data = jsonStr;
            request.method = "POST";
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onCreateWikiPageComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorCreateWikiPage);
            loader.load(request);
        }
        
        private function onCreateWikiPageComplete(event:Event):void 
        {
            //trace("WikiPodBase onCreateWikiPageComplete()");
            
            updateAll();            
        }        
        
        private function onIOErrorCreateWikiPage(e:IOErrorEvent):void 
        {
            trace("WikiPodBase onIOErrorCreateWikiPage()");
        }
		
		protected function onSelectSite(event:IndexChangeEvent):void
		{	
			if (siteList.length > 0)
			{
				var siteInfo:Object = siteList.getItemAt(event.newIndex);
				this.site = siteInfo.shortName;
			}
			rte.htmlText = ""; 			
			updateAll();
		}		
    
    }
}
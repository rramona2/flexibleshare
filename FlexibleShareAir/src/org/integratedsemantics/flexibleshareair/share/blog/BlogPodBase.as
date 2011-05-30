package org.integratedsemantics.flexibleshareair.share.blog
{
    import com.adobe.serialization.json.JSON;
    import com.esria.samples.dashboard.view.PodContentBase;
    
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    import mx.controls.HTML;
    import mx.controls.Tree;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;
    
    import org.integratedsemantics.flexibleshare.share.blog.BlogPost;
    import org.integratedsemantics.flexibleshareair.share.blog.create.CreateBlogPostView;
    import org.integratedsemantics.flexibleshareair.share.blog.edit.EditBlogPostView;
    import org.integratedsemantics.flexspaces.control.event.ui.DeleteNodesUIEvent;
    import org.integratedsemantics.flexspaces.control.event.ui.TagsCategoriesUIEvent;
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.model.tree.TreeNode;
    
    import spark.components.Button;

    
    public class BlogPodBase extends PodContentBase
    {               
        public var newPostBtn:Button;
        public var configBlog:Button;
        public var blogTree:Tree;
        public var htmlControl:HTML;
        public var editBtn:Button;
        public var deleteBtn:Button;
        public var tagBtn:Button;

        [Bindable]
        protected var treeRoot:TreeNode = new TreeNode("Blog Posts", "Blog Posts");
        
        private var allTreeNode:TreeNode;
        private var latestTreeNode:TreeNode;
        private var myDraftsTreeNode:TreeNode;
        private var myPublishedTreeNode:TreeNode;
        private var myExternPublishedTreeNode:TreeNode;
                
        private var model:AppModelLocator = AppModelLocator.getInstance();
        
        [Embed(source="images/filetypes/_default.png")]
        private var postIcon:Class;
        
        private var editView:EditBlogPostView;
        private var createView:CreateBlogPostView;
        
        private var site:String;     
        

        public function BlogPodBase()
        {
            super();
        }
                                
        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);

            site = properties.@siteUrlName;    

            allTreeNode = new TreeNode("All", "all");
            treeRoot.children.addItem(allTreeNode);

            latestTreeNode = new TreeNode("Latest", "latest");
            treeRoot.children.addItem(latestTreeNode);

            myDraftsTreeNode = new TreeNode("My Drafts", "mydrafts");
            treeRoot.children.addItem(myDraftsTreeNode);

            myPublishedTreeNode = new TreeNode("My Published", "mypublished");
            treeRoot.children.addItem(myPublishedTreeNode);

            myExternPublishedTreeNode = new TreeNode("Published Externally", "publishedexternally");
            treeRoot.children.addItem(myExternPublishedTreeNode);
            
            getAllPosts(); 
            getLatestPosts();
            getMyDraftPosts();
            getMyPublishedPosts();
            getPublishedExternallyPosts();
            
            blogTree.expandChildrenOf(treeRoot, true);       
        }

        protected function getAllPosts():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/api/blog/site/" + site + "/blog/posts";
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadAll);            
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            result = service.send(parameters);                  
        }

        protected function getLatestPosts():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/api/blog/site/" + site + "/blog/posts/new";
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadLatest);           
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            parameters.numdays = "10";
            result = service.send(parameters);                       
        }

        protected function getMyDraftPosts():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/api/blog/site/" + site + "/blog/posts/mydrafts";
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadDrafts);            
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            result = service.send(parameters);                       
        }

        protected function getMyPublishedPosts():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/api/blog/site/" + site + "/blog/posts/mypublished";
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadPublished);         
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            result = service.send(parameters);                       
        }
        
        protected function getPublishedExternallyPosts():void
        {
            var service:HTTPService = new HTTPService;
            service.url = model.ecmServerConfig.urlPrefix + "/api/blog/site/" + site + "/blog/posts/publishedext";
            service.resultFormat = "text";
            service.addEventListener(ResultEvent.RESULT, onJSONLoadPublishedExtern);           
            service.addEventListener(FaultEvent.FAULT, onFault);
            var result:AsyncToken = null;
            var parameters:Object = new Object();
            parameters.alf_ticket = model.userInfo.loginTicket;
            result = service.send(parameters);                                                           
        }        
        
        protected function updateAll():void
        {
            allTreeNode.children.removeAll();
            latestTreeNode.children.removeAll();
            myDraftsTreeNode.children.removeAll();
            myPublishedTreeNode.children.removeAll();
            myExternPublishedTreeNode.children.removeAll();
            getAllPosts(); 
            getLatestPosts();
            getMyDraftPosts();
            getMyPublishedPosts();
            getPublishedExternallyPosts();            
        }
        
        private function onJSONLoadAll(event:ResultEvent):void
        {
            addPosts(event.result, allTreeNode);        
        }
        
        private function onJSONLoadLatest(event:ResultEvent):void
        {
            addPosts(event.result, latestTreeNode);        
        }

        private function onJSONLoadDrafts(event:ResultEvent):void
        {
            addPosts(event.result, myDraftsTreeNode);                    
        }

        private function onJSONLoadPublished(event:ResultEvent):void
        {
            addPosts(event.result, myPublishedTreeNode);                    
        }

        private function onJSONLoadPublishedExtern(event:ResultEvent):void
        {
            addPosts(event.result, myExternPublishedTreeNode);                    
        }

        private function onFault(event:FaultEvent):void
        {
            trace("get posts fault");           
        }
        
        private function addPosts(data:Object, parent:TreeNode):void
        {
            var dataStr:String = String(data);
            var obj:Object = JSON.decode(dataStr);      
            var items:Array = obj.items as Array;
            for each (var item:Object in items)
            {
                var blogPost:BlogPost = new BlogPost();
                blogPost.title = item.title;
                blogPost.label = blogPost.title;
                blogPost.content = item.content;
                blogPost.nodeRef = item.nodeRef;
                blogPost.name = item.name;
                blogPost.id = blogPost.nodeRef.substr(24);
                parent.children.addItem(blogPost);
                blogTree.setItemIcon(blogPost, postIcon, null);       
            }                        
        }
                     
        protected function onTreeChange(event:Event):void
        {
            if (blogTree.selectedItem is BlogPost)
            {
                var blogPost:BlogPost = blogTree.selectedItem as BlogPost;
                var content:String = blogPost.content;
                htmlControl.htmlText = content;
                editBtn.enabled = true;
                deleteBtn.enabled = true;
                tagBtn.enabled = true;                           
            }      
            else
            {
                htmlControl.htmlText = ""; 
                editBtn.enabled = false;
                deleteBtn.enabled = false;
                tagBtn.enabled = false;                                                                                     
            }     
        }

        protected function onEdit(event:Event):void
        {
            if (blogTree.selectedItem is BlogPost)
            {                            
                var blogPost:BlogPost = blogTree.selectedItem as BlogPost;
                if (this.editView == null)
                {
                    editView = EditBlogPostView(PopUpManager.createPopUp(this, EditBlogPostView, false));
                    editView.onComplete = editBlogPostDialogComplete;
                    editView.blogPost = blogPost;
                }   
                else
                {
                   PopUpManager.addPopUp(editView, this);
                   editView.titleTextInput.text = blogPost.title;
                   editView.setContent(blogPost.content);
                   editView.onComplete = editBlogPostDialogComplete;
                   editView.blogPost = blogPost;
                }
            }      
        }

        private function editBlogPostDialogComplete(blogPost:BlogPost):void
        {
            var content:String = blogPost.content;
            htmlControl.htmlText = content;
            
            var url:String = model.ecmServerConfig.urlPrefix + "/api/blog/post/node/workspace/SpacesStore/" + blogPost.id;
            url = url + "?alf_ticket=" + model.userInfo.loginTicket + "&alf_method=PUT";
            var obj:Object = new Object();
            obj.container = "blog";
            obj.content = blogPost.content;
            obj.draft = blogPost.isDraft;
            obj.site = site;            
            obj.title = blogPost.title;
            var jsonStr:String = JSON.encode(obj);                        
            
            var request:URLRequest = new URLRequest(url);
            request.contentType = "application/json";
            request.data = jsonStr;
            request.method = "POST";
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onEditPostComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorEditPost);
            loader.load(request);
        }
               
        private function onEditPostComplete(event:Event):void 
        {
            //trace("URLLoader onEditPostComplete()");
        }        

        private function onIOErrorEditPost(e:IOErrorEvent):void 
        {
            trace("URLLoader onIOErrorEditPost()");
        }

        protected function onDelete(event:Event):void
        {
            if (blogTree.selectedItem is BlogPost)
            {                            
                var blogPost:BlogPost = blogTree.selectedItem as BlogPost;
                var items:Array = new Array();
                items.push(blogPost);
                var deleteEvent:DeleteNodesUIEvent = new DeleteNodesUIEvent(DeleteNodesUIEvent.DELETE_NODES_UI, null, items, this, onDeleteComplete);
                deleteEvent.dispatch();                                                            
            }                  
        }
        
        private function onDeleteComplete():void
        {
            htmlControl.htmlText = "";
            blogTree.selectedItem = null;

            updateAll();
        }

        protected function onTag(event:Event):void
        {
            if (blogTree.selectedItem is BlogPost)
            {                            
                var blogPost:BlogPost = blogTree.selectedItem as BlogPost;
                var tagEvent:TagsCategoriesUIEvent = new TagsCategoriesUIEvent(TagsCategoriesUIEvent.TAGS_CATEGORIES_UI, null, blogPost, this, null);
                tagEvent.dispatch();
            }             
        }

        protected function onNewPost(event:Event):void
        {
            if (this.createView == null)
            {
                createView = CreateBlogPostView(PopUpManager.createPopUp(this, CreateBlogPostView, false));
                createView.onComplete = createBlogPostDialogComplete;
                createView.blogPost = new BlogPost();
            }   
            else
            {
               PopUpManager.addPopUp(createView, this);
               createView.onComplete = createBlogPostDialogComplete;
               createView.blogPost = new BlogPost;
            }            
        }

        private function createBlogPostDialogComplete(blogPost:BlogPost):void
        {
            htmlControl.htmlText = "";
            blogTree.selectedItem = null;

            var content:String = blogPost.content;
            
            var url:String = model.ecmServerConfig.urlPrefix + "/api/blog/site/" + site + "/blog/posts";
            url = url + "?alf_ticket=" + model.userInfo.loginTicket;
            var obj:Object = new Object();
            obj.container = "blog";
            obj.content = blogPost.content;
            obj.draft = blogPost.isDraft;
            obj.site = site;            
            obj.title = blogPost.title;
            var jsonStr:String = JSON.encode(obj);                        
            
            var request:URLRequest = new URLRequest(url);
            request.contentType = "application/json";
            request.data = jsonStr;
            request.method = "POST";
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onCreatePostComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorCreatePost);
            loader.load(request);
        }
        
        private function onCreatePostComplete(event:Event):void 
        {
            //trace("URLLoader onCreatePostComplete()");
            
            allTreeNode.children.removeAll();
            latestTreeNode.children.removeAll();
            myDraftsTreeNode.children.removeAll();
            getAllPosts(); 
            getLatestPosts();
            getMyDraftPosts();
        }        
        
        private function onIOErrorCreatePost(e:IOErrorEvent):void 
        {
            trace("URLLoader onIOErrorCreatePost()");
        }

        protected function onConfigureExternalBlog(event:Event):void
        {
        }
    
    }
}
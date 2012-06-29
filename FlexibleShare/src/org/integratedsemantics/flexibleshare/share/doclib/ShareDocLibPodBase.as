package org.integratedsemantics.flexibleshare.share.doclib
{
    import com.esria.samples.dashboard.view.PodContentBase;
    
    import mx.collections.ArrayCollection;
    import mx.events.FlexEvent;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;
    
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.presmodel.main.FlexSpacesPresModel;
    
    import spark.components.DropDownList;
    import spark.events.IndexChangeEvent;

    public class ShareDocLibPodBase extends PodContentBase
    {
        [Bindable]
        protected var presModel:FlexSpacesPresModel;

        [Bindable]
        protected var site:String;

		public var siteListDropDown:DropDownList;
        
		[Bindable]
		protected var siteList:ArrayCollection = new ArrayCollection();
		
		public var shareDocLibView:ShareDocLibView;

		
        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);
            
			// todo: use initial site configured if not empty string or null
            site = properties.@siteUrlName;  
			
			getSites();			
        }
        
        public function ShareDocLibPodBase()
        {
            super();      
            
            var model:AppModelLocator = AppModelLocator.getInstance();         

            presModel = new FlexSpacesPresModel();

            presModel.showDocLib = true;
            presModel.showSearch = false;
            presModel.showTasks = false;
            presModel.showWCM = false;    
            presModel.showShare = false;        
            presModel.showHeader = false; 
        }    
		
		protected function getSites():void
		{
			var model:AppModelLocator = AppModelLocator.getInstance();         

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
		
		private function onJSONSites(event:ResultEvent):void
		{
			addSites(event.result);        
		}
				
		private function onFault(event:FaultEvent):void
		{
			trace("get sites fault");           
		}		
		
		private function addSites(data:Object):void
		{
			var dataStr:String = String(data);
			var obj:Object = JSON.parse(dataStr);      
			siteList.source = obj as Array;
		}		
		
		protected function onSelectSite(event:IndexChangeEvent):void
		{	
			if (siteList.length > 0)
			{
				var siteInfo:Object = siteList.getItemAt(event.newIndex);
				this.site = siteInfo.shortName;
				
				shareDocLibView.setSitePath(site);
			}
		}
        
    }
}
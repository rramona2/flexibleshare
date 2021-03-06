package org.integratedsemantics.flexibleshareair.app
{
	import com.esria.samples.dashboard.managers.PodLayoutManager;
	import com.esria.samples.dashboard.view.IPodContentBase;
	import com.esria.samples.dashboard.view.Pod;
	
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import flexlib.mdi.containers.MDICanvas;
	import flexlib.mdi.containers.MDIWindow;
	import flexlib.mdi.managers.MDIManager;
	
	import mx.charts.chartClasses.DataTip;
	import mx.containers.ViewStack;
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.Module;
	import mx.modules.ModuleManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.integratedsemantics.flexibledashboard.data.RemoteObjectDataService;
	import org.integratedsemantics.flexibledashboard.data.SoapDataService;
	import org.integratedsemantics.flexibledashboard.data.XmlDataService;
	import org.integratedsemantics.flexspaces.control.event.GetInfoEvent;
	import org.integratedsemantics.flexspaces.view.login.LoginDoneEvent;
	import org.integratedsemantics.flexspaces.view.login.LoginViewBase;
	import org.integratedsemantics.flexspaces.view.properties.tagscategories.TagsCategoriesView;
	import org.integratedsemantics.flexspaces.view.search.advanced.AdvancedSearchView;
	import org.integratedsemantics.flexspacesair.app.AirAppBase;
	import org.springextensions.actionscript.context.support.FlexXMLApplicationContext;
	import org.springextensions.actionscript.module.ISASModule;
	
	import spark.components.TabBar;
	import spark.events.IndexChangeEvent;

	public class FlexibleShareAirAppBase extends AirAppBase
	{
		public var modeViewStack:ViewStack;
		
        [Bindable]        
		public var viewStack:ViewStack;
		
		public var tabBar:TabBar;
		
        // view modes
        public static const GET_CONFIG_MODE_INDEX:int = 0;
        public static const LOGIN_MODE_INDEX:int = 1;
        public static const GET_INFO_MODE_INDEX:int = 2;
        public static const MAIN_VIEW_MODE_INDEX:int = 3;

        public var loginView:LoginViewBase;

		// Array of PodLayoutManagers
		protected var podLayoutManagers:Array = new Array();
		
		// Stores the xml data keyed off of a PodLayoutManager.
		protected var podDataDictionary:Dictionary = new Dictionary();
		
		// Stores PodLayoutManagers keyed off of a Pod.
		// Used for podLayoutManager calls after pods have been created for the first time.
		// Also, used for look-ups when saving pod content ViewStack changes.
		protected var podHash:Object = new Object();
		
        private var _moduleConfigList:Dictionary = new Dictionary();
        private var _moduleLayoutMgrList:Dictionary = new Dictionary();
        
        private var numPodsDoneInView:Number;
        private var numPodsInView:Number;  
        
        // todo: dummies not to get compiler warnings about syles for code in modules
        private var dataTipDummy:DataTip;
        
        private var viewIndex:int = 0;
        
		// force compiler to include these classes for spring actionscript app context xml config fle dependencies
        private var remoteObjectDataService:RemoteObjectDataService;
        private var soapDataService:SoapDataService;
        private var xmlDataService:XmlDataService;
		private var advSearchView:AdvancedSearchView;
		private var tagCategoriesView:TagsCategoriesView;
        
        private var _applicationContext:FlexXMLApplicationContext;		

		public function FlexibleShareAirAppBase()
		{
			super();
		}
		
		override protected function loadConfig():void
		{
			// spring actionscript config
			model.applicationContext = new FlexXMLApplicationContext("FlexibleShareConfig.xml");
			_applicationContext = model.applicationContext;
			model.applicationContext.addEventListener(Event.COMPLETE, onApplicationContextComplete);
			model.applicationContext.load();                                          
		}		
					
        override protected function onApplicationContextComplete(event:Event):void
        {
        	super.onApplicationContextComplete(event);
        	
            // need different resource path with pods in modules instead of normal flexspaces
            model.appConfig.srcPath = "/";
                        
            modeViewStack.selectedIndex = LOGIN_MODE_INDEX;            
        }
					
        /**
         * Handle login view creation complete
         *  
         * @param event on create complete event
         * 
         */
        protected function onLoginViewCreated(event:FlexEvent):void
        {
            loginView.addEventListener(LoginDoneEvent.LOGIN_DONE, onLoginDone);            
        }
                            
        /**
         * Handler called when login is successfully completed
         * 
         * @param   event   login done event
         */
        public function onLoginDone(event:LoginDoneEvent):void
        {
            modeViewStack.selectedIndex = GET_INFO_MODE_INDEX;  
       
            var responder:Responder = new Responder(onGetInfoDone, flexSpacesAirPresModel.onFaultAction);
            var getInfoEvent:GetInfoEvent = new GetInfoEvent(GetInfoEvent.GET_INFO, responder);
            getInfoEvent.dispatch();                
        }        

        /**
         * Handler called when get info is successfully completed
         * 
         * @param   event   get info event
         */
        public function onGetInfoDone(info:Object):void
        {
            // Switch from get info to (main view in view stack 
            modeViewStack.selectedIndex = MAIN_VIEW_MODE_INDEX; 
            onPortalCreationComplete();                                                
        }

		protected function onPortalCreationComplete():void
		{
			// Load pods.xml, which contains the pod layout.
			var httpService:HTTPService = new HTTPService();
			httpService.url = "data/flexibleShareAirPods.xml";
			httpService.resultFormat = "e4x";
			httpService.addEventListener(FaultEvent.FAULT, onFaultHttpService);
			httpService.addEventListener(ResultEvent.RESULT, onResultHttpService);
			httpService.send();
		}
		
		protected function onFaultHttpService(e:FaultEvent):void
		{
			Alert.show("Unable to load data/flexibleShareAirPods.xml.");
		}
		
        protected function onResultHttpService(e:ResultEvent):void
        {
            var viewXMLList:XMLList = e.result.view;
            var len:Number = viewXMLList.length();
            var containerWindowManagerHash:Object = new Object();
            for (var i:Number = 0; i < len; i++) // Loop through the view nodes.
            {
                // Create a canvas and mgr for each view node.
                var canvas:MDICanvas = new MDICanvas();	
                var manager:PodLayoutManager = new PodLayoutManager(canvas);
                canvas.windowManager = manager;
                
                canvas.label = viewXMLList[i].@label;
                canvas.percentWidth = 100;
                canvas.percentHeight = 100;
                canvas.windowManager.tilePadding = 10;
                
				//todo canvas.toolTip = viewXMLList[i].@toolTip;
				
                viewStack.addChild(canvas);
                
                // setup manager for view.
                manager.id = viewXMLList[i].@id;
                
                // todo: should listen to other events instead that mdimgr sends, layoutchangeevent no longer sent 				
                //todo manager.addEventListener(LayoutChangeEvent.UPDATE, StateManager.setPodLayout);
                
                // Store the pod xml data. Used when view is first made visible.
                podDataDictionary[manager] = viewXMLList[i].pod;
                podLayoutManagers.push(manager);
            }
            
            var index:Number = this.viewIndex;
            // Make sure the index is not out of range.
            // This can happen if a tab view was saved but then tabs were subsequently removed from the XML.
            index = Math.min(tabBar.numChildren - 1, index);
            onChangeTabBar(new IndexChangeEvent(IndexChangeEvent.CHANGE, false, false, -1, index));
            tabBar.selectedIndex = index;            
        }
		
        protected function onChangeTabBar(e:IndexChangeEvent):void
        {
            var index:Number = e.newIndex;
            viewIndex = index;
            
            viewStack.selectedIndex = index;
            
            // If data exists then add the pods. After the pods have been added the data is cleared.
            var podLayoutManager:PodLayoutManager = podLayoutManagers[index];
            if (podDataDictionary[podLayoutManager] != null)
            {
                addPods(podLayoutManagers[index]);
            }
        }
		
        protected function addPods(manager:PodLayoutManager):void
        {
            // Loop through the pod nodes for each view node.
            var podXMLList:XMLList = podDataDictionary[manager];
            
            numPodsDoneInView = 0;
            numPodsInView =  podXMLList.length();
            
            for (var i:Number = 0; i < numPodsInView; i++)
            {
                // load flex module for pod
                var info:IModuleInfo = ModuleManager.getModule(podXMLList[i].@module);
                _moduleConfigList[info] = podXMLList[i];
                _moduleLayoutMgrList[info] = manager;			
                info.addEventListener(ModuleEvent.READY, handleModuleReady);
                info.addEventListener(ModuleEvent.ERROR, handleModuleError);
                //info.load(null, null, null, moduleFactory);	
                info.load(new ApplicationDomain(ApplicationDomain.currentDomain));
            }
            
            // Delete the saved data.
            delete podDataDictionary[manager];			
        }
		
        private function handleModuleReady(event:ModuleEvent):void
        {
            var info:IModuleInfo = event.module;
            
			var pod:Pod = new Pod();

			//var podContent:IPodContentBase = info.factory.create() as IPodContentBase;					
            
            var module:ISASModule = info.factory.create() as ISASModule;
            //set the applicationContext property, inside the BasicSASModule this
            //will automatically be set as the moduleApplicationContext's parent
            module.applicationContext = _applicationContext;
            (module as Module).data = info;		
            var podContent:IPodContentBase = module as IPodContentBase;					

			podContent.pod = pod;
			
            var podConfig:XML = _moduleConfigList[info] as XML;
			podContent.properties = podConfig;
            
            var podId:String = podConfig.@id;            
            pod.id = podId;
            pod.title = podConfig.@title;
            
			var manager:PodLayoutManager = _moduleLayoutMgrList[info];			
			podContent.podManager = manager;

			pod.addElement(podContent);
            
            manager.addItemAt(pod, -1, false);						
            
            podHash[pod] = manager;		
            
			cleanupInfo(info);

			numPodsDoneInView++;
			
            if (numPodsDoneInView == numPodsInView)
            {
                // all pods complete so now the layout can be done correctly. 
                layoutAfterCreationComplete(manager);				
            }						
        }
        
        private function handleModuleError(event:ModuleEvent):void
		{
            Alert.show(event.errorText);
		}
		
        private function cleanupInfo(info:IModuleInfo):void 
        {
            delete _moduleConfigList[info];
            delete _moduleLayoutMgrList[info];
            info.removeEventListener(ModuleEvent.READY, handleModuleReady);
            info.removeEventListener(ModuleEvent.ERROR, handleModuleError);
        }
		
        // Pod has been created so update the respective PodLayoutManager.
        protected function layoutAfterCreationComplete(manager:PodLayoutManager):void
		{
            manager.removeNullItems();
            manager.tile(false, 10);
            manager.updateLayout(false);
		}
		
		// mdi
		protected function tile():void
		{
		    var index:int = viewStack.selectedIndex;
		    var mgr:PodLayoutManager = podLayoutManagers[index];
		    mgr.tile(false, 10);  
		}
        
        // mdi
        protected function cascade():void
        {
            var index:int = viewStack.selectedIndex;
            var mgr:PodLayoutManager = podLayoutManagers[index];
            mgr.cascade();   
        }
				
	}
}
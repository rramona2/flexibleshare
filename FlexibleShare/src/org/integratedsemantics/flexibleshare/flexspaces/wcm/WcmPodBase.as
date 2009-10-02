package org.integratedsemantics.flexibleshare.flexspaces.wcm
{
    import com.esria.samples.dashboard.view.PodContentBase;    
    import mx.events.FlexEvent;    
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.presmodel.main.FlexSpacesPresModel;


    public class WcmPodBase extends PodContentBase
    {
        [Bindable]
        protected var presModel:FlexSpacesPresModel;

        public var flexSpacesViewWcm:WcmView;
        
        
        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);

            flexSpacesViewWcm.flexSpacesPresModel.wcmMode = true;
            
            if (flexSpacesViewWcm.wcmBrowserView != null)
            {
                flexSpacesViewWcm.wcmBrowserView.viewActive(true);
            }            
        }
        
        public function WcmPodBase()
        {
            super();      
            
            var model:AppModelLocator = AppModelLocator.getInstance();         

            presModel = new FlexSpacesPresModel();

            presModel.showDocLib = false;
            presModel.showSearch = false;
            presModel.showTasks = false;
            presModel.showWCM = true;    
            presModel.showShare = false;        
            presModel.showHeader = false; 
        }         
        
    }
}
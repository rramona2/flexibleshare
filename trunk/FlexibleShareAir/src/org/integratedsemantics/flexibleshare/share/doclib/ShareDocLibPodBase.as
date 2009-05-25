package org.integratedsemantics.flexibleshare.share.doclib
{
    import com.esria.samples.dashboard.view.PodContentBase;
    import mx.events.FlexEvent;
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.presmodel.main.FlexSpacesPresModel;

    public class ShareDocLibPodBase extends PodContentBase
    {
        [Bindable]
        protected var presModel:FlexSpacesPresModel;

        [Bindable]
        protected var site:String;

        
        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);
            
            site = properties.@siteUrlName;    
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
        
    }
}
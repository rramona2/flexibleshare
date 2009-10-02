package org.integratedsemantics.flexibleshare.flexspaces.search
{
    import com.esria.samples.dashboard.view.PodContentBase;
    import mx.events.FlexEvent;
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.presmodel.main.FlexSpacesPresModel;

    public class SearchPodBase extends PodContentBase
    {
        [Bindable]
        protected var presModel:FlexSpacesPresModel;

        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);
            presModel.showHeader = true; 
        }
        
        public function SearchPodBase()
        {
            super();      
            
            var model:AppModelLocator = AppModelLocator.getInstance();         

            presModel = new FlexSpacesPresModel();

            presModel.showDocLib = false;
            presModel.showSearch = true;
            presModel.showTasks = false;
            presModel.showWCM = false;    
            presModel.showShare = false;        
            presModel.showHeader = true; 
            presModel.searchPanelPresModel.setupSubViews();             
        }         
        
    }
}
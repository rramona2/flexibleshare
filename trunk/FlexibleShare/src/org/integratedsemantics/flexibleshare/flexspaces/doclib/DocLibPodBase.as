package org.integratedsemantics.flexibleshare.flexspaces.doclib
{
    import com.esria.samples.dashboard.view.PodContentBase;
    import mx.events.FlexEvent;
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.presmodel.main.FlexSpacesPresModel;

    public class DocLibPodBase extends PodContentBase
    {
        [Bindable]
        protected var presModel:FlexSpacesPresModel;

        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);
        }
        
        public function DocLibPodBase()
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
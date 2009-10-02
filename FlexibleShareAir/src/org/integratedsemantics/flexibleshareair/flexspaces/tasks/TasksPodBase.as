package org.integratedsemantics.flexibleshareair.flexspaces.tasks
{
    import com.esria.samples.dashboard.view.PodContentBase;
    import mx.events.FlexEvent;
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.presmodel.main.FlexSpacesPresModel;

    public class TasksPodBase extends PodContentBase
    {
        [Bindable]
        protected var presModel:FlexSpacesPresModel;

        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);
        }
        
        public function TasksPodBase()
        {
            super();      
            
            var model:AppModelLocator = AppModelLocator.getInstance();         

            presModel = new FlexSpacesPresModel();

            presModel.showDocLib = false;
            presModel.showSearch = false;
            presModel.showTasks = true;
            presModel.showWCM = false;    
            presModel.showShare = false;        
            presModel.showHeader = false; 
        }         
        
    }
}
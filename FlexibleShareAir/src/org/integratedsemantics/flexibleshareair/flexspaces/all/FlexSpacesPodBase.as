package org.integratedsemantics.flexibleshareair.flexspaces.all
{
    import com.esria.samples.dashboard.view.PodContentBase;
    import mx.events.FlexEvent;
    import org.integratedsemantics.flexspaces.model.AppModelLocator;
    import org.integratedsemantics.flexspaces.presmodel.main.FlexSpacesPresModel;

    public class FlexSpacesPodBase extends PodContentBase
    {
        [Bindable]
        protected var presModel:FlexSpacesPresModel;

        override protected function onCreationComplete(e:FlexEvent):void
        {
            super.onCreationComplete(e);                                                                     
        }
        
        public function FlexSpacesPodBase()
        {
            super();      
            
            var model:AppModelLocator = AppModelLocator.getInstance();         

            // note: gets same presmodel that app class gets
            presModel = model.applicationContext.getObject("presModel");
            
            // hide logo row
            presModel.showHeader = false;
        }         
        
    }
}
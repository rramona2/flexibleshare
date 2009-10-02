package org.integratedsemantics.flexibleshare.share.discussions.edit
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.controls.TextInput;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    
    import org.integratedsemantics.flexibleshare.share.discussions.Topic;
    import org.integratedsemantics.flexibleshare.share.rte.RichTextEdit;
    import org.integratedsemantics.flexspaces.framework.presmodel.DialogViewBase;


    /**
     * Base class for edit discussion
     * 
     */
    public class EditTopicViewBase extends DialogViewBase
    {
        public var titleTextInput:TextInput;
        public var rte:RichTextEdit;
        
        public var onComplete:Function = null;
        
        public var topic:Topic;
        
        
        /**
         * Constructor
         * 
         */
        public function EditTopicViewBase()
        {
            super();
        }      
        
        /**
         * Handle view creation complete
         * 
         * @param creation complete event
         * 
         */
        override protected function onCreationComplete(event:FlexEvent):void
        {
            super.onCreationComplete(event);
            
            if (topic != null)
            {
                titleTextInput.text = topic.title;
            }
            
            if (topic != null)
            {                            
                var content:String = topic.content;
                rte.htmlText = content;                                           
            }      
        }
        
        /**
         * Set content of html control
         * 
         * @param content string to set content with
         * 
         */
        public function setContent(content:String):void
        {
            rte.htmlText =content;                       
        }
        
        /**
         * Handle ok buttion click
         * 
         * @param click event
         * 
         */
        override protected function onOkBtn(event:MouseEvent):void 
        {            
            var content:String = rte.htmlText;            
            
            var titleText:String = titleTextInput.text;
            
            if (topic != null)
            {
                topic.title = titleText;
                topic.content = content;                                
            }
                                    
            PopUpManager.removePopUp(this);

            if (onComplete != null)
            {
            	this.onComplete(topic);
            }
        }        
          
    }
}
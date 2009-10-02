package org.integratedsemantics.flexibleshare.share.wiki.create
{
    import flash.events.MouseEvent;
    
    import mx.controls.TextInput;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    
    import org.integratedsemantics.flexibleshare.share.rte.RichTextEdit;
    import org.integratedsemantics.flexibleshare.share.wiki.WikiPage;
    import org.integratedsemantics.flexspaces.framework.presmodel.DialogViewBase;


    /**
     * Base class for create wiki page
     * 
     */
    public class CreateWikiPageViewBase extends DialogViewBase
    {
        [Bindable]
        public var titleTextInput:TextInput;
        
        public var rte:RichTextEdit;
        
        public var onComplete:Function = null;
        
        public var wikiPage:WikiPage;
        
        
        /**
         * Constructor
         * 
         */
        public function CreateWikiPageViewBase()
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
        }

        /**
         * Set content of html control
         * 
         * @param content string to set content with
         * 
         */
        public function setContent(content:String):void
        {
            rte.htmlText = content;                       
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
            
            if (wikiPage != null)
            {
                wikiPage.title = titleText;
                wikiPage.content = content;                                
            }
                                    
            PopUpManager.removePopUp(this);

            if (onComplete != null)
            {
            	this.onComplete(wikiPage);
            }
        }        
          
    }
}
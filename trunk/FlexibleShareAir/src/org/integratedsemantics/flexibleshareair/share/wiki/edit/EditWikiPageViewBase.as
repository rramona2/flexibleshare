package org.integratedsemantics.flexibleshareair.share.wiki.edit
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filesystem.File;
    
    import mx.controls.HTML;
    import mx.controls.TextInput;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    
    import org.integratedsemantics.flexibleshare.share.wiki.WikiPage;
    import org.integratedsemantics.flexspaces.framework.presmodel.DialogViewBase;


    /**
     * Base class for edit wiki page
     * 
     */
    public class EditWikiPageViewBase extends DialogViewBase
    {
        public var titleTextInput:TextInput;
        public var htmlControl:HTML;
        
        public var onComplete:Function = null;
        
        public var wikiPage:WikiPage;
        
        
        /**
         * Constructor
         * 
         */
        public function EditWikiPageViewBase()
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
            
            if (wikiPage != null)
            {
                titleTextInput.text = wikiPage.title;
            }
            
            htmlControl.location =  File.applicationDirectory.resolvePath("web/create-html.html").nativePath;
            // need to add missing file protocol on mac needed on mac, leave alone on windows and linux
            if (htmlControl.location.indexOf(":") == -1)
            {
                htmlControl.location = "file://" + htmlControl.location;
            }
            htmlControl.addEventListener(Event.COMPLETE, delayedSetContent);                         
        }


        private function delayedSetContent(event:Event):void
        {
            htmlControl.removeEventListener(Event.COMPLETE, delayedSetContent);     
            if (wikiPage != null)
            {                            
                var content:String = wikiPage.content;
                htmlControl.htmlLoader.window.setContent(content);                                           
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
            var content:String = htmlControl.htmlLoader.window.setContent(content);                       
        }
        
        /**
         * Handle ok buttion click
         * 
         * @param click event
         * 
         */
        override protected function onOkBtn(event:MouseEvent):void 
        {            
            // from actionscript call javascript function
            var content:String = htmlControl.htmlLoader.window.getEditedContent();            
            
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
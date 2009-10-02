package org.integratedsemantics.flexibleshare.share.blog.create
{
    import flash.events.MouseEvent;
    
    import mx.controls.TextInput;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    
    import org.integratedsemantics.flexibleshare.share.blog.BlogPost;
    import org.integratedsemantics.flexibleshare.share.rte.RichTextEdit;
    import org.integratedsemantics.flexspaces.framework.presmodel.DialogViewBase;


    /**
     * Base class for create blog post
     * 
     */
    public class CreateBlogPostViewBase extends DialogViewBase
    {
        [Bindable]
        public var titleTextInput:TextInput;
        
        public var rte:RichTextEdit;
        
        public var onComplete:Function = null;
        
        public var blogPost:BlogPost;
        
        
        /**
         * Constructor
         * 
         */
        public function CreateBlogPostViewBase()
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
            
            if (blogPost != null)
            {
                blogPost.title = titleText;
                blogPost.content = content;                                
            }
                                    
            PopUpManager.removePopUp(this);

            if (onComplete != null)
            {
            	this.onComplete(blogPost);
            }
        }        
          
    }
}
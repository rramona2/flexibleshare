package org.integratedsemantics.flexibleshare.share.blog
{
	import mx.collections.ArrayCollection;
	
	import org.integratedsemantics.flexspaces.model.tree.TreeNode;
	
	public class BlogPost extends TreeNode
	{
		public var url:String;
		public var commentsUrl:String;
		
		public var title:String;
		
		public var content:String;
		
		public var publishExternPermissions:Boolean;
		
		public var commentCount:int;
		
		public var tags:ArrayCollection = new ArrayCollection();
		
		public var isDraft:Boolean = true;
		public var releasedOnDate:String;
		
		public var isUpdated:Boolean;
		public var updatedDate:String;
		
		public var isExternPublished:Boolean;
		public var externPublishedDate:String;
		public var externUpdateDate:String;
		public var externPostId:String;
		public var externPostLink:String;
		public var externOutOfDate:Boolean;

		public function BlogPost()
		{
			super("", "");
		}

	}
}
package org.integratedsemantics.flexibleshare.share.discussions
{
	import mx.collections.ArrayCollection;
	
	import org.integratedsemantics.flexspaces.model.tree.TreeNode;
	
	public class Topic extends TreeNode
	{
		public var url:String;
		public var commentsUrl:String;
		
		public var title:String;
		
		public var content:String;
		
		public var commentCount:int;
		
		public var tags:ArrayCollection = new ArrayCollection();
		

		public function Topic()
		{
			super("", "");
		}

	}
}
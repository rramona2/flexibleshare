/*
 * ============================================================================
 * GNU Lesser General Public License
 * ============================================================================
 *
 * JasperReports - Free Java report-generating library.
 * Copyright (C) 2001-2006 JasperSoft Corporation http://www.jaspersoft.com
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA.
 * 
 * JasperSoft Corporation
 * 303 Second Street, Suite 450 North
 * San Francisco, CA 94107
 * http://www.jaspersoft.com
 */

/*
 * Contributors:
 * Victor Kolesnikov - gladman4@gmail.com
 */

package net.sf.jasperreports.flex.model
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	

	public class Hyperlink
	{
		private var _type:String = HyperlinkTypeEnum.NONE;
		private var _target:String = HyperlinkTargetEnum.SELF;
		private var _anchorName:String;
		private var _reference:String;
		private var _anchor:String;
		private var _page:Number;
		private var _tooltip:String;
		private var _bookmarkLevel:Number = 0;
		//private var _parameters:Array;
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function set target(value:String):void 
		{
			_target = value;
		}
		
		public function set anchorName(value:String):void 
		{
			_anchorName = value;
			//FIXME viewer.setAnchorData(value, {page:Page.DEFAULT, verticalOffset:0/*TODO*/});
		}
		
		public function set reference(value:String):void 
		{
			_reference = value;
		}
		
		public function set anchor(value:String):void 
		{
			_anchor = value;
		}
		
		public function set page(value:Number):void 
		{
			_page = value;
		}
		
		public function set tooltip(value:String):void 
		{
			_tooltip = value;
		}
		
		public function set bookmarkLevel(value:Number):void 
		{
			_bookmarkLevel = value;
		}
		
//		public function set parameters(params:Array):void 
//		{
//			_parameters = params;
//		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get target():String 
		{
			return _target;
		}
		
		public function get anchorName():String 
		{
			return _anchorName;
		}
		
		public function get reference():String 
		{
			return _reference;
		}
		
		public function get anchor():String 
		{
			return _anchor;
		}
		
		public function get page():Number
		{
			return _page;
		}
		
		public function get toolTip():String 
		{
			if (_tooltip) 
			{
				return _tooltip;
			}
			switch (_type) 
			{
				case HyperlinkTypeEnum.LOCAL_ANCHOR:
					return "#" + _anchor;
					break;
				case HyperlinkTypeEnum.LOCAL_PAGE:
					return "Page " + _page;
					break;
				case HyperlinkTypeEnum.REFERENCE:
					return _reference;
					break;
				case HyperlinkTypeEnum.REMOTE_ANCHOR:
					return _reference + "#" + _anchor;
					break;
				case HyperlinkTypeEnum.REMOTE_PAGE:
					return _reference + ":Page " + _page;
					break;
				default:
					return _type;
			}
		}

		public function handler(event:MouseEvent):void //FIXME move this handler out of the model
		{
			switch (type) 
			{
//				case EHyperlinkType.LOCAL_ANCHOR:
//					var anchorData:Object = viewer.getAnchorData(link._hyperlinkAnchor);
//					viewer.showPage(anchorData.page);
//					viewer.verticalScrollPosition = anchorData.verticalOffset;
//					break;
//				case EHyperlinkType.LOCAL_PAGE:
//					viewer.showPageByNumber(int(link._hyperlinkPage) - 1);
//					break;
				case HyperlinkTypeEnum.REFERENCE:
					navigateToURL(
						new URLRequest(reference + (anchor ? "#" + anchor : "")), 
						'_' + target.toLowerCase()
						);
					break;
//				case EHyperlinkType.REMOTE_ANCHOR:
//					Alert.show(EHyperlinkType.REMOTE_ANCHOR + " -> " + link._hyperlinkReference + "#" + link._hyperlinkAnchor); // TODO
//					break;
//				case EHyperlinkType.REMOTE_PAGE:
//					Alert.show(EHyperlinkType.REMOTE_PAGE + " -> " + link._hyperlinkReference + "/Page#" + link._hyperlinkPage); // TODO
//					break;
				default:
					Alert.show("Custom Hyperlink Type: " + type);
			}
		}
//		private function hyperlinkHandler(event:MouseEvent):void {
//		var link:Object = event.currentTarget;
//		switch (link._hyperlinkType) {
//		case EHyperlinkType.LOCAL_ANCHOR:
//		var anchorData:Object = viewer.getAnchorData(link._hyperlinkAnchor);
//		viewer.showPage(anchorData.page);
//		viewer.verticalScrollPosition = anchorData.verticalOffset;
//		break;
//		case EHyperlinkType.LOCAL_PAGE:
//		viewer.showPageByNumber(int(link._hyperlinkPage) - 1);
//		break;
//		case EHyperlinkType.REFERENCE:
//		navigateToURL(new URLRequest(
//		link._hyperlinkReference + (link._hyperlinkAnchor ? "#" + link._hyperlinkAnchor : "")), 
//		'_' + link._hyperlinkTarget.toLowerCase());
//		break;
//		case EHyperlinkType.REMOTE_ANCHOR:
//		Alert.show(EHyperlinkType.REMOTE_ANCHOR + " -> " + link._hyperlinkReference + "#" + link._hyperlinkAnchor); // TODO
//		break;
//		case EHyperlinkType.REMOTE_PAGE:
//		Alert.show(EHyperlinkType.REMOTE_PAGE + " -> " + link._hyperlinkReference + "/Page#" + link._hyperlinkPage); // TODO
//		break;
//		default:
//		Alert.show("Custom Hyperlink Type: " + link._hyperlinkType);
//		}
//		}
	}

}

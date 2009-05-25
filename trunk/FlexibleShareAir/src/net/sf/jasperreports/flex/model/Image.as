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

	public class Image extends GraphicElement implements Alignment
	{
		private var _scaleImage:String;
		private var _horizontalAlign:String;
		private var _verticalAlign:String;
		private var _isLazy:Boolean = false;
		private var _onErrorType:String = OnErrorTypeEnum.ERROR;
		private var _source:String;
		private var _isEmbedded:Boolean = false;
		private var _box:Box = new Box(this as PenContainer);
		private var _hyperlink:Hyperlink;

		public function set scaleImage(value:String):void 
		{
			_scaleImage = value;
		}
		
		public function set horizontalAlign(value:String):void 
		{
			_horizontalAlign = value;
		}
		
		public function set verticalAlign(value:String):void 
		{
			_verticalAlign = value;
		}
		
		public function set isLazy(value:Boolean):void 
		{
			_isLazy = value;
		}
		
		public function set onErrorType(value:String):void 
		{
			_onErrorType = value;
		}
		
		public function set source(source:String):void 
		{
			_source = source;
		}
		
		public function set isEmbedded(embedded:Boolean):void 
		{
			_isEmbedded = embedded;
		}
		
		public function set hyperlink(value:Hyperlink):void 
		{
			_hyperlink = value;
		}
		
		public function get ownScaleImage():String 
		{
			return _scaleImage;
		}
		
		public function get scaleImage():String 
		{
			return StyleResolver.getScaleImage(this);
		}
		
		public function get ownHorizontalAlign():String 
		{
			return _horizontalAlign;
		}
		
		public function get horizontalAlign():String 
		{
			return StyleResolver.getHorizontalAlign(this, HorizontalAlignEnum.LEFT);
		}
		
		public function get ownVerticalAlign():String
		{
			return _verticalAlign;
		}
		
		public function get verticalAlign():String
		{
			return StyleResolver.getVerticalAlign(this, VerticalAlignEnum.TOP);
		}
		
		override public function get mode():String
		{
			return StyleResolver.getMode(this, ModeEnum.TRANSPARENT);
		}

		public function get source():String 
		{
			return _source;
		}
		
		public function get isEmbedded():Boolean 
		{
			return _isEmbedded;
		}

		public function get box():Box
		{
			return _box;
		}
		
		public function get hyperlink():Hyperlink
		{
			return _hyperlink;
		}

		override public function get defaultLineWidth():Number
		{
			return 0;
		}
	}

}

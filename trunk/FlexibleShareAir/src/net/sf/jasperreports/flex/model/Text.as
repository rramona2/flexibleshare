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
	

	public class Text extends Element implements Alignment, PenContainer
	{
		private var _content:String;
		private var _horizontalAlign:String;
		private var _verticalAlign:String;
		private var _rotation:String;
		private var _runDirection:String = RunDirectionEnum.LTR;
		private var _textHeight:Number = 0;
		private var _lineSpacing:String;
		private var _markup:String;
		private var _lineSpacingFactor:Number = 0;
		private var _leadingOffset:Number = 0;
		private var _valueClass:String;
		private var _pattern:String;
		private var _formatFactoryClass:String;
		private var _locale:String;
		private var _timezone:String;
		private var _box:Box = new Box(this as PenContainer);
		private var _font:Font = new Font(this as StyleContainer);
		private var _hyperlink:Hyperlink;
		
		public function set content(content:String):void 
		{
			_content = content;
		}

		public function set horizontalAlign(value:String):void 
		{
			_horizontalAlign = value;
		}
		
		public function set verticalAlign(value:String):void 
		{
			_verticalAlign = value;
		}
		
		public function set rotation(value:String):void 
		{
			_rotation = value;
		}
		
		public function set runDirection(value:String):void 
		{
			_runDirection = value;
		}
		
		public function set textHeight(value:Number):void 
		{
			_textHeight = value;
		}
		
		public function set lineSpacing(value:String):void 
		{
			_lineSpacing = value;
		}
		
		public function set markup(value:String):void 
		{
			_markup = value;
		}
		
		public function set lineSpacingFactor(value:Number):void 
		{
			_lineSpacingFactor = value;
		}
		
		public function set leadingOffset(value:Number):void 
		{
			_leadingOffset = value;
		}
		
		public function set valueClass(value:String):void 
		{
			_valueClass = value;
		}
		
		public function set pattern(value:String):void 
		{
			_pattern = value;
		}
		
		public function set formatFactoryClass(value:String):void 
		{
			_formatFactoryClass = value;
		}
		
		public function set locale(value:String):void 
		{
			_locale = value;
		}
		
		public function set timezone(value:String):void 
		{
			_timezone = value;
		}
		
		public function set hyperlink(value:Hyperlink):void 
		{
			_hyperlink = value;
		}
		
		override public function get mode():String
		{
			return StyleResolver.getMode(this, ModeEnum.TRANSPARENT);
		}

		public function get content():String
		{
			return _content;
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
		
		public function get ownRotation():String 
		{
			return _rotation;
		}
		
		public function get rotation():String 
		{
			return StyleResolver.getRotation(this);
		}
		
		public function get ownLineSpacing():String 
		{
			return _lineSpacing;
		}
		
		public function get lineSpacing():String 
		{
			return StyleResolver.getLineSpacing(this);
		}
		
		public function get ownMarkup():String 
		{
			return _markup;
		}
		
		public function get markup():String 
		{
			return StyleResolver.getMarkup(this);
		}
		
		public function get ownPattern():String 
		{
			return _pattern;
		}
		
		public function get pattern():String 
		{
			return StyleResolver.getPattern(this);
		}
		
		public function get runDirection():String
		{
			return _runDirection;
		}
		
		public function get textHeight():Number
		{
			return _textHeight;
		}
		
		public function get lineSpacingFactor():Number
		{
			return _lineSpacingFactor;
		}
		
		public function get leadingOffset():Number
		{
			return _leadingOffset;
		}
		
		public function get box():Box
		{
			return _box;
		}
		
		public function get font():Font
		{
			return _font;
		}

		public function get hyperlink():Hyperlink
		{
			return _hyperlink;
		}

		public function get defaultLineWidth():Number
		{
			return 0;
		}

		public function get defaultLineColor():Number
		{
			return this.forecolor;
		}

	}

}

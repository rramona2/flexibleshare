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

	public class Font
	{
		private var _container:StyleContainer;
		private var _reportFont:Style;
		private var _fontName:String;
		private var _fontSize:Number;
		private var _bold:BooleanEnum;
		private var _italic:BooleanEnum;
		private var _underline:BooleanEnum;
		private var _strikeThrough:BooleanEnum;
		
		public function Font(container:StyleContainer):void 
		{
			_container = container;
		}
		
		public function set reportFont(value:Style):void 
		{
			_reportFont = value;
		}
		
		public function set fontName(value:String):void 
		{
			_fontName = value;
		}
		
		public function set fontSize(value:Number):void 
		{
			_fontSize = value;
		}
		
		public function set bold(value:BooleanEnum):void 
		{
			_bold = value;
		}
		
		public function set italic(value:BooleanEnum):void 
		{
			_italic = value;
		}
		
		public function set underline(value:BooleanEnum):void 
		{
			_underline = value;
		}
		
		public function set strikeThrough(value:BooleanEnum):void 
		{
			_strikeThrough = value;
		}
		
		public function get styleContainer():StyleContainer
		{
			return _container;
		}
				
		public function get reportFont():Style 
		{
			return _reportFont;
		}
				
		public function get ownFontName():String 
		{
			return _fontName;
		}
		
		public function get fontName():String 
		{
			return StyleResolver.getFontName(this);
		}
		
		public function get ownFontSize():Number
		{
			return _fontSize;
		}
		
		public function get fontSize():Number 
		{
			return StyleResolver.getFontSize(this);
		}
		
		public function get ownBold():BooleanEnum 
		{
			return _bold;
		}
		
		public function get bold():BooleanEnum 
		{
			return StyleResolver.getBold(this);
		}
		
		public function get ownItalic():BooleanEnum 
		{
			return _italic;
		}
		
		public function get italic():BooleanEnum 
		{
			return StyleResolver.getItalic(this);
		}
		
		public function get ownUnderline():BooleanEnum 
		{
			return _underline;
		}
		
		public function get underline():BooleanEnum 
		{
			return StyleResolver.getUnderline(this);
		}
		
		public function get ownStrikeThrough():BooleanEnum 
		{
			return _strikeThrough;
		}
		
		public function get strikeThrough():BooleanEnum 
		{
			return StyleResolver.getStrikeThrough(this);
		}
	}

}

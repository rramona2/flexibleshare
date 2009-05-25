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

package net.sf.jasperreports.flex.xml
{
	import net.sf.jasperreports.flex.model.BooleanEnum;
	import net.sf.jasperreports.flex.model.Font;
	import net.sf.jasperreports.flex.model.Style;
	
	public class StyleFactory
	{
		private static var stylesMap:Object;
		private static var _defaultStyle:Style;
		private static var _defaultFont:Style;

		public static function reset():void
		{
			stylesMap = {};
			_defaultStyle = null;
			_defaultFont = null;
		}
		
		public static function styleByName(name:String):Style 
		{
			var style:Style = stylesMap[name];
			if (!style) 
			{
				throw new Error("Style \"" + name + "\" does not exist");
			}
			return style;
		}

		public static function get defaultStyle():Style
		{
			return _defaultStyle;
		}

		public static function get defaultFont():Style
		{
			return _defaultFont;
		}

		private static function addStyle(style:Style):void
		{
			stylesMap[style.name] = style;
			if (style.isDefault)
			{
				_defaultStyle = style;
			}
		}

		public static function addFont(style:Style):void
		{
			stylesMap[style.name] = style;
			if (style.isDefault)
			{
				_defaultFont = style;
			}
		}

		public static function createFont(xml:XML):Style 
		{
			var style:Style = new Style();
			
			setCommon(xml, style);
			
			addFont(style);
			
			return style;
		}

		public static function createStyle(xml:XML):Style 
		{
			var style:Style = new Style();
			
			setCommon(xml, style);
			
			if (xml.@style.length() > 0)
			{
				style.style = StyleFactory.styleByName(xml.@style);
			}

			if (xml.@mode.length() > 0)
			{
				style.mode = xml.@mode;
			}

			if (xml.@forecolor.length() > 0) 
			{
				style.forecolor = Style.color(xml.@forecolor);
			}

			if (xml.@backcolor.length() > 0) 
			{
				style.backcolor = Style.color(xml.@backcolor);
			}

			PenFactory.setPen(xml.pen[0], style.pen);
			BoxFactory.setBox(xml.box[0], style.box);

			addStyle(style);
			
			return style;
		}

		private static function setCommon(xml:XML, style:Style):void 
		{
			if (xml.@name.length() > 0)
			{
				style.name = xml.@name;
			}

			if (xml.@isDefault.length() > 0)
			{
				style.isDefault = xml.@isDefault == "true";
			}

			var font:Font = style.font;
			
			if (xml.@fontName.length() > 0)
			{
				font.fontName = xml.@fontName;
			}

			if (xml.@fontSize.length() > 0)
			{
				font.fontSize = Number(xml.@fontSize);
			}

			if (xml.@isBold.length() > 0)
			{
				font.bold = xml.@isBold == "true" ? BooleanEnum.TRUE : BooleanEnum.FALSE;
			}

			if (xml.@isItalic.length() > 0)
			{
				font.italic = xml.@isItalic == "true" ? BooleanEnum.TRUE : BooleanEnum.FALSE;
			}

			if (xml.@isUnderline.length() > 0)
			{
				font.underline = xml.@isUnderline == "true" ? BooleanEnum.TRUE : BooleanEnum.FALSE;
			}

			if (xml.@isStrikeThrough.length() > 0)
			{
				font.strikeThrough = xml.@isStrikeThrough == "true" ? BooleanEnum.TRUE : BooleanEnum.FALSE;
			}
		}
	}
}

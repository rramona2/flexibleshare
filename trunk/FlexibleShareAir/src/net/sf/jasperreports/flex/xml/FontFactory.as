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
	
	public class FontFactory
	{
		public static function setFont(xml:XML, font:Font):void 
		{
			if (xml)
			{
				if (xml.@reportFont.length() > 0)
				{
					font.reportFont = StyleFactory.styleByName(xml.@reportFont);
				}
				
				if (xml.@fontName.length() > 0)
				{
					font.fontName = xml.@fontName;
				}
	
				if (xml.@size.length() > 0)
				{
					font.fontSize = Number(xml.@size);
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

}

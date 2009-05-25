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
	import net.sf.jasperreports.flex.model.Hyperlink;
	import net.sf.jasperreports.flex.model.Text;
	
	public class HyperlinkFactory
	{
		public static function create(xml:XML):Hyperlink 
		{
			var hyperlink:Hyperlink = new Hyperlink();
			
			if (xml.@hyperlinkType.length() > 0)
			{
				hyperlink.type = xml.@hyperlinkType;
			}
			
			if (xml.@hyperlinkTarget.length() > 0)
			{
				hyperlink.target = xml.@hyperlinkTarget;
			}
			
			if (xml.@anchorName.length() > 0)
			{
				hyperlink.anchorName = xml.@anchorName;
			}
			
			if (xml.@hyperlinkReference.length() > 0)
			{
				hyperlink.reference = xml.@hyperlinkReference;
			}
			
			if (xml.@hyperlinkPage.length() > 0)
			{
				hyperlink.page = Number(xml.@hyperlinkPage);
			}
			
			if (xml.@hyperlinkTooltip.length() > 0)
			{
				hyperlink.tooltip = xml.@hyperlinkTooltip;
			}
			
			if (xml.@bookmarkLevel.length() > 0)
			{
				hyperlink.bookmarkLevel = Number(xml.@bookmarkLevel);
			}
			
			return hyperlink;
		}
	}

}

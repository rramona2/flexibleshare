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
	
	public class TextFactory
	{
		public static function create(xml:XML):Text 
		{
			var text:Text = new Text();
			
			ElementFactory.setElement(xml.reportElement[0], text);
			BoxFactory.setBox(xml.box[0], text.box);
			FontFactory.setFont(xml.font[0], text.font);
			
			if (xml.@hyperlinkType.length() > 0)
			{
				text.hyperlink = HyperlinkFactory.create(xml);
			}
			
			if (xml.@textAlignment.length() > 0)
			{
				text.horizontalAlign = xml.@textAlignment;
			}

			if (xml.@verticalAlignment.length() > 0)
			{
				text.verticalAlign = xml.@verticalAlignment;
			}
			
			if (xml.@rotation.length() > 0)
			{
				text.rotation = xml.@rotation;
			}

			if (xml.@runDirection.length() > 0)
			{
				text.runDirection = xml.@runDirection;
			}

			if (xml.@textHeight.length() > 0)
			{
				text.textHeight = Number(xml.@textHeight);
			}
			
			if (xml.@lineSpacing.length() > 0)
			{
				text.lineSpacing = xml.@lineSpacing;
			}

			if (xml.@lineSpacingFactor.length() > 0)
			{
				text.lineSpacingFactor = Number(xml.@lineSpacingFactor);
			}

			if (xml.@leadingOffset.length() > 0)
			{
				text.leadingOffset = Number(xml.@leadingOffset);
			}
			
			if (xml.@markup.length() > 0)
			{
				text.markup = xml.@markup;
			}
			
			text.content = xml.textContent[0].text();
			
			return text;
		}
	}

}

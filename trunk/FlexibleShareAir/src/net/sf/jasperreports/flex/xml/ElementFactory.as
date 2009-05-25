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
	import net.sf.jasperreports.flex.model.Element;
	import net.sf.jasperreports.flex.model.Style;
	
	public class ElementFactory
	{
		public static function setElement(xml:XML, element:Element):void 
		{
			if (xml)
			{
				if (xml.@x.length() > 0)
				{
					element.x = int(xml.@x);
				}
				else
				{
					throw new Error("Attribute 'x' not found for element.");
				}
	
				if (xml.@y.length() > 0)
				{
					element.y = int(xml.@y);
				}
				else
				{
					throw new Error("Attribute 'y' not found for element.");
				}
	
				if (xml.@width.length() > 0)
				{
					element.width = uint(xml.@width);
				}
				else
				{
					throw new Error("Attribute 'width' not found for element.");
				}
	
				if (xml.@height.length() > 0)
				{
					element.height = uint(xml.@height);
				}
				else
				{
					throw new Error("Attribute 'height' not found for element.");
				}

				if (xml.@style.length() > 0)
				{
					element.style = StyleFactory.styleByName(xml.@style);
				}
				if (xml.@key.length() > 0)
				{
					element.key = xml.@key;
				}
				
				if (xml.@mode.length() > 0)
				{
					element.mode = xml.@mode;
				}

				if (xml.@forecolor.length() > 0) 
				{
					element.forecolor = Style.color(xml.@forecolor);
				}

				if (xml.@backcolor.length() > 0) 
				{
					element.backcolor = Style.color(xml.@backcolor);
				}
			}
		}
	}

}

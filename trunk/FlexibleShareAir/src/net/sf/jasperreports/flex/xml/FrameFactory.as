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
	import net.sf.jasperreports.flex.model.Frame;

	public class FrameFactory
	{
		public static function create(xml:XML):Frame
		{
			var frame:Frame = new Frame();

			ElementFactory.setElement(xml.reportElement[0], frame);
			BoxFactory.setBox(xml.box[0], frame.box);

			addElementsToFrame(frame, xml);
			
			return frame;
		}

		public static function addElementsToFrame(frame:Frame, xml:XML):void
		{
			if (xml)
			{
				var xmlElements:XMLList = xml.children();
				for each (var xmlElement:XML in xmlElements)
				{
					var element:Element;
					switch (String(xmlElement.name())) {
					case "line":
						element = LineFactory.create(xmlElement);
						break;
					case "rectangle":
						element = RectangleFactory.create(xmlElement);
						break;
					case "ellipse":
						element = EllipseFactory.create(xmlElement);
						break;
					case "text":
						element = TextFactory.create(xmlElement);
						break;
					case "image":
						element = ImageFactory.create(xmlElement);
						break;
					case "frame":
						element = FrameFactory.create(xmlElement);
						break;
					}
					
					if (element)
					{
						frame.addElement(element);
					}
				}
			}
		}
	}

}

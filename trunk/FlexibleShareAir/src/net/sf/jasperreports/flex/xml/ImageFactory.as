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
	import net.sf.jasperreports.flex.model.Image;
	
	public class ImageFactory
	{
		public static function create(xml:XML):Image
		{
			var image:Image = new Image();
			
			ElementFactory.setElement(xml.reportElement[0], image);
			GraphicElementFactory.setGraphicElement(xml.graphicElement[0], image);
			BoxFactory.setBox(xml.box[0], image.box);
			
			if (xml.@hyperlinkType.length() > 0)
			{
				image.hyperlink = HyperlinkFactory.create(xml);
			}
			
			if (xml.@scaleImage.length() > 0)
			{
				image.scaleImage = xml.@scaleImage;
			}
			
			if (xml.@hAlign.length() > 0)
			{
				image.horizontalAlign = xml.@hAlign;
			}

			if (xml.@vAlign.length() > 0)
			{
				image.verticalAlign = xml.@vAlign;
			}
			
			if (xml.@onErrorType.length() > 0)
			{
				image.onErrorType = xml.@onErrorType;
			}
			
			var imageSourceXml:XML = xml.imageSource[0];
			image.source = imageSourceXml;
			if (imageSourceXml.@isEmbedded.length() > 0)
			{
				image.isEmbedded = imageSourceXml.@isEmbedded == "true";
			}
			
			return image;
		}
	}

}

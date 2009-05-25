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
	import net.sf.jasperreports.flex.model.Box;
	
	public class BoxFactory
	{
		public static function setBox(xml:XML, box:Box):void 
		{
			if (xml)
			{
				PenFactory.setPen(xml.pen[0], box.pen);
				PenFactory.setPen(xml.topPen[0], box.topPen);
				PenFactory.setPen(xml.leftPen[0], box.leftPen);
				PenFactory.setPen(xml.bottomPen[0], box.bottomPen);
				PenFactory.setPen(xml.rightPen[0], box.rightPen);

				if (xml.@padding.length() > 0)
				{
					box.padding = int(xml.@padding);
				}

				if (xml.@topPadding.length() > 0)
				{
					box.topPadding = int(xml.@topPadding);
				}

				if (xml.@leftPadding.length() > 0)
				{
					box.leftPadding = int(xml.@leftPadding);
				}

				if (xml.@bottomPadding.length() > 0)
				{
					box.bottomPadding = int(xml.@bottomPadding);
				}

				if (xml.@rightPadding.length() > 0)
				{
					box.rightPadding = int(xml.@rightPadding);
				}
			}
		}
	}

}

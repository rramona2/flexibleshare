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

package net.sf.jasperreports.flex.draw
{
	import flash.display.Graphics;
	
	import net.sf.jasperreports.flex.model.DirectionEnum;
	import net.sf.jasperreports.flex.model.Line;

	public class LineDrawer
	{
		public static function draw(context:DrawContext, line:Line):void 
		{
			var graphics:Graphics = context.graphics;
			var offsetX:int = context.xGraphicsOffset;
			var offsetY:int = context.yGraphicsOffset;
			
			if (line.pen.lineWidth > 0) 
			{
				var x1:Number = line.x + offsetX;
				var y1:Number = line.y + offsetY;
				var x2:Number = line.x + line.width + offsetX;
				var y2:Number = line.y + line.height + offsetY;

				if (line.direction === DirectionEnum.BOTTOM_UP)
				{
					var t:Number = y1;
					y1 = y2;
					y2 = t;
				}

				if (line.width == 1)
				{
					if (line.height == 1)
					{
						//nothing to draw
					}
					else
					{
						//vertical line
						x1 += 0.5;
						x2 += 0.5;
						DrawUtil.drawLine(graphics, x1, y1, x1, y2, line.pen);
					}
				}
				else
				{
					if (line.height == 1)
					{
						//horizontal line
						y1 += 0.5;
						y2 += 0.5;
						DrawUtil.drawLine(graphics, x1, y1, x2, y1, line.pen);
					}
					else
					{
						//oblique line
						DrawUtil.drawLine(graphics, x1, y1, x2, y2, line.pen);
					}
				}
			}
		}
	}

}

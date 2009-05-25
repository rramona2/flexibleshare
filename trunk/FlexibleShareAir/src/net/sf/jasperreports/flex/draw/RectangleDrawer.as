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
	
	import net.sf.jasperreports.flex.model.ModeEnum;
	import net.sf.jasperreports.flex.model.Rectangle;

	public class RectangleDrawer
	{
		public static function draw(context:DrawContext, rectangle:Rectangle):void 
		{
			var graphics:Graphics = context.graphics;
			var offsetX:int = context.xGraphicsOffset;
			var offsetY:int = context.yGraphicsOffset;
			
			if (!rectangle.radius || int(rectangle.radius) == 0) 
			{
				DrawUtil.drawBackground(context, rectangle);
				BoxDrawer.drawRectangle(context, rectangle, rectangle.pen);
			}
			else
			{
				if (rectangle.mode === ModeEnum.OPAQUE)// || rectangle.backcolor)
				{
					//fix for rendering bug of lines followed by filled shapes
					graphics.beginFill(0xFFFFFF, 0);
					graphics.lineStyle(0, 0xFFFFFF, 0);
					graphics.drawRect(0, 0, 0, 0);
					graphics.endFill();
					//end fix

					graphics.beginFill(rectangle.backcolor);
				}

				if (rectangle.pen.lineWidth > 0)
				{
					graphics.lineStyle(rectangle.pen.lineWidth, rectangle.pen.lineColor);
				}

				//FIXME dotted dashed double
				graphics.drawRoundRect(offsetX + rectangle.x, offsetY + rectangle.y, rectangle.width, rectangle.height, int(rectangle.radius));

				if (rectangle.mode === ModeEnum.OPAQUE)// || rectangle.backcolor)
				{
					graphics.endFill();
				}
			}
		}
	}

}

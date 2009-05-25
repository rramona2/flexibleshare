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
	
	import net.sf.jasperreports.flex.model.Box;
	import net.sf.jasperreports.flex.model.Element;
	import net.sf.jasperreports.flex.model.Pen;


	public class BoxDrawer
	{
		
		public static function drawRectangle(
			context:DrawContext, 
			element:Element, 
			pen:Pen):void
		{
			var graphics:Graphics = context.graphics;
			var offsetX:Number = context.xGraphicsOffset;
			var offsetY:Number = context.yGraphicsOffset;
			drawTopBorder(graphics, element, pen, pen, pen, offsetX, offsetY);
			drawLeftBorder(graphics, element, pen, pen, pen, offsetX, offsetY);
			drawBottomBorder(graphics, element, pen, pen, pen, offsetX, offsetY);
			drawRightBorder(graphics, element, pen, pen, pen, offsetX, offsetY);
		}

		public static function drawBox(
			context:DrawContext, 
			element:Element, 
			box:Box):void
		{
			var graphics:Graphics = context.graphics;
			var offsetX:Number = context.xGraphicsOffset;
			var offsetY:Number = context.yGraphicsOffset;
			drawTopBorder(graphics, element, box.topPen, box.leftPen, box.rightPen, offsetX, offsetY);
			drawLeftBorder(graphics, element, box.leftPen, box.topPen, box.bottomPen, offsetX, offsetY);
			drawBottomBorder(graphics, element, box.bottomPen, box.leftPen, box.rightPen, offsetX, offsetY);
			drawRightBorder(graphics, element, box.rightPen, box.topPen, box.bottomPen, offsetX, offsetY);
		}

		private static function drawTopBorder(
			graphics:Graphics, 
			element:Element, 
			topPen:Pen, 
			leftPen:Pen, 
			rightPen:Pen, 
			offsetX:Number,
			offsetY:Number):void
		{
			if (topPen.lineWidth > 0) 
			{
				var leftOffset:Number = DrawUtil.visibleLineWidth(leftPen) / 2;
				var rightOffset:Number = DrawUtil.visibleLineWidth(rightPen) / 2;

				//FIXME double borders meet at corners
//				if (topPen.lineStyle == LineStyleEnum.DOUBLE)
//				{
//				}
//				else
				{
					DrawUtil.drawLine(
						graphics, 
						element.x + offsetX - leftOffset, 
						element.y + offsetY,
						element.x + offsetX + element.width + rightOffset, 
						element.y + offsetY,
						topPen
						);
				}
			}

		}

		private static function drawLeftBorder(
			graphics:Graphics, 
			element:Element, 
			leftPen:Pen, 
			topPen:Pen, 
			bottomPen:Pen, 
			offsetX:Number,
			offsetY:Number):void
		{
			if (leftPen.lineWidth > 0) 
			{
				var topOffset:Number = DrawUtil.visibleLineWidth(topPen) / 2;
				var bottomOffset:Number = DrawUtil.visibleLineWidth(bottomPen) / 2;

//				if (leftPen.lineStyle == LineStyleEnum.DOUBLE)
//				{
//				}
//				else
				{
					DrawUtil.drawLine(
						graphics,
						element.x + offsetX, 
						element.y + offsetY - topOffset,
						element.x + offsetX, 
						element.y + offsetY + element.height + bottomOffset,
						leftPen
						);
				}
			}

		}

		private static function drawBottomBorder(
			graphics:Graphics, 
			element:Element, 
			bottomPen:Pen, 
			leftPen:Pen, 
			rightPen:Pen, 
			offsetX:Number,
			offsetY:Number):void
		{
			if (bottomPen.lineWidth > 0) 
			{
				var leftOffset:Number = DrawUtil.visibleLineWidth(leftPen) / 2;
				var rightOffset:Number = DrawUtil.visibleLineWidth(rightPen) / 2;

//				if (bottomPen.lineStyle == LineStyleEnum.DOUBLE)
//				{
//				}
//				else
				{
					DrawUtil.drawLine(
						graphics,
						element.x + offsetX - leftOffset, 
						element.y + offsetY + element.height,
						element.x + offsetX + element.width + rightOffset, 
						element.y + offsetY + element.height,
						bottomPen
						);
				}
			}

		}

		private static function drawRightBorder(
			graphics:Graphics, 
			element:Element, 
			rightPen:Pen, 
			topPen:Pen, 
			bottomPen:Pen, 
			offsetX:Number,
			offsetY:Number):void
		{
			if (rightPen.lineWidth > 0) 
			{
				var topOffset:Number = DrawUtil.visibleLineWidth(topPen) / 2;
				var bottomOffset:Number = DrawUtil.visibleLineWidth(bottomPen) / 2;

//				if (rightPen.lineStyle == LineStyleEnum.DOUBLE)
//				{
//				}
//				else
				{
					DrawUtil.drawLine(
						graphics,
						element.x + element.width + offsetX, 
						element.y + offsetY - topOffset,
						element.x + element.width + offsetX, 
						element.y + offsetY + element.height + bottomOffset,
						rightPen
						);
				}
			}

		}
	}

}

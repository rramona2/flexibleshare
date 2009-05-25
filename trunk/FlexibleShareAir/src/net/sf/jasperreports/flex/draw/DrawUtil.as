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
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	import net.sf.jasperreports.flex.model.Element;
	import net.sf.jasperreports.flex.model.LineStyleEnum;
	import net.sf.jasperreports.flex.model.ModeEnum;
	import net.sf.jasperreports.flex.model.Pen;
	
	public class DrawUtil
	{
		private static var MINIMUM_LINE_THICKNESS:Number = 0.1;
		
		public static function drawLine(
			graphics:Graphics, 
			x1:Number, 
			y1:Number, 
			x2:Number, 
			y2:Number, 
			pen:Pen):void 
		{
			switch (pen.lineStyle) 
			{
				case LineStyleEnum.DASHED:
					DrawUtil.drawDashedLine(graphics, x1, y1, x2, y2, pen);
					break;
				case LineStyleEnum.DOTTED:
					DrawUtil.drawDottedLine(graphics, x1, y1, x2, y2, pen);
					break;
				case LineStyleEnum.DOUBLE:
					DrawUtil.drawDoubleLine(graphics, x1, y1, x2, y2, pen);
					break;
				case LineStyleEnum.SOLID:
				default:
					DrawUtil.drawSolidLine(graphics, x1, y1, x2, y2, pen);
			}
		}

		public static function drawSolidLine(
			graphics:Graphics, 
			x1:Number, 
			y1:Number, 
			x2:Number, 
			y2:Number, 
			pen:Pen):void 
		{
			graphics.lineStyle(pen.lineWidth, pen.lineColor, 1.0, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
			graphics.moveTo(x1, y1);
			graphics.lineTo(x2, y2);
		}

		public static function drawDottedLine(
			graphics:Graphics, 
			x1:Number, 
			y1:Number, 
			x2:Number, 
			y2:Number, 
			pen:Pen):void 
		{
			var thickness:Number = roundLineWidth(pen.lineWidth);
			var dashUnit:Number = thickness == 0 ? MINIMUM_LINE_THICKNESS : thickness;
			drawDashedLine(graphics, x1, y1, x2, y2, pen, dashUnit, dashUnit);
		}

		public static function drawDashedLine(
			graphics:Graphics, 
			x1:Number, 
			y1:Number, 
			x2:Number, 
			y2:Number, 
			pen:Pen, 
			signal:Number = -1, 
			pause:Number = -1):void 
		{
			if (x2 < x1) 
			{
				throw new Error("X2 must be > X1");
			}
			
			var thickness:Number = roundLineWidth(pen.lineWidth);
			var dashUnit:Number = thickness == 0 ? MINIMUM_LINE_THICKNESS : thickness;
			
			signal = signal < 0 ? dashUnit * 5 : signal;
			pause = pause < 0 ? dashUnit * 3 : pause;
			
			var lineLen:Number = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
			var len:Number = 0;
			var alpha:Number = Math.asin((y2 - y1) / lineLen);
			var dash:Boolean = true;
			
			graphics.lineStyle(thickness, pen.lineColor, 1.0, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
			graphics.moveTo(x1, y1);
			
			while (len < lineLen) 
			{
				if (dash) 
				{
					len += signal;// - thickness;
					if (len > lineLen) 
					{
						len = lineLen;
					}
					graphics.lineTo(x1 + len * Math.cos(alpha), y1 + len * Math.sin(alpha));
				}
				else 
				{
					len += pause;// + thickness;
					graphics.moveTo(x1 + len * Math.cos(alpha), y1 + len * Math.sin(alpha));
				}
				dash = !dash;
			}
		}
		
		public static function drawDoubleLine(
			graphics:Graphics, 
			x1:Number, 
			y1:Number, 
			x2:Number, 
			y2:Number, 
			pen:Pen):void 
		{
			if (x2 < x1) 
			{
				throw new Error("X2 must be > X1");
			}
			
			var lineLen:Number = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
			var alpha:Number = Math.asin((y2 - y1) / lineLen);
			
			var thickness:Number = roundLineWidth(pen.lineWidth / 3);
			thickness = thickness == 0 ? MINIMUM_LINE_THICKNESS : thickness;
			
			graphics.lineStyle(thickness, pen.lineColor, 1.0, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
			var x:Number = x1 + thickness * Math.sin(alpha);
			var y:Number = y1 - thickness * Math.cos(alpha);
			graphics.moveTo(x, y);
			graphics.lineTo(x + lineLen * Math.cos(alpha), y + lineLen * Math.sin(alpha));
			x = x1 - thickness * Math.sin(alpha);
			y = y1 + thickness * Math.cos(alpha);
			graphics.moveTo(x, y);
			graphics.lineTo(x + lineLen * Math.cos(alpha), y + lineLen * Math.sin(alpha));
		}
		
		public static function drawBackground(
			context:DrawContext, 
			element:Element):void
		{
			var graphics:Graphics = context.graphics;
			if (element.mode === ModeEnum.OPAQUE)// || image.backcolor)
			{
				//fix for rendering bug of lines followed filled shapes
				graphics.beginFill(0xFFFFFF, 0);
				graphics.lineStyle(0, 0xFFFFFF, 0);
				graphics.drawRect(0, 0, 0, 0);
				graphics.endFill();
				//end fix

				graphics.beginFill(element.backcolor);
				graphics.lineStyle(0, element.backcolor);
				graphics.drawRect(context.xGraphicsOffset + element.x, context.yGraphicsOffset + element.y, element.width, element.height);
				graphics.endFill();
			}
		}

		public static function visibleLineWidth(pen:Pen):Number
		{
			if (pen.lineStyle == LineStyleEnum.DOUBLE)
			{
				var thickness:Number = roundLineWidth(pen.lineWidth / 3);
				thickness = thickness == 0 ? MINIMUM_LINE_THICKNESS : thickness;
				return 3 * thickness;
			}
			return -Math.round(-pen.lineWidth);
		}

		public static function roundLineWidth(lineWidth:Number):Number
		{
			return -Math.round(-lineWidth);
		}
	}

}
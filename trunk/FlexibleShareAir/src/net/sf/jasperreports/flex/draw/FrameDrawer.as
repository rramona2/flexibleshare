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
	import net.sf.jasperreports.flex.model.Element;
	import net.sf.jasperreports.flex.model.Ellipse;
	import net.sf.jasperreports.flex.model.Frame;
	import net.sf.jasperreports.flex.model.Image;
	import net.sf.jasperreports.flex.model.Line;
	import net.sf.jasperreports.flex.model.Rectangle;
	import net.sf.jasperreports.flex.model.Text;

	public class FrameDrawer
	{
		public static function draw(context:DrawContext, frame:Frame):void 
		{
			DrawUtil.drawBackground(context, frame);
			BoxDrawer.drawBox(context, frame, frame.box);

			context.xCanvasOffset += frame.x;
			context.yCanvasOffset += frame.y;
			context.xGraphicsOffset += frame.x;
			context.yGraphicsOffset += frame.y;
			
			for each(var element:Element in frame.elements)
			{
				if (element is Line)
				{
					LineDrawer.draw(context, element as Line);
				}
				else if (element is Rectangle)
				{
					RectangleDrawer.draw(context, element as Rectangle);
				}
				else if (element is Ellipse)
				{
					EllipseDrawer.draw(context, element as Ellipse);
				}
				else if (element is Text)
				{
					TextDrawer.draw(context, element as Text);
				}
				else if (element is Image)
				{
					ImageDrawer.draw(context, element as Image);
				}
				else if (element is Frame)
				{
					FrameDrawer.draw(context, element as Frame);
				}
			}

			context.xCanvasOffset -= frame.x;
			context.yCanvasOffset -= frame.y;
			context.xGraphicsOffset -= frame.x;
			context.yGraphicsOffset -= frame.y;
		}
	}

}

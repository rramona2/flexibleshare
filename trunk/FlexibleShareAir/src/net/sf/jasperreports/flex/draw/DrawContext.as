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
	
	import mx.containers.Canvas;

	public class DrawContext
	{
		private var _canvas:Canvas;
		private var _xCanvasOffset:int = 0;
		private var _yCanvasOffset:int = 0;
		private var _graphics:Graphics;
		private var _xGraphicsOffset:int = 0;
		private var _yGraphicsOffset:int = 0;
		
		public function DrawContext(canvas:Canvas)
		{
			_canvas = canvas;
		}
		
		public function get canvas():Canvas
		{
			return _canvas;
		}
		
		public function get xCanvasOffset():int
		{
			return _xCanvasOffset;
		}
		
		public function get yCanvasOffset():int
		{
			return _yCanvasOffset;
		}
		
		public function get graphics():Graphics
		{
			if (!_graphics)
			{
				return canvas.graphics;
			}
			return _graphics;
		}
		
		public function get xGraphicsOffset():int
		{
			return _xGraphicsOffset;
		}
		
		public function get yGraphicsOffset():int
		{
			return _yGraphicsOffset;
		}
		
		public function set xCanvasOffset(xCanvaaOffset:int):void
		{
			_xCanvasOffset = xCanvaaOffset;
		}
		
		public function set yCanvasOffset(yCanvasOffset:int):void
		{
			_yCanvasOffset = yCanvasOffset;
		}

		public function set graphics(graphics:Graphics):void
		{
			_graphics = graphics;
		}
		
		public function set xGraphicsOffset(xGraphicsOffset:int):void
		{
			_xGraphicsOffset = xGraphicsOffset;
		}
		
		public function set yGraphicsOffset(yGraphicsOffset:int):void
		{
			_yGraphicsOffset = yGraphicsOffset;
		}
	}

}

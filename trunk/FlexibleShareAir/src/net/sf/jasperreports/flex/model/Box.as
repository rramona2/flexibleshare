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

package net.sf.jasperreports.flex.model
{
	import net.sf.jasperreports.flex.model.ModeEnum;

	public class Box
	{
		private var _container:PenContainer;
		private var _pen:Pen;
		private var _topPen:Pen;
		private var _leftPen:Pen;
		private var _bottomPen:Pen;
		private var _rightPen:Pen;
		
		private var _padding:Number;
		private var _topPadding:Number;
		private var _leftPadding:Number;
		private var _bottomPadding:Number;
		private var _rightPadding:Number;

		public function Box(container:PenContainer):void 
		{
			_container = container;
			_pen = new BoxPen(this as Box, _container);
			_topPen = new BoxTopPen(this as Box, _container);
			_leftPen = new BoxLeftPen(this as Box, _container);
			_bottomPen = new BoxBottomPen(this as Box, _container);
			_rightPen = new BoxRightPen(this as Box, _container);
		}
		
		public function get penContainer():PenContainer
		{
			return _container;
		}
		
		public function get pen():Pen
		{
			return _pen;
		}
		
		public function get topPen():Pen
		{
			return _topPen;
		}
		
		public function get leftPen():Pen
		{
			return _leftPen;
		}
		
		public function get bottomPen():Pen
		{
			return _bottomPen;
		}
		
		public function get rightPen():Pen
		{
			return _rightPen;
		}
		
		public function get ownPadding():Number
		{
			return _padding;
		}
		
		public function get padding():Number
		{
			return StyleResolver.getPadding(this);
		}
		
		public function set padding(padding:Number):void
		{
			_padding = padding;
		}
		
		public function get ownTopPadding():Number
		{
			return _topPadding;
		}
		
		public function get topPadding():Number
		{
			return StyleResolver.getTopPadding(this);
		}
		
		public function set topPadding(padding:Number):void
		{
			_topPadding = padding;
		}
		
		public function get ownLeftPadding():Number
		{
			return _leftPadding;
		}
		
		public function get leftPadding():Number
		{
			return StyleResolver.getLeftPadding(this);
		}
		
		public function set leftPadding(padding:Number):void
		{
			_leftPadding = padding;
		}
		
		public function get ownBottomPadding():Number
		{
			return _bottomPadding;
		}
		
		public function get bottomPadding():Number
		{
			return StyleResolver.getBottomPadding(this);
		}
		
		public function set bottomPadding(padding:Number):void
		{
			_bottomPadding = padding;
		}
		
		public function get ownRightPadding():Number
		{
			return _rightPadding;
		}
		
		public function get rightPadding():Number
		{
			return StyleResolver.getRightPadding(this);
		}
		
		public function set rightPadding(padding:Number):void
		{
			_rightPadding = padding;
		}
		
		public function get defaultLineWidth():Number
		{
			return 0;
		}
		
		public function get defaultLineColor():Number
		{
			return 0x000000;
		}
	}

}

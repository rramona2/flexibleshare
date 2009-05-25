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

	public class Pen
	{
		protected var _container:PenContainer;
		protected var _lineWidth:Number;
		protected var _lineStyle:String;
		protected var _lineColor:Number;

		public function Pen(container:PenContainer):void 
		{
			_container = container;
		}
		
		public function get penContainer():PenContainer
		{
			return _container;
		}
		
		public function set lineWidth(value:Number):void 
		{
			_lineWidth = value;
		}
		
		public function set lineStyle(value:String):void 
		{
			_lineStyle = value;
		}
		
		public function set lineColor(value:Number):void 
		{
			_lineColor = value;
		}
		
		public function get ownLineWidth():Number 
		{
			return _lineWidth;
		}
		
		public function get lineWidth():Number 
		{
			return StyleResolver.getLineWidth(this, _container.defaultLineWidth);
		}
		
		public function get ownLineStyle():String 
		{
			return _lineStyle;
		}
		
		public function get lineStyle():String 
		{
			return StyleResolver.getLineStyle(this);
		}
		
		public function get ownLineColor():Number 
		{
			return _lineColor;
		}
		
		public function get lineColor():Number 
		{
			return StyleResolver.getLineColor(this, _container.defaultLineColor);
		}
	}

}

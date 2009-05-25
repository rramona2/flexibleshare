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

	public class Element implements StyleContainer
	{
		private var _key:String;
		private var _style:Style;
		private var _mode:String;
		private var _x:Number;//FIXME make these int?
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _forecolor:Number;
		private var _backcolor:Number;
		
		public function set key(value:String):void
		{
			_key = value;
		}
		
		public function set style(value:Style):void 
		{
			_style = value;
		}
		
		public function set mode(value:String):void 
		{
			_mode = value;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		public function set forecolor(value:Number):void 
		{
			_forecolor = value;
		}
		
		public function set backcolor(value:Number):void 
		{
			_backcolor = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function get style():Style
		{
			return _style;
		}
		
		public function get ownMode():String 
		{
			return _mode;
		}
		
		public function get mode():String 
		{
			return StyleResolver.getMode(this, ModeEnum.OPAQUE);
		}
		
		public function get ownForecolor():Number 
		{
			return _forecolor;
		}
		
		public function get forecolor():Number 
		{
			return StyleResolver.getForecolor(this);
		}
		
		public function get ownBackcolor():Number 
		{
			return _backcolor;
		}
		
		public function get backcolor():Number 
		{
			return StyleResolver.getBackcolor(this);
		}
	}

}

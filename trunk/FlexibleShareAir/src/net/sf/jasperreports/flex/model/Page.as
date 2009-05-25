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
	import mx.collections.IList;
	

	public class Page
	{
		private static var _defaultStyle:Style;
		private static var _defaultFont:Style;
		private var _frame:Frame;
		
		public function Page()
		{
			_frame = new Frame();
			_frame.mode = ModeEnum.TRANSPARENT;
			_frame.x = 0;
			_frame.y = 0;
			_frame.width = 0;//FIXME set these from XML
			_frame.height = 0;
			_frame.box.pen.lineWidth = 0;
		}
		
		public static function set defaultStyle(style:Style):void 
		{
			_defaultStyle = style;
		}

		public static function set defaultFont(style:Style):void 
		{
			_defaultFont = style;
		}

		public static function get defaultStyle():Style 
		{
			return _defaultStyle;
		}

		public static function get defaultFont():Style 
		{
			return _defaultFont;
		}

		public function get frame():Frame
		{
			return _frame;
		}
	}

}

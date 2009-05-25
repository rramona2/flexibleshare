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
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	

	public class Frame extends Element implements PenContainer
	{
		private var _box:Box = new Box(this as PenContainer);
		private var _elements:IList = new ArrayCollection();
		
		public function addElement(element:Element):void 
		{
			_elements.addItem(element);
		}

		public function get elements():IList
		{
			return _elements;
		}

		override public function get mode():String
		{
			return StyleResolver.getMode(this, ModeEnum.TRANSPARENT);
		}

		public function get box():Box
		{
			return _box;
		}

		public function get defaultLineWidth():Number
		{
			return 0;
		}

		public function get defaultLineColor():Number
		{
			return this.forecolor;
		}
	}

}

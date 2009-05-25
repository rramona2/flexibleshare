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

package net.sf.jasperreports.flex.draw
{
	import flash.display.Loader;
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	
	import net.sf.jasperreports.flex.model.Image;

	public class ImageHandler
	{
		private var component:UIComponent;
		private var loader:Loader;
		private var image:Image;
		
		public function ImageHandler(component:UIComponent, loader:Loader, image:Image)
		{
			this.component = component;
			this.loader = loader;
			this.image = image;
		}
		
		public function handleError(event:Event):void 
		{
			this.loader = loader;
//			var noImage:* = new Images.NO_IMAGE;
//			noImage.x = noImage.y = 0;
//			noImage.smoothing = true;
//			addChild(noImage);
		}

		public function handleComplete(event:Event):void 
		{
			ImageDrawer.drawLoader(component, loader, image);
		}
	}

}

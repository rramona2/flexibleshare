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
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.utils.Base64Decoder;
	
	import net.sf.jasperreports.flex.model.HorizontalAlignEnum;
	import net.sf.jasperreports.flex.model.HyperlinkTypeEnum;
	import net.sf.jasperreports.flex.model.Image;
	import net.sf.jasperreports.flex.model.ScaleImageEnum;
	import net.sf.jasperreports.flex.model.VerticalAlignEnum;

	public class ImageDrawer
	{
		public static function draw(context:DrawContext, image:Image):void 
		{
			//var canvas:Canvas = context.canvas;
			//var offsetX:int = context.xGraphicsOffset;
			//var offsetY:int = context.yGraphicsOffset;
			
			var imageComponent:UIComponent = new UIComponent();

			imageComponent.x = context.xCanvasOffset + image.x;
			imageComponent.y = context.yCanvasOffset + image.y;
			imageComponent.width = image.width;
			imageComponent.height = image.height;

			var borderComponent:UIComponent = new UIComponent();
			borderComponent.x = imageComponent.x;
			borderComponent.y = imageComponent.y;
			borderComponent.width = imageComponent.width;
			borderComponent.height = imageComponent.height;

			context.graphics = imageComponent.graphics;

			context.xGraphicsOffset = context.xCanvasOffset - imageComponent.x;
			context.yGraphicsOffset = context.yCanvasOffset - imageComponent.y;

			DrawUtil.drawBackground(context, image);

			context.graphics = borderComponent.graphics;

			BoxDrawer.drawBox(context, image, image.box);
			
			var loader:Loader = new Loader();
			var imageHandler:ImageHandler = new ImageHandler(imageComponent, loader, image);
            
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageHandler.handleError);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageHandler.handleComplete);
			
			if (image.isEmbedded) 
			{
				var decoder:Base64Decoder = new Base64Decoder();
				decoder.decode(image.source);
				loader.loadBytes(decoder.drain());
			}
			else
			{
				try 
				{
					loader.load(new URLRequest(image.source));
				}
				catch (e:SecurityError) 
				{
//					var noImage:* = new Images.NO_IMAGE;
//					noImage.x = noImage.y = 0;
//					noImage.smoothing = true;
//					canvas.addChild(noImage);
				}
			}

			imageComponent.addChild(loader);

			if (image.hyperlink && image.hyperlink.type !== HyperlinkTypeEnum.NONE)
			{
				imageComponent.mouseEnabled = true;
				imageComponent.buttonMode = true;
				imageComponent.useHandCursor = true;
				//imageComponent.mouseChildren = false;
				imageComponent.toolTip = image.hyperlink.toolTip;
				imageComponent.addEventListener(MouseEvent.MOUSE_DOWN, image.hyperlink.handler);
			}

			context.canvas.addChild(imageComponent);
			context.canvas.addChild(borderComponent);
		}

		public static function drawLoader(component:UIComponent, loader:Loader, image:Image):void 
		{
        	var leftPad:int = image.box.leftPadding;
        	var rightPad:int = image.box.rightPadding;
        	var topPad:int = image.box.topPadding;
        	var bottomPad:int = image.box.bottomPadding;
			var availableWidth:int = image.width - leftPad - rightPad;
			availableWidth = availableWidth < 0 ? 0 : availableWidth;
			var availableHeight:int = image.height - topPad - bottomPad;
			availableHeight = availableHeight < 0 ? 0 : availableHeight;
			var xalignFactor:Number = 0;
			switch (image.horizontalAlign) {
			case HorizontalAlignEnum.CENTER:
				xalignFactor = .5;
				break
			case HorizontalAlignEnum.RIGHT:
				xalignFactor = 1;
				break
			}
			var yalignFactor:Number = 0;
			switch (image.verticalAlign) {
			case VerticalAlignEnum.MIDDLE:
				yalignFactor = .5;
				break
			case VerticalAlignEnum.BOTTOM:
				yalignFactor = 1;
				break
			}
			switch (image.scaleImage) {
			case ScaleImageEnum.CLIP:
				loader.x = leftPad + xalignFactor * (availableWidth - loader.width);
				loader.y = topPad + yalignFactor * (availableHeight - loader.height);
				var mask:Sprite = new Sprite();
				mask.graphics.beginFill(0x000001);
				mask.graphics.drawRect(leftPad, topPad, availableWidth, availableHeight);
				//FIXME chec kthis mask.graphics.endFill();
				component.addChild(mask);
				loader.mask = mask;
				break;
			case ScaleImageEnum.FILL_FRAME:
				loader.x = leftPad;
				loader.y = topPad;
				loader.width = availableWidth;
				loader.height = availableHeight;
				break;
			case ScaleImageEnum.RETAIN_SHAPE:
				var hScale:Number = availableWidth / loader.width;
				var vScale:Number = availableHeight / loader.height;
				var scale:Number = Math.min(hScale, vScale);
				loader.width = loader.width * scale;
				loader.height = loader.height * scale;
				loader.x = leftPad + xalignFactor * (availableWidth - loader.width);
				loader.y = topPad + yalignFactor * (availableHeight - loader.height);
				break;
			}
			(loader.content as Bitmap).smoothing = true;
		}
	}

}

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
	import flash.events.MouseEvent;
	import flash.text.FontStyle;
	import flash.text.TextFormat;
	
	import mx.controls.Text;
	import mx.core.Application;
	import mx.utils.StringUtil;
	
	import net.sf.jasperreports.flex.model.Font;
	import net.sf.jasperreports.flex.model.BooleanEnum;
	import net.sf.jasperreports.flex.model.HorizontalAlignEnum;
	import net.sf.jasperreports.flex.model.HyperlinkTypeEnum;
	import net.sf.jasperreports.flex.model.MarkupEnum;
	import net.sf.jasperreports.flex.model.RotationEnum;
	import net.sf.jasperreports.flex.model.VerticalAlignEnum;
	import net.sf.jasperreports.flex.model.Text;


	public class TextDrawer
	{
		private static var TX_CTRL_MARGIN_TOP:int = 2;
		private static var TX_CTRL_MARGIN_LEFT:int = 2;
		private static var TX_CTRL_MARGIN_BOTTOM:int = 4;
		private static var TX_CTRL_MARGIN_RIGHT:int = 4;
		
		public static function draw(context:DrawContext, textElement:net.sf.jasperreports.flex.model.Text):void 
		{
			//var canvas:Canvas = context.canvas;
			//var offsetX:int = context.offsetX;
			//var offsetY:int = context.offsetY
			
			var textControl:mx.controls.Text = new mx.controls.Text();

			textControl.x = context.xCanvasOffset + textElement.x - TX_CTRL_MARGIN_LEFT;
			textControl.y = context.yCanvasOffset + textElement.y - TX_CTRL_MARGIN_TOP;
			textControl.width = textElement.width + TX_CTRL_MARGIN_LEFT + TX_CTRL_MARGIN_RIGHT;
			textControl.height = textElement.height + TX_CTRL_MARGIN_TOP + TX_CTRL_MARGIN_BOTTOM;

			context.graphics = textControl.graphics;

			context.xGraphicsOffset = context.xCanvasOffset - textControl.x;
			context.yGraphicsOffset = context.yCanvasOffset - textControl.y;

			DrawUtil.drawBackground(context, textElement);
			BoxDrawer.drawBox(context, textElement, textElement.box);//FIXME border is under text; see the images

			if (!textElement.content || StringUtil.trim(textElement.content).length == 0)//FIXME check this
			{
				return;
			}

			var font:Font = textElement.font;
			var textFormat:TextFormat = new TextFormat();

			textControl.mouseEnabled = false;
			textControl.selectable = false;
			textControl.setStyle("color", textElement.forecolor);

			var fontFamily:String = convertToFlexFontName(font.fontName);
			textControl.setStyle("fontFamily", fontFamily);
			textControl.setStyle("fontSize", font.fontSize);//FIXME * 0.9
			
			if (!Application.application.systemManager.isFontFaceEmbedded(textFormat)) 
			{
				if (font.italic.booleanValue) 
				{
					textControl.setStyle("fontStyle", FontStyle.ITALIC);
				}
				if (font.bold.booleanValue) 
				{
					textControl.setStyle("fontWeight", FontStyle.BOLD);
				}
			}
			
			if (font.underline.booleanValue) 
			{
				textControl.setStyle("textDecoration", "underline");
			}
			
			if (font.strikeThrough.booleanValue) 
			{
				textControl.setStyle("textDecoration", "underline"); // FIXME StrikeThrough Style
			}
			
			if (textElement.horizontalAlign && textElement.horizontalAlign !== HorizontalAlignEnum.JUSTIFIED) 
			{ // FIXME Justified
				textControl.setStyle("textAlign", textElement.horizontalAlign.toLowerCase());
			}
			
			textControl.setStyle("leading", 0);
			
			if (textElement.markup != null && textElement.markup != MarkupEnum.NONE)// FIXME Styled Text
			{
				XML.ignoreWhitespace = false;
				var xList:XMLList = new XMLList(textElement.content);
				XML.ignoreWhitespace = true;
				// XML.prettyIndent = 0;
				XML.prettyPrinting = false;
				var content:String = "";
				for each (var item:XML in xList)
				{
					var qName:QName = item.name();
					if (qName && qName.localName == "style")
					{
						item.setName("font");
						var attr:XMLList = item.@forecolor;
						if (attr.length() > 0) {
							attr[0].setName("color");
						}
						attr = item.@fontName;
						if (attr.length() > 0) {
							attr[0].setName("face");
						}
						var itemText:String = encode(String(item));
						trace(itemText);
						attr = item.@isBold;
						if (attr.length() > 0 && attr[0] == BooleanEnum.TRUE) {
							itemText = "<b>" + itemText + "</b>";
							var xml:XML = new XML(itemText);
							item.setChildren(xml);
						}
						attr = item.@isItalic;
						if (attr.length() > 0 && attr[0] == BooleanEnum.TRUE) {
							itemText = "<i>" + itemText + "</i>";
							xml = new XML(itemText);
							item.setChildren(xml);
						}
						attr = item.@isUnderline;
						if (attr.length() > 0 && attr[0] == BooleanEnum.TRUE) {
							itemText = "<u>" + itemText + "</u>";
							xml = new XML(itemText);
							item.setChildren(xml);
						}
						attr = item.@isStrikeThrough;
						if (attr.length() > 0 && attr[0] == BooleanEnum.TRUE) {
							itemText = "<u>" + itemText + "</u>";
							xml = new XML(itemText);
							item.setChildren(xml);
						}
					}
					content += item.nodeKind() == "text" ? encode(item.toString()) : item.toXMLString();
				}
				textControl.htmlText = content;
				XML.prettyPrinting = true;
			}
			else
			{
				textControl.text = textElement.content;
			}
	        	
			var topPadding:int = textElement.box.topPadding;
			var leftPadding:int = textElement.box.leftPadding;
			var bottomPadding:int = textElement.box.bottomPadding;
			var rightPadding:int = textElement.box.rightPadding;
			
			var textAlign:String;
			switch (textElement.horizontalAlign) 
			{
				case HorizontalAlignEnum.RIGHT:
					textAlign = "right";
					break;
				case HorizontalAlignEnum.CENTER:
					textAlign = "center";
					break;
				case HorizontalAlignEnum.LEFT:
				case HorizontalAlignEnum.JUSTIFIED:
				default:
					textAlign = "left";
			}
			textControl.setStyle("textAlign", textAlign);

			var verticalOffset:Number;
			switch (textElement.verticalAlign) 
			{
				case VerticalAlignEnum.BOTTOM:
					verticalOffset = textElement.height - textElement.textHeight - topPadding - bottomPadding;
					break;
				case VerticalAlignEnum.MIDDLE:
					verticalOffset = (textElement.height - textElement.textHeight - topPadding - bottomPadding) / 2;
					break;
				case VerticalAlignEnum.TOP:
				default:
					verticalOffset = 0;
			}
			verticalOffset = verticalOffset > 0 ? verticalOffset : 0;

			textControl.setStyle("paddingTop", topPadding + verticalOffset);// - 2);
			textControl.setStyle("paddingLeft", leftPadding);
			textControl.setStyle("paddingBottom", bottomPadding);
			textControl.setStyle("paddingRight", rightPadding);
				
			/* FIXME
			var rotation:String = textElement.rotation;
			if (rotation == RotationEnum.LEFT || rotation == RotationEnum.RIGHT) 
			{
				var temp:int = width;
				width = height;
				height = temp;	
			}
			
			switch (rotation) {
			case RotationEnum.LEFT:
				if (Application.application.isFontsEmbedded) {
					y = y + width;
					rotation = -90;
				} else {
					var bmd:BitmapData = new BitmapData(width, height, false, Style.color(backcolor));
					var bm:Bitmap = new Bitmap(bmd);
					bm.smoothing = true;
					validateNow();
					bm.bitmapData.draw(textControl);
					var uic:UIComponent = new UIComponent();
					uic.addChild(bm);
					uic.x = x;
					uic.y = y + width;
					uic.width = width;
					uic.height = height;
					uic.rotation = -90;
					parent.addChild(uic);
					// visible = false;
					parent.removeChild(textControl);
				}
				break;
			case RotationEnum.RIGHT:
				if (Application.application.isFontsEmbedded) {
					x = x + height;
					rotation = 90;
				} else {
					bmd = new BitmapData(width, height, false, Style.color(backcolor));
					bm = new Bitmap(bmd);
					bm.smoothing = true;
					validateNow();
					bm.bitmapData.draw(textControl);
					uic = new UIComponent();
					uic.addChild(bm);
					uic.x = x + height;
					uic.y = y;
					uic.width = width;
					uic.height = height;
					uic.rotation = 90;
					parent.addChild(uic);
					// visible = false;
					parent.removeChild(textControl);
				}
				break;
			case RotationEnum.UPSIDE_DOWN:
				if (Application.application.isFontsEmbedded) {
					x = x + width;
					y = y + height;
					rotation = 180;
				} else {
					bmd = new BitmapData(width, height, false, Style.color(backcolor));
					bm = new Bitmap(bmd);
					bm.smoothing = true;
					validateNow();
					bm.bitmapData.draw(textControl);
					uic = new UIComponent();
					uic.addChild(bm);
					uic.x = x + width;
					uic.y = y + height;
					uic.width = width;
					uic.height = height;
					uic.rotation = 180;
					parent.addChild(uic);
					// visible = false;
					parent.removeChild(textControl);
				}
				break;
			}
			*/
			
			if (textElement.hyperlink && textElement.hyperlink.type !== HyperlinkTypeEnum.NONE)
			{
				textControl.mouseEnabled = true;
				textControl.buttonMode = true;
				textControl.useHandCursor = true;
				textControl.mouseChildren = false;
				textControl.toolTip = textElement.hyperlink.toolTip;
				textControl.addEventListener(MouseEvent.MOUSE_DOWN, textElement.hyperlink.handler);
			}
			
			//var component:UIComponent = new UIComponent();
			//component.addChild(textControl);
			//canvas.addChild(component);
			context.canvas.addChild(textControl);
		}

		private static function convertToFlexFontName(fontName:String):String 
		{
			switch (fontName.toLowerCase()) {
			case "serif": return "_serif";
			case "sansserif": return "_sans";
			case "monospaced": return "_typewriter";
			case "dialog":
			case "dialoginput": return "Verdana";//FIXME reuse constant? maybe generic font?
			default: return fontName;
			}
		}

		private static function encode(text:String):String 
		{
			var result:String = text.replace(/&/g, "&amp;"); // ampersand
			result = result.replace(/</g, "&lt;"); // less
			result = result.replace(/>/g, "&gt;"); // greater
			result = result.replace(/"/g, "&quot;"); // quote
			result = result.replace(/'/g, "&apos;"); // apostrophe
			return result;
		}
	}

}

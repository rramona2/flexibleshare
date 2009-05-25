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
	import net.sf.jasperreports.flex.model.LineStyleEnum;
	import net.sf.jasperreports.flex.model.FillEnum;
	import net.sf.jasperreports.flex.model.HorizontalAlignEnum;
	import net.sf.jasperreports.flex.model.VerticalAlignEnum;
	import net.sf.jasperreports.flex.model.ScaleImageEnum;
	import net.sf.jasperreports.flex.model.RotationEnum;
	import net.sf.jasperreports.flex.model.LineSpacingEnum;

	public class StyleResolver
	{
		public static function get defaultStyle():Style
		{
			return Page.defaultStyle;
		}
		
		public static function get defaultFont():Style
		{
			return Page.defaultFont;
		}
		
		public static function getMode(element:Element, defaultMode:String):String 
		{
			if (element.ownMode != null)
				return element.ownMode;
			var baseStyle:Style = getBaseStyle(element);
			if (baseStyle != null && baseStyle.mode != null)
				return baseStyle.mode;
			return defaultMode;
		}

		public static function getStyleMode(style:Style):String 
		{
			if (style.ownMode != null)
				return style.ownMode;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.mode;
			return null;
		}
		
		public static function getForecolor(element:Element):Number 
		{
			if (!isNaN(element.ownForecolor))
				return element.ownForecolor;
			var baseStyle:Style = getBaseStyle(element);
			if (baseStyle != null && !isNaN(baseStyle.forecolor))
				return baseStyle.forecolor;
			return 0x000000;
		}
		
		public static function getStyleForecolor(style:Style):Number
		{
			if (!isNaN(style.ownForecolor))
				return style.ownForecolor;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.forecolor;
			return NaN;
		}

		public static function getBackcolor(element:Element):Number 
		{
			if (!isNaN(element.ownBackcolor))
				return element.ownBackcolor;
			var baseStyle:Style = getBaseStyle(element);
			if (baseStyle != null && !isNaN(baseStyle.backcolor))
				return baseStyle.backcolor;
			return 0xFFFFFF;
		}
		
		public static function getStyleBackcolor(style:Style):Number
		{
			if (!isNaN(style.ownBackcolor))
				return style.ownBackcolor;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.backcolor;
			return NaN;
		}

		public static function getFill(element:GraphicElement):String 
		{
			if (element.ownFill != null)
				return element.ownFill;
			var baseStyle:Style = getBaseStyle(element);
			if (baseStyle != null && baseStyle.fill != null)
				return baseStyle.fill;
			return FillEnum.SOLID;
		}

		public static function getStyleFill(style:Style):String 
		{
			if (style.ownFill != null)
				return style.ownFill;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.fill;
			return null;
		}

		public static function getRadius(rectangle:Rectangle):Number
		{
			if (!isNaN(rectangle.ownRadius))
				return rectangle.ownRadius;
			var baseStyle:Style = getBaseStyle(rectangle);
			if (baseStyle != null && !isNaN(baseStyle.radius))
				return baseStyle.radius;
			return 0;
		}

		public static function getStyleRadius(style:Style):Number
		{
			if (!isNaN(style.ownRadius))
				return style.ownRadius;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.radius;
			return NaN;
		}

		public static function getScaleImage(image:Image):String
		{
			if (image.ownScaleImage != null)
				return image.ownScaleImage;
			var baseStyle:Style = getBaseStyle(image);
			if (baseStyle != null && baseStyle.scaleImage != null)
				return baseStyle.scaleImage;
			return ScaleImageEnum.RETAIN_SHAPE;
		}

		public static function getStyleScaleImage(style:Style):String
		{
			if (style.ownScaleImage != null)
				return style.ownScaleImage;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null )
				return baseStyle.scaleImage;
			return null;
		}

		public static function getHorizontalAlign(alignment:Alignment, defaultValue:String):String //FIXME maybe reuse this defaultvalue strategy
		{
			if (alignment.ownHorizontalAlign != null)
				return alignment.ownHorizontalAlign;
			var baseStyle:Style = getBaseStyle(alignment);
			if (baseStyle != null && baseStyle.horizontalAlign != null)
				return baseStyle.horizontalAlign;
			return defaultValue;
		}

		public static function getVerticalAlign(alignment:Alignment, defaultValue:String):String
		{
			if (alignment.ownVerticalAlign != null)
				return alignment.ownVerticalAlign;
			var baseStyle:Style = getBaseStyle(alignment);
			if (baseStyle != null && baseStyle.verticalAlign != null)
				return baseStyle.verticalAlign;
			return defaultValue;
		}

		public static function getRotation(text:Text):String
		{
			if (text.ownRotation != null)
				return text.ownRotation;
			var baseStyle:Style = getBaseStyle(text);
			if (baseStyle != null && baseStyle.rotation != null)
				return baseStyle.rotation;
			return RotationEnum.NONE;
		}

		public static function getStyleRotation(style:Style):String
		{
			if (style.ownRotation != null)
				return style.ownRotation;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.rotation;
			return null;
		}

		public static function getLineSpacing(text:Text):String
		{
			if (text.ownLineSpacing != null)
				return text.ownLineSpacing;
			var baseStyle:Style = getBaseStyle(text);
			if (baseStyle != null && baseStyle.lineSpacing != null)
				return baseStyle.lineSpacing;
			return LineSpacingEnum.SINGLE;
		}

		public static function getStyleLineSpacing(style:Style):String
		{
			if (style.ownLineSpacing != null)
				return style.ownLineSpacing;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.lineSpacing;
			return null;
		}

		public static function getMarkup(text:Text):String
		{
			if (text.ownMarkup != null)
				return text.ownMarkup;
			var baseStyle:Style = getBaseStyle(text);
			if (baseStyle != null && baseStyle.markup != null)
				return baseStyle.markup;
			return MarkupEnum.NONE;
		}

		public static function getStyleMarkup(style:Style):String
		{
			if (style.ownMarkup != null)
				return style.ownMarkup;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.markup;
			return "none";
		}

		public static function getLineWidth(pen:Pen, defaultLineWidth:Number):Number 
		{
			if (!isNaN(pen.ownLineWidth))
				return pen.ownLineWidth;
			var baseStyle:Style = getBaseStyle(pen.penContainer);
			if (baseStyle != null && !isNaN(baseStyle.pen.lineWidth))
				return baseStyle.pen.lineWidth;
			return defaultLineWidth;
		}
		
		public static function getBoxLineWidth(boxPen:BoxPen, defaultLineWidth:Number):Number 
		{
			if (!isNaN(boxPen.ownLineWidth))
				return boxPen.ownLineWidth;
			if (!isNaN(boxPen.box.pen.ownLineWidth)) 
				return boxPen.box.pen.ownLineWidth;
			var baseStyle:Style = getBaseStyle(boxPen.penContainer);
			if (baseStyle != null && !isNaN(boxPen.getPen(baseStyle.box).lineWidth))
				return boxPen.getPen(baseStyle.box).lineWidth;
			return defaultLineWidth;
		}
		
		public static function getLineStyle(pen:Pen):String
		{
			if (pen.ownLineStyle != null)
				return pen.ownLineStyle;
			var baseStyle:Style = getBaseStyle(pen.penContainer);
			if (baseStyle != null && baseStyle.pen.lineStyle != null)
				return baseStyle.pen.lineStyle;
			return LineStyleEnum.SOLID;
		}
		
		public static function getBoxLineStyle(boxPen:BoxPen):String
		{
			if (boxPen.ownLineStyle != null)
				return boxPen.ownLineStyle;
			if (boxPen.box.pen.ownLineStyle != null)
				return boxPen.box.pen.ownLineStyle;
			var baseStyle:Style = getBaseStyle(boxPen.penContainer);
			if (baseStyle != null && boxPen.getPen(baseStyle.box).lineStyle != null)
				return boxPen.getPen(baseStyle.box).lineStyle;
			return LineStyleEnum.SOLID;
		}
		
		public static function getLineColor(pen:Pen, defaultColor:Number):Number 
		{
			if (!isNaN(pen.ownLineColor))
				return pen.ownLineColor;
			var baseStyle:Style = getBaseStyle(pen.penContainer);
			if (baseStyle != null && !isNaN(baseStyle.pen.lineColor))
				return baseStyle.pen.lineColor;
			return defaultColor;
		}
		
		public static function getBoxLineColor(boxPen:BoxPen, defaultColor:Number):Number 
		{
			if (!isNaN(boxPen.ownLineColor))
				return boxPen.ownLineColor;
			if (!isNaN(boxPen.box.pen.ownLineColor))
				return boxPen.box.pen.ownLineColor;
			var baseStyle:Style = getBaseStyle(boxPen.penContainer);
			if (baseStyle != null && !isNaN(boxPen.getPen(baseStyle.box).lineColor))
				return boxPen.getPen(baseStyle.box).lineColor;
			return defaultColor;
		}
		
		public static function getPadding(box:Box):Number 
		{
			if (!isNaN(box.ownPadding))
				return box.ownPadding;
			var baseStyle:Style = getBaseStyle(box.penContainer);
			if (baseStyle != null && !isNaN(baseStyle.box.padding))
				return baseStyle.box.padding;
			return 0;
		}
		
		public static function getTopPadding(box:Box):Number 
		{
			if (!isNaN(box.ownTopPadding))
				return box.ownTopPadding;
			if (!isNaN(box.ownPadding))
				return box.ownPadding;
			var baseStyle:Style = getBaseStyle(box.penContainer);
			if (baseStyle != null && !isNaN(baseStyle.box.topPadding))
				return baseStyle.box.topPadding;
			return 0;
		}
		
		public static function getLeftPadding(box:Box):Number 
		{
			if (!isNaN(box.ownLeftPadding))
				return box.ownLeftPadding;
			if (!isNaN(box.ownPadding))
				return box.ownPadding;
			var baseStyle:Style = getBaseStyle(box.penContainer);
			if (baseStyle != null && !isNaN(baseStyle.box.leftPadding))
				return baseStyle.box.leftPadding;
			return 0;
		}
		
		public static function getBottomPadding(box:Box):Number 
		{
			if (!isNaN(box.ownBottomPadding))
				return box.ownBottomPadding;
			if (!isNaN(box.ownPadding))
				return box.ownPadding;
			var baseStyle:Style = getBaseStyle(box.penContainer);
			if (baseStyle != null && !isNaN(baseStyle.box.bottomPadding))
				return baseStyle.box.bottomPadding;
			return 0;
		}
		
		public static function getRightPadding(box:Box):Number 
		{
			if (!isNaN(box.ownRightPadding))
				return box.ownRightPadding;
			if (!isNaN(box.ownPadding))
				return box.ownPadding;
			var baseStyle:Style = getBaseStyle(box.penContainer);
			if (baseStyle != null && !isNaN(baseStyle.box.rightPadding))
				return baseStyle.box.rightPadding;
			return 0;
		}
		
		public static function getPattern(text:Text):String
		{
			if (text.ownPattern != null)
				return text.ownPattern;
			var baseStyle:Style = getBaseStyle(text);
			if (baseStyle != null)
				return baseStyle.pattern;
			return null;
		}
		
		public static function getStylePattern(style:Style):String
		{
			if (style.ownPattern != null)
				return style.ownPattern;
			var baseStyle:Style = getBaseStyle(style);
			if (baseStyle != null)
				return baseStyle.pattern;
			return null;
		}

		public static function getFontName(font:Font):String
		{
			if (font.ownFontName != null)
				return font.ownFontName;
			var baseStyle:Style = getBaseFont(font);
			if (baseStyle != null && baseStyle.font.fontName != null)
				return baseStyle.font.fontName;
			baseStyle = getBaseStyle(font.styleContainer);
			if (baseStyle != null && baseStyle.font.fontName != null)
				return baseStyle.font.fontName;
			return "Verdana"; //"sansserif"
		}
	
		public static function getFontSize(font:Font):Number
		{
			if (!isNaN(font.ownFontSize))
				return font.ownFontSize;
			var baseStyle:Style = getBaseFont(font);
			if (baseStyle != null)
				return baseStyle.font.fontSize;
			baseStyle = getBaseStyle(font.styleContainer);
			if (baseStyle != null && !isNaN(baseStyle.font.fontSize))
				return baseStyle.font.fontSize;
			return 10;
		}
	
		public static function getBold(font:Font):BooleanEnum
		{
			if (font.ownBold != null)
				return font.ownBold;
			var baseStyle:Style = getBaseFont(font);
			if (baseStyle != null)
				return baseStyle.font.bold;
			baseStyle = getBaseStyle(font.styleContainer);
			if (baseStyle != null && baseStyle.font.bold != null)
				return baseStyle.font.bold;
			return BooleanEnum.FALSE;
		}
	
		public static function getItalic(font:Font):BooleanEnum
		{
			if (font.ownItalic != null)
				return font.ownItalic;
			var baseStyle:Style = getBaseFont(font);
			if (baseStyle != null)
				return baseStyle.font.italic;
			baseStyle = getBaseStyle(font.styleContainer);
			if (baseStyle != null && baseStyle.font.italic != null)
				return baseStyle.font.italic;
			return BooleanEnum.FALSE;
		}
	
		public static function getUnderline(font:Font):BooleanEnum
		{
			if (font.ownUnderline != null)
				return font.ownUnderline;
			var baseStyle:Style = getBaseFont(font);
			if (baseStyle != null)
				return baseStyle.font.underline;
			baseStyle = getBaseStyle(font.styleContainer);
			if (baseStyle != null && baseStyle.font.underline != null)
				return baseStyle.font.underline;
			return BooleanEnum.FALSE;
		}
	
		public static function getStrikeThrough(font:Font):BooleanEnum
		{
			if (font.ownStrikeThrough != null)
				return font.ownStrikeThrough;
			var baseStyle:Style = getBaseFont(font);
			if (baseStyle != null)
				return baseStyle.font.strikeThrough;
			baseStyle = getBaseStyle(font.styleContainer);
			if (baseStyle != null && baseStyle.font.strikeThrough != null)
				return baseStyle.font.strikeThrough;
			return BooleanEnum.FALSE;
		}
	
		public static function getBaseStyle(styleContainer:StyleContainer):Style 
		{
			if (styleContainer != null)
			{
				if (styleContainer.style != null)
					return styleContainer.style;
				if (!(styleContainer is Style))
					return defaultStyle;
			}
			return null;
		}

		public static function getBaseFont(font:Font):Style
		{
			if (font != null)
			{
				if (font.reportFont != null)
					return font.reportFont;
				return defaultFont;
			}
			return null;
		}

	}

}

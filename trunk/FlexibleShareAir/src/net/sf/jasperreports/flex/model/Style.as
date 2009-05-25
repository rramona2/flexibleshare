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

	public class Style implements Alignment, StyleContainer, PenContainer
	{
		private var _name:String;
		private var _isDefault:Boolean = false;
		private var _style:Style;
		private var _mode:String;
		private var _forecolor:Number;
		private var _backcolor:Number;
		private var _pen:Pen = new Pen(this as PenContainer);
		private var _fill:String;
		private var _radius:Number;
		private var _scaleImage:String;
		private var _horizontalAlign:String;
		private var _verticalAlign:String;
		private var _rotation:String;
		private var _lineSpacing:String;
		private var _markup:String;
		private var _pattern:String;
		private var _box:Box = new Box(this as PenContainer);
		private var _font:Font = new Font(this as StyleContainer);
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function set isDefault(value:Boolean):void 
		{
			_isDefault = value;
		}
		
		public function set style(value:Style):void 
		{
			_style = value;
		}
		
		public function set mode(value:String):void 
		{
			_mode = value;
		}
		
		public function set forecolor(value:Number):void 
		{
			_forecolor = value;
		}
		
		public function set backcolor(value:Number):void 
		{
			_backcolor = value;
		}
		
		public function set fill(value:String):void 
		{
			_fill = value;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function set scaleImage(value:String):void 
		{
			_scaleImage = value;
		}
		
		public function set horizontalAlign(value:String):void 
		{
			_horizontalAlign = value;
		}
		
		public function set verticalAlign(value:String):void 
		{
			_verticalAlign = value;
		}

		public function set rotation(value:String):void 
		{
			_rotation = value;
		}
		
		public function set lineSpacing(value:String):void 
		{
			_lineSpacing = value;
		}
		
		public function set markup(value:String):void 
		{
			_markup = value;
		}
		
		public function set pattern(value:String):void 
		{
			_pattern = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get isDefault():Boolean 
		{
			return _isDefault;
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
			return StyleResolver.getStyleMode(this);
		}
		
		public function get ownForecolor():Number 
		{
			return _forecolor;
		}
		
		public function get forecolor():Number 
		{
			return StyleResolver.getStyleForecolor(this);
		}
		
		public function get ownBackcolor():Number 
		{
			return _backcolor;
		}
		
		public function get backcolor():Number 
		{
			return StyleResolver.getStyleBackcolor(this);
		}
		
		public function get pen():Pen
		{
			return _pen;
		}
		
		public function get ownFill():String 
		{
			return _fill;
		}
		
		public function get fill():String 
		{
			return StyleResolver.getStyleFill(this);
		}
		
		public function get ownRadius():Number 
		{
			return _radius;
		}
		
		public function get radius():Number 
		{
			return StyleResolver.getStyleRadius(this);
		}
		
		public function get ownScaleImage():String 
		{
			return _scaleImage;
		}
		
		public function get scaleImage():String 
		{
			return StyleResolver.getStyleScaleImage(this);
		}
		
		public function get ownHorizontalAlign():String 
		{
			return _horizontalAlign;
		}
		
		public function get horizontalAlign():String 
		{
			return StyleResolver.getHorizontalAlign(this, null);
		}
		
		public function get ownVerticalAlign():String 
		{
			return _verticalAlign;
		}
		
		public function get verticalAlign():String 
		{
			return StyleResolver.getVerticalAlign(this, null);
		}
		
		public function get ownRotation():String 
		{
			return _rotation;
		}

		public function get rotation():String 
		{
			return StyleResolver.getStyleRotation(this);
		}

		public function get ownLineSpacing():String 
		{
			return _lineSpacing;
		}

		public function get lineSpacing():String 
		{
			return StyleResolver.getStyleLineSpacing(this);
		}

		public function get ownMarkup():String 
		{
			return _markup;
		}

		public function get markup():String 
		{
			return StyleResolver.getStyleMarkup(this);
		}

		public function get ownPattern():String 
		{
			return _pattern;
		}
		
		public function get pattern():String 
		{
			return StyleResolver.getStylePattern(this);
		}

		public function get box():Box
		{
			return _box;
		}

		public function get font():Font
		{
			return _font;
		}

		public function get defaultLineWidth():Number
		{
			return NaN;
		}

		public function get defaultLineColor():Number
		{
			return this.forecolor;
		}

		public static function color(color:String):Number 
		{
			var result:Number = 0;
			if (color.charAt(0) == '#') {
				result = Number("0x" + color.substr(1));
			} else {
				switch (color) {
				case "black":     result = 0x000000; break;
				case "blue":      result = 0x0000FF; break;
				case "cyan":      result = 0x00FFFF; break;
				case "darkGray":  result = 0x404040; break;
				case "gray":      result = 0x808080; break;
				case "green":     result = 0x00FF00; break;
				case "lightGray": result = 0xC0C0C0; break;
				case "magenta":   result = 0xFF00FF; break;
				case "orange":    result = 0xFFC800; break;
				case "pink":      result = 0xFFAFAF; break;
				case "red":       result = 0xFF0000; break;
				case "yellow":    result = 0xFFFF00; break;
				case "white":     result = 0xFFFFFF; break;
				}
			}
			return result;
		}
	}

}

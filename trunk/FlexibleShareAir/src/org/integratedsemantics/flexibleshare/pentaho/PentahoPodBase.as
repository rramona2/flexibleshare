package org.integratedsemantics.flexibleshare.pentaho
{
	import com.esria.samples.dashboard.view.PodContentBase;
	
	import mx.charts.BarChart;
	import mx.charts.HitData;
	import mx.charts.PieChart;
	import mx.collections.ArrayCollection;
	import mx.formatters.CurrencyFormatter;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;

	public class PentahoPodBase extends PodContentBase
	{
		[Bindable] public var territoryRevenue:ArrayCollection;
		[Bindable] public var productlineRevenue:Object;
		[Bindable] public var topTenCustomersRevenue:Object;
		 
		public var tSrv:HTTPService;
		public var plSrv:HTTPService;
		public var ttcSrv:HTTPService;			
		
		public var tPie:PieChart;
		public var plPie:PieChart;  
		public var ttcBar:BarChart;
		public var cf:CurrencyFormatter;
		
		protected var _selectedTerritory:String = "*";
		protected var _selectedProductLine:String = "*";


		public function PentahoPodBase()
		{
			super();
		}
		    
		protected function initPentahoPod():void
		{
			productlineRevenue = new Object();
			topTenCustomersRevenue = new Object();
			
			tSrv.send();
			
			updateProductLineRevenue();
			updateTopTenCustomersRevenue();
		}
		  
		public function set selectedTerritory(territory:String):void
		{
			_selectedTerritory = territory;
			
			updateProductLineRevenue();
			updateTopTenCustomersRevenue();
		}
  
		[Bindable] public function get selectedTerritory():String
		{
			return _selectedTerritory;
		}
  
		public function set selectedProductLine(productLine:String):void
		{
			_selectedProductLine = productLine;
			
			updateTopTenCustomersRevenue();
		}
  
		[Bindable] public function get selectedProductLine():String
		{
			return _selectedProductLine;
		}
  
		protected function updateProductLineRevenue():void
		{
			if (productlineRevenue[_selectedTerritory] == undefined)
			{
				productlineRevenue[_selectedTerritory] = new ArrayCollection();
				  
				var p:Object = new Object();
				
				if (_selectedTerritory != "*")
				{
					p.territory = _selectedTerritory;
				}
				  
				plSrv.send(p);
			}
			else
			{
				plPie.dataProvider = productlineRevenue[_selectedTerritory];
			}
		}
  
		protected function updateTopTenCustomersRevenue():void
		{
			if (topTenCustomersRevenue[_selectedTerritory + '_' + _selectedProductLine] == undefined)
			{
				topTenCustomersRevenue[_selectedTerritory + '_' + _selectedProductLine] = new ArrayCollection();
				  
				var p:Object = new Object();
				  
				if (_selectedTerritory != "*")
				{
					p.territory = _selectedTerritory;
				}
				  
				if (_selectedProductLine != "*")
				{
					p.productline = _selectedProductLine;
				}
				  
				ttcSrv.send(p);
			}
			else
			{
				ttcBar.dataProvider = topTenCustomersRevenue[_selectedTerritory + '_' + _selectedProductLine];
			}
		}
  
		protected function handleTResult(event:ResultEvent):void
		{
			territoryRevenue = new ArrayCollection();
			tPie.dataProvider = territoryRevenue;
			
			var hdr:ArrayCollection = event.result.Envelope.Body.ExecuteActivityResponse.swresult['COLUMN-HDR-ROW']['COLUMN-HDR-ITEM'];
			
			for each (var pl:Object in event.result.Envelope.Body.ExecuteActivityResponse.swresult['DATA-ROW'])
			{
				var spl:Object = new Object();
				spl[hdr[0]] = pl['DATA-ITEM'][0];
				spl[hdr[1]] = pl['DATA-ITEM'][1];
				territoryRevenue.addItem(spl);
			}
		}
  
		protected function handlePLResult(event:ResultEvent):void
		{
			var hdr:ArrayCollection = event.result.Envelope.Body.ExecuteActivityResponse.swresult['COLUMN-HDR-ROW']['COLUMN-HDR-ITEM'];
			
			for each (var pl:Object in event.result.Envelope.Body.ExecuteActivityResponse.swresult['DATA-ROW'])
			{
				var spl:Object = new Object();
				spl[hdr[0]] = pl['DATA-ITEM'][0];
				// REAL DATA spl[hdr[1]] = pl['DATA-ITEM'][1];
				spl[hdr[1]] = (pl['DATA-ITEM'][1] * (Math.random() + .5));  // randomized for demo
				productlineRevenue[_selectedTerritory].addItem(spl);
			}
			
			plPie.dataProvider = productlineRevenue[_selectedTerritory];
		}
  
		protected function handleTTCResult(event:ResultEvent):void
		{
			var hdr:ArrayCollection = event.result.Envelope.Body.ExecuteActivityResponse.swresult['ROW-HDR-ROW'];
			var pl:ArrayCollection = event.result.Envelope.Body.ExecuteActivityResponse.swresult['DATA-ROW'];
			
			for (var i:int = 0; i < pl.length; i++)
			{
				var spl:Object = new Object();
				spl.name = hdr[i]['ROW-HDR-ITEM'][0];
				// REAL DATA spl.sales = pl[i]['DATA-ITEM'];
				spl.sales = (pl[i]['DATA-ITEM'] * (Math.random() + .5)); // randomized data for demo
				topTenCustomersRevenue[_selectedTerritory + '_' + _selectedProductLine].addItemAt(spl,0);
			}
			    
			ttcBar.dataProvider = topTenCustomersRevenue[_selectedTerritory + '_' + _selectedProductLine];
		}
  
		protected function formatTPieDataTip(hitdata:HitData):String
		{
			return "<b>" + hitdata.item.TERRITORY + "</b><br>" + cf.format(hitdata.item.SOLD_PRICE);
		}
				
	}
}
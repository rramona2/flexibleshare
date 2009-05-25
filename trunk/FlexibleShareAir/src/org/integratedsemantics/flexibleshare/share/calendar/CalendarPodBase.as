package org.integratedsemantics.flexibleshare.share.calendar
{
	
	import com.esria.samples.dashboard.view.PodContentBase;
	
	import mx.controls.Alert;
	import mx.controls.DateChooser;
	import mx.controls.TextInput;
	import mx.controls.ToggleButtonBar;
	import mx.managers.PopUpManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.http.mxml.HTTPService;
	import mx.rpc.Responder;
	import mx.utils.URLUtil;
	
	import qs.calendar.Calendar;
	import qs.calendar.CalendarSet;
	import qs.calendar.iParser;
	import qs.controls.CalendarDisplay;
	import qs.utils.DateRange;
	
	public class CalendarPodBase extends PodContentBase
	{
		public function CalendarPodBase()
		{
			super();
			
			calLoader = new HTTPService();
			calLoader.resultFormat = "text";
		}
		
		[Bindable] public var calSet:CalendarSet = new CalendarSet();
		protected static const displayOptions:Array = ['month','week','day']
		
		public var calLoader:HTTPService;
		public var calUrl:TextInput;
		[Bindable] public var displayMode:ToggleButtonBar;
		
		[Bindable] public var cal:CalendarDisplay;
		public var chooser:DateChooser;
		
		public var busy:Busy;
			
		protected function addCalendar():void
		{
			var createDlg:CreateCalendarDialog = new CreateCalendarDialog();
			createDlg.loadCallback = function(dlg:CreateCalendarDialog):void
			{
				loadCalendar(dlg.url,dlg.calendarName,dlg.color);
			}
			
			PopUpManager.addPopUp(createDlg,this,true);
			PopUpManager.centerPopUp(createDlg);
		}
		protected function showHelp():void
		{
			var hlp:Help = new Help();
			PopUpManager.addPopUp(hlp,this,true);
			PopUpManager.centerPopUp(hlp);
		}
		protected function load():void
		{
			//showHelp();
			//cal.range = new DateRange(chooser.selectedDate,chooser.selectedDate);			
			//loadCalendar("data/test.ics","default",0xBB0000);
            cal.range = new DateRange(new Date(),new Date());			
		}

		private function loadCalendar(url:String, name:String, color:uint):void
		{
			
			busy.currentState = "busy";
			url = URLUtil.getFullURL(systemManager.loaderInfo.url,url);
			calLoader.url = url;
			var token:AsyncToken = calLoader.send();
			token.addResponder(new Responder(
				function(param:*):void {
					var calData:String = (token.result as String);
					var p:iParser = new iParser();
					var calendar:Calendar  = p.parse(calData)[0];
					calendar.contextColor = color;
					calendar.name = name;
					calSet.calendars = calSet.calendars.concat([calendar]);							
					cal.dataProvider = calSet.events;
					busy.currentState = "free";
				},
				function (param:*):void {
				
					Alert.show("calendar load failed");
					busy.currentState = "free";
				}));				
				
		}
		
		protected function goToToday():void
		{
			cal.range = new DateRange(new Date(),new Date());
		}
		protected function formatDate(d:Date):String
		{
			var r:String = d.toDateString();
			return r;
		}
		public function removeCalendar(cal:Object):void
		{
			var cals:Array = calSet.calendars.concat();
			for(var i:int = 0;i<cals.length;i++)
			{
				if(cals[i] == cal)
				{
					cals.splice(i,1);
					calSet.calendars = cals;
					return;
				}
			}
		}
		
		protected function updateRange():void
		{
			cal.displayMode = "auto";
			if(chooser.selectedRanges.length == 0)
				return;
			var selRange:Object = chooser.selectedRanges[0];
			cal.range = new DateRange(selRange.rangeStart,selRange.rangeEnd);			
		}
		
		protected function rangeChangeHandler():void
		{
			chooser.selectedRanges = [ {rangeStart: cal.range.start, rangeEnd: cal.range.end} ];
			chooser.displayedYear = cal.range.start.fullYear;
			chooser.displayedMonth = cal.range.start.month;
		}
		
		protected function displayModeHandler():void
		{
			switch(cal.displayMode)
			{
				case "day":
				case "days":
					displayMode.selectedIndex = 2;
					break;
				case "week":
				case "weeks":
					displayMode.selectedIndex = 1;
					break;
				case "month":
				default:
					displayMode.selectedIndex = 0;
					break;					
			}
		}
		
		protected function headerClickHandler(d:Date):void
		{
			cal.displayMode = "auto";
			cal.range = new DateRange(d,d);						
		}

		protected function dayClickHandler(d:Date):void
		{
			cal.displayMode = "auto";
			cal.range = new DateRange(d,d);						
		}
		
		protected function displayModeItemClickHandler():void
		{
			cal.displayMode=displayOptions[displayMode.selectedIndex];
		}
		
		protected var _colors:Array = [
			0xBB0000,
			0x00BB00,
			0x0000BB,
			0xBBBB00,
			0xBB00BB,
			0x00BBBB
		];
		
		
	}
}
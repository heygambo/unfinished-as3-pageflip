package org.gambi.as3flipbook
{
	import flash.events.Event;
	
	public class SheetEvent extends Event
	{
		public static const SHEET_CLICK:String = "sheetClick";
		
		public static const SHEET_SKIM_TO_NEXT:String = "sheetSkimToNext";
		public static const SHEET_SKIM_TO_PREVIOUS:String = "sheetSkimToPrevious";
		
		public function SheetEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
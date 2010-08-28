package org.gambi.as3flipbook
{
	import flash.events.Event;
	
	public class BookEvent extends Event
	{
		public static const BOOK_SKIM:String = "away3DBookSkim";
		public static const BOOK_COMPLETE:String = "away3DBookComplete";
		
		private var _currentPageIndex:int;
		
		public function BookEvent(type:String, currentPageIndex:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_currentPageIndex = currentPageIndex;
		}
		
		public function get currentPageIndex():int
		{
			return _currentPageIndex;
		}
	}
}
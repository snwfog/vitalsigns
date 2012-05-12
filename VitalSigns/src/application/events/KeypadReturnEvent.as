package application.events
{
	import flash.events.Event;
	
	public class KeypadReturnEvent extends Event
	{
		private var _totalvalue : String;
		
		public function KeypadReturnEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function get totalvalue():String
		{
			return _totalvalue;
		}

		public function set totalvalue(value:String):void
		{
			_totalvalue = value;
		}

		override public function clone():Event
		{
			return new KeypadReturnEvent(type);
		}
		
		
	}
}
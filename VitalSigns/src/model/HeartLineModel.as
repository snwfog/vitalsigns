package model
{
	public class HeartLineModel
	{
		private var _date:Date;
		private var _datay:String;
		
		public function HeartLineModel()
		{

		}

		public function get datay():String
		{
			return _datay;
		}

		public function set datay(value:String):void
		{
			_datay = value;
		}

		public function get date():Date
		{
			return _date;
		}

		public function set date(value:Date):void
		{
			_date = value;
		}

	}
}
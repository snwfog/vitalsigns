package model
{
	[Bindable]
	public class SummaryModel
	{
		private var _type:String;
		private var _value1:String;
		private var _value2:String;
		private var _unit:String;
		private var _date:String;
		private var _intDate:Number;
		
		public function SummaryModel()
		{
		}

		public function get intDate():Number
		{
			return _intDate;
		}

		public function set intDate(value:Number):void
		{
			_intDate = value;
		}

		public function get value2():String
		{
			return _value2;
		}

		public function set value2(value:String):void
		{
			_value2 = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get value1():String
		{
			return _value1;
		}

		public function set value1(value:String):void
		{
			_value1 = value;
		}

		public function get unit():String
		{
			return _unit;
		}

		public function set unit(value:String):void
		{
			_unit = value;
		}

		public function get date():String
		{
			return _date;
		}

		public function set date(value:String):void
		{
			_date = value;
		}

	}
}
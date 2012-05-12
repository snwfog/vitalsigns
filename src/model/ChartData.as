package model
{
	import mx.collections.ArrayCollection;
	
	import spark.components.BorderContainer;
	
	import domain.patient.Patient;

	public class ChartData
	{
		private var _list:ArrayCollection;
		private var _num:int;
		private var _patient:Patient;
		
		
		public function ChartData()
		{
			
		}

		[Bindable]
		public function get patient():Patient
		{
			return _patient;
		}

		public function set patient(value:Patient):void
		{
			_patient = value;
		}

		[Bindable]
		public function get list():ArrayCollection
		{
			return _list;
		}

		public function set list(value:ArrayCollection):void
		{
			_list = value;
		}

		public function get num():int
		{
			return _num;
		}

		public function set num(value:int):void
		{
			_num = value;
		}

	}
}
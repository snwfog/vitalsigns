package model
{
	import mx.collections.ArrayCollection;
	
	import domain.patient.Patient;
	import valueObjects.VitalSignDTO;
	
	public class AllVitalSignsModel
	{
		private var _patient:Patient;
		
		private var _tempList:ArrayCollection;
		private var _rateList:ArrayCollection;
		private var _painList:ArrayCollection;
		private var _oxygenList:ArrayCollection;
		private var _o2List:ArrayCollection;
		private var _respList:ArrayCollection;			
		private var _systolicList:ArrayCollection;
		private var _diastolicList:ArrayCollection;
		private var _heightList:ArrayCollection;
		private var _weightList:ArrayCollection;
		private var _labList:ArrayCollection;
		
		private var _makeO2ChartFlag:Boolean = false;
		private var _makeHeartChartFlag:Boolean = false;
		private var _makePressureDataFlag:Boolean = false;
		
		private var _updateFlag:Boolean = false;
		
		public function AllVitalSignsModel()
		{

		}
		
		public function get labList():ArrayCollection
		{
			return _labList;
		}

		public function set labList(value:ArrayCollection):void
		{
			_labList = value;
		}

		public function get heightList():ArrayCollection
		{
			return _heightList;
		}

		public function set heightList(value:ArrayCollection):void
		{
			_heightList = value;
		}

		public function get weightList():ArrayCollection
		{
			return _weightList;
		}

		public function set weightList(value:ArrayCollection):void
		{
			_weightList = value;
		}

		public function get makePressureDataFlag():Boolean
		{
			return _makePressureDataFlag;
		}

		public function set makePressureDataFlag(value:Boolean):void
		{
			_makePressureDataFlag = value;
		}

		public function get makeHeartChartFlag():Boolean
		{
			return _makeHeartChartFlag;
		}

		public function set makeHeartChartFlag(value:Boolean):void
		{
			_makeHeartChartFlag = value;
		}

		public function get makeO2ChartFlag():Boolean
		{
			return _makeO2ChartFlag;
		}

		public function set makeO2ChartFlag(value:Boolean):void
		{
			_makeO2ChartFlag = value;
		}

		public function get updateFlag():Boolean
		{
			return _updateFlag;
		}

		public function set updateFlag(value:Boolean):void
		{
			_updateFlag = value;
			if(_updateFlag){
				_makeO2ChartFlag = false;
				_makeHeartChartFlag = false;
				_makePressureDataFlag = false;
			}
		}

		public function get diastolicList():ArrayCollection
		{
			return _diastolicList;
		}
		
		public function set diastolicList(value:ArrayCollection):void
		{
			_diastolicList = value;
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
		
		public function get systolicList():ArrayCollection
		{
			return _systolicList;
		}
		
		public function set systolicList(value:ArrayCollection):void
		{
			_systolicList = value;
		}
		
		public function get respList():ArrayCollection
		{
			return _respList;
		}
		
		public function set respList(value:ArrayCollection):void
		{
			_respList = value;
		}
		
		public function get o2List():ArrayCollection
		{
			return _o2List;
		}
		
		public function set o2List(value:ArrayCollection):void
		{
			_o2List = value;
		}
		
		public function get oxygenList():ArrayCollection
		{
			return _oxygenList;
		}
		
		public function set oxygenList(value:ArrayCollection):void
		{
			_oxygenList = value;
		}
		
		public function get painList():ArrayCollection
		{
			return _painList;
		}
		
		public function set painList(value:ArrayCollection):void
		{
			_painList = value;
		}
		
		public function get rateList():ArrayCollection
		{
			return _rateList;
		}
		
		public function set rateList(value:ArrayCollection):void
		{
			_rateList = value;
		}

		public function get tempList():ArrayCollection
		{
			return _tempList;
		}
		
		public function set tempList(value:ArrayCollection):void
		{
			_tempList = value;
		}
	}
}
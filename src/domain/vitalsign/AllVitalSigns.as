package domain.vitalsign
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	public class AllVitalSigns
	{		
		private var _tempList:ArrayCollection = new ArrayCollection();
		private var _rateList:ArrayCollection = new ArrayCollection();
		private var _painList:ArrayCollection = new ArrayCollection();
		private var _oxygenList:ArrayCollection = new ArrayCollection();
		private var _o2List:ArrayCollection = new ArrayCollection();
		private var _respList:ArrayCollection = new ArrayCollection();
		private var _bpList:ArrayCollection = new ArrayCollection();
		private var _heightList:ArrayCollection = new ArrayCollection();
		private var _weightList:ArrayCollection = new ArrayCollection();
		
		private var bpCount:int = 0;
		private var systolicFirst:Boolean = false;
		private var diastolicFirst:Boolean = false; 
		
		public function AllVitalSigns(){}
		
		public function addVitalSign( vs:VitalSign ):void{
			if(vs.type=="SYSTOLIC"){
				if (diastolicFirst){
					(_bpList.getItemAt(bpCount++) as BloodPressureVitalSign).systolic = 
						(vs as BloodPressureVitalSign).systolic;
				}else{
					systolicFirst = true;
					_bpList.addItem(vs);
				}
			}else if(vs.type=="DIASTOLIC"){
				if (systolicFirst){
					(_bpList.getItemAt(bpCount++) as BloodPressureVitalSign).diastolic = 
						(vs as BloodPressureVitalSign).systolic;
				}else{
					diastolicFirst = true;
					(vs as BloodPressureVitalSign).diastolic = 
						(vs as BloodPressureVitalSign).systolic;
					_bpList.addItem(vs);
				}
			}else if(vs.type=="RESPOb"){
				_respList.addItem(vs);
			}else if(vs.type=="PAINSCORE"){
				_painList.addItem(vs);
			}else if(vs.type=="SAO2"){
				_o2List.addItem(vs);
			}else if(vs.type=="TEMPOb"){
				_tempList.addItem(vs);
			}else if(vs.type=="OXYGEN"){
				_oxygenList.addItem(vs);
			}else if(vs.type=="PULSE"){
				_rateList.addItem(vs);
			}else if(vs.type=="HGHT"){
				_heightList.addItem(vs);
			}else if(vs.type=="WEIGHT"){
				_weightList.addItem(vs);
			}
		}
		
		public function get weightList():ArrayCollection
		{
			return _weightList;
		}

		public function set weightList(value:ArrayCollection):void
		{
			_weightList = value;
		}

		public function get heightList():ArrayCollection
		{
			return _heightList;
		}

		public function set heightList(value:ArrayCollection):void
		{
			_heightList = value;
		}

		public function get bpList():ArrayCollection
		{
			return _bpList;
		}

		public function set bpList(value:ArrayCollection):void
		{
			_bpList = value;
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

		public function set tempList(value:ArrayCollection):void
		{
			_tempList = value;
		}

		public function get tempList():ArrayCollection
		{
			return _tempList;
		}
	}
}
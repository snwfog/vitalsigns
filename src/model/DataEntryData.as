package model
{
	import domain.patient.Patient;
	import domain.user.User;
	
	import mx.collections.ArrayCollection;
	
	public class DataEntryData
	{
		private var _patient:Patient;
		private var _loginUser:User;
		
		private var _temperatureData : TemperatureEntryModel;
		private var _heartBpData : HeartBPEntryModel;
		private var _o2RespirationData : O2RespirationEntryModel;
		private var _weightData : HeightWeightEntryModel;
		private var _painScaleData : PainScaleEntryModel;
		private var _bradenScaleData : BradenScaleEntryModel;
		
		private var _currentSummaryState : String;
		private var _currentTemperatureState : String;
		private var _currentHeartState : String;
		private var _currentO2State : String;
		private var _currentPainState : String;
		private var _currentWeightState : String;
		private var _currentResourcesState:String;
		
		private var _userName : String;
		private var _allCharts : AllVitalSignsModel;
		
		private var _patientListByName : ArrayCollection = new ArrayCollection();
		private var _patientListByRoom : ArrayCollection = new ArrayCollection();
		private var _roomList : Array = [];
		
		public function DataEntryData()
		{
			patient = new Patient();
			
			temperatureData = new TemperatureEntryModel();
			heartBpData = new HeartBPEntryModel();
			o2RespirationData = new O2RespirationEntryModel();
			weightData = new HeightWeightEntryModel();
			bradenScaleData = new BradenScaleEntryModel();
			painScaleData = new PainScaleEntryModel();
			
			currentTemperatureState = "normal";
			currentHeartState = "normal";
			currentO2State = "normal";
			currentPainState = "normal";
			currentSummaryState = "normal";
			currentWeightState = "normal";
		}
		
		public function get bradenScaleData():BradenScaleEntryModel
		{
			return _bradenScaleData;
		}

		public function set bradenScaleData(value:BradenScaleEntryModel):void
		{
			_bradenScaleData = value;
		}

		public function get currentResourcesState():String
		{
			return _currentResourcesState;
		}

		public function set currentResourcesState(value:String):void
		{
			_currentResourcesState = value;
		}

		public function get loginUser():User
		{
			return _loginUser;
		}
		
		public function set loginUser(value:User):void
		{
			_loginUser = value;
		}
		
		public function get weightData():HeightWeightEntryModel
		{
			return _weightData;
		}
		
		public function set weightData(value:HeightWeightEntryModel):void
		{
			_weightData = value;
		}
		
		public function get currentWeightState():String
		{
			return _currentWeightState;
		}
		
		public function set currentWeightState(value:String):void
		{
			_currentWeightState = value;
		}
		
		public function get allCharts():AllVitalSignsModel
		{
			return _allCharts;
		}
		
		public function set allCharts(value:AllVitalSignsModel):void
		{
			_allCharts = value;
		}
		
		public function get currentTemperatureState():String
		{
			return _currentTemperatureState;
		}
		
		public function set currentTemperatureState(value:String):void
		{
			_currentTemperatureState = value;
		}
		
		public function get currentHeartState():String
		{
			return _currentHeartState;
		}
		
		public function set currentHeartState(value:String):void
		{
			_currentHeartState = value;
		}
		
		public function get currentO2State():String
		{
			return _currentO2State;
		}
		
		public function set currentO2State(value:String):void
		{
			_currentO2State = value;
		}
		
		public function get currentPainState():String
		{
			return _currentPainState;
		}
		
		public function set currentPainState(value:String):void
		{
			_currentPainState = value;
		}
		
		public function get patient():Patient
		{
			return _patient;
		}
		
		public function set patient(value:Patient):void
		{
			_patient = value;
		}
		
		public function get userName():String
		{
			return _userName;
		}
		
		public function set userName(value:String):void
		{
			_userName = value;
		}
		
		public function get currentSummaryState():String
		{
			return _currentSummaryState;
		}
		
		public function set currentSummaryState(value:String):void
		{
			_currentSummaryState = value;
		}
		
		public function get temperatureData():TemperatureEntryModel
		{
			return _temperatureData;
		}
		
		public function set temperatureData(value:TemperatureEntryModel):void
		{
			_temperatureData = value;
		}
		
		public function get heartBpData():HeartBPEntryModel
		{
			return _heartBpData;
		}
		
		public function set heartBpData(value:HeartBPEntryModel):void
		{
			_heartBpData = value;
		}
		
		public function get o2RespirationData():O2RespirationEntryModel
		{
			return _o2RespirationData;
		}
		
		public function set o2RespirationData(value:O2RespirationEntryModel):void
		{
			_o2RespirationData = value;
		}
		
		public function get painScaleData():PainScaleEntryModel
		{
			return _painScaleData;
		}
		
		public function set painScaleData(value:PainScaleEntryModel):void
		{
			_painScaleData = value;
		}
		
		public function get patientListByName():ArrayCollection
		{
			return _patientListByName;
		}
		
		public function set patientListByName(value:ArrayCollection):void
		{
			_patientListByName = value;
		}
		
		public function get patientListByRoom():ArrayCollection
		{
			return _patientListByRoom;
		}
		
		public function set patientListByRoom(value:ArrayCollection):void
		{
			_patientListByRoom = value;
		}
		
		public function get roomList():Array
		{
			return _roomList;
		}
		
		public function set roomList(value:Array):void
		{
			_roomList = value;
		}
		
		
	}
}

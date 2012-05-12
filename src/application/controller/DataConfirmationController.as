package application.controller
{
	import application.controller.*;
	import application.view.PatientSummaryView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.DataEntryData;
	
	import spark.components.HGroup;
	import spark.components.View;
	
	import testing.Timer;
	
	//import application.view.PatientSummary;
	
	public class DataConfirmationController extends View
	{
		//all data entry fields default set....if they are set,the bool states are set to true and are visible on confirmation view.
		private static var _PatientName:String="Patient Name Not Set";
		
		private static var _TemperatureSite:String="No value entered";
		private static var _TemperatureValue:String="No value entered";
		private static var tempBool:Boolean=false;
		
		private static var _HeartRateSite:String="No value entered";
		private static var _PulseRate:String="No value entered";
		private static var _HeartRateValue:String="No value entered";
		private static var heartBool:Boolean=false;
		
		private static var _BloodPressureSite:String="No value entered";
		private static var _BloodPressurePosition:String="No value entered";
		private static var _BloodPressureCuff:String="No value entered";
		private static var _BloodPressureValue:String="No value entered";
		private static var bloodBool:Boolean=false;
		
		private static var _RespirationRate:String="No value entered";
		private static var respBool:Boolean=false;
		
		private static var _OxygenDevice:String="No value entered";
		private static var _IntakeUnit:String="No value entered";
		private static var _OxygenValue:String="No value entered";
		private static var oxDevBool:Boolean=false;
		
		private static var _OxygenSaturationSite:String="No value entered";
		private static var _OxygenSaturationValue:String="No value entered";
		private static var oxSatBool:Boolean=false;
		
		private static var _Painscale:String="No value entered";
		private static var painBool:Boolean=false;
		
		private static var _BradenSensory:String="No value entered";
		private static var _BradenMobility:String="No value entered";
		private static var _BradenMoisture:String="No value entered";
		private static var _BradenActivity:String="No value entered";
		private static var _BradenNutrition:String="No value entered";
		private static var _BradenFriction:String="No value entered";
		private static var bradenBool:Boolean=false;
		
		private static var _HeightMeasurementMethod:String="No value entered";
		private static var _HeightCms:String="No value entered";
		private static var hgtBool:Boolean=false;
		
		private static var _WeightMeasurementMethod:String="No value entered";
		private static var _WeightKgs:String="No value entered";
		private static var wgtBool:Boolean=false;
		
		public function DataConfirmationController()
		{
			super();
		}
		
		public function stopTimer_handler(event:Event):void {
			Timer.stopTimer();
		}
		
		//patient name
		public static function get PatientName():String
		{
			return _PatientName;
		}

		public static function setPatientName(value:String):void
		{
			if( _PatientName !== value)
			{
				_PatientName = value;
			}
		}
	
		//go to summary view and reset all fields here
		protected function summaryBtn_clickHandler(event:MouseEvent):void
		{
			navigator.popView();
			navigator.pushView(PatientSummaryView, (data as DataEntryData).patient);
			Timer.benchmark("Opening Patient Summary");
			resetAllFields();
		}
		
		public static function resetAllFields():void
		{
			//resets all fields to default.....
			_PatientName="Patient Not Set";
			_TemperatureSite="No value entered";
			_TemperatureValue="No value entered";
			_HeartRateSite="No value entered";
			_PulseRate="No value entered";
			_HeartRateValue="No value entered";
			_BloodPressureSite="No value entered";
			_BloodPressurePosition="No value entered";
			_BloodPressureCuff="No value entered";
			_BloodPressureValue="No value entered";
			_RespirationRate="No value entered";
			_OxygenDevice="No value entered";
			_IntakeUnit="No value entered";
			_OxygenValue="No value entered";
			_OxygenSaturationSite="No value entered";
			_OxygenSaturationValue="No value entered";
			_Painscale="No value entered";
			_BradenSensory="No value entered";
			_BradenMobility="No value entered";
			_BradenMoisture="No value entered";
			_BradenActivity="No value entered";
			_BradenNutrition="No value entered";
			_BradenFriction="No value entered";
			_HeightMeasurementMethod="No value entered";
			_HeightCms="No value entered";
			_WeightMeasurementMethod="No value entered";
			_WeightKgs="No value entered";
			tempBool=false;
			heartBool=false;
			bloodBool=false;
			respBool=false;
			oxDevBool=false;
			oxSatBool=false;
			bradenBool=false;
			hgtBool=false;
			wgtBool=false;
			painBool=false;
		}
		
		
		public static function get TemperatureSite():String
		{
			return _TemperatureSite;
		}
		
		public static function setTemperatureSite(site:String):void
		{
			_TemperatureSite = site;
			tempStateCheck();
		}

		
		public static function get TemperatureValue():String
		{
			return _TemperatureValue; 
		}
		
		public static function setTemperatureValue(value:String):void
		{
			_TemperatureValue = value;
			tempStateCheck();
		}
		
		public static function tempStateCheck():void
		{
			if((_TemperatureValue!="No value entered")&&(_TemperatureSite!="No value entered"))
			{
				tempBool=true;
			}else{
				tempBool=false;
			}
		}

		public static function get HeartRateSite():String
		{
			return _HeartRateSite;
		}

		public static function setHeartRateSite(value:String):void
		{
			_HeartRateSite = value;
			heartStateCheck()
		}

		public static function get PulseRate():String
		{
			return _PulseRate;
		}

		public static function setPulseRate(value:String):void
		{
			_PulseRate = value;
			heartStateCheck()
		}

		public static function get HeartRateValue():String
		{
			return _HeartRateValue;
		}

		public static function setHeartRateValue(value:String):void
		{
			_HeartRateValue = value;
			heartStateCheck()
		}
		
		public static function heartStateCheck():void
		{
			if((_HeartRateSite!="No value entered")&&(_PulseRate!="No value entered")&&(_HeartRateValue!="No value entered"))
			{
				heartBool=true;
			}else{
				heartBool=false;
			}
		}

		public static function get BloodPressureSite():String
		{
			return _BloodPressureSite;
		}

		public static function setBloodPressureSite(value:String):void
		{
			_BloodPressureSite = value;
			bpStateCheck();
		}

		public static function get BloodPressurePosition():String
		{
			return _BloodPressurePosition;
		}

		public static function setBloodPressurePosition(value:String):void
		{
			_BloodPressurePosition = value;
			bpStateCheck();
		}

		public static function get BloodPressureCuff():String
		{
			return _BloodPressureCuff;
		}

		public static function setBloodPressureCuff(value:String):void
		{
			_BloodPressureCuff = value;
			bpStateCheck();
		}
		

		public static function get BloodPressureValue():String
		{
			return _BloodPressureValue;
		}

		public static function setBloodPressureValue(value:String):void
		{
			_BloodPressureValue = value;
			bpStateCheck();		
		}

		public static function bpStateCheck():void
		{
			if((_BloodPressurePosition!="No value entered")&&(_BloodPressureCuff!="No value entered")&&
				(_BloodPressureSite!="No value entered")&&(_BloodPressureValue!="No value entered"))
			{
				bloodBool=true;
			}else{
				bloodBool=false;
			}
		}
		
		public static function get RespirationRate():String
		{
			return _RespirationRate;
		}

		public static function setRespirationRate(value:String):void
		{
			_RespirationRate = value;
			respStateCheck();
		}
		
		public static function respStateCheck():void
		{
			if(_RespirationRate!="No value entered")
			{
				respBool=true;
			}else{
				respBool=false;
			}
		}
		

		public static function get OxygenDevice():String
		{
			return _OxygenDevice;
		}

		public static function setOxygenDevice(value:String):void
		{
			_OxygenDevice = value;
			oxDevStateCheck();
		}

		public static function get IntakeUnit():String
		{
			return _IntakeUnit;
		}

		public static function setIntakeUnit(value:String):void
		{
			_IntakeUnit = value;
			oxDevStateCheck();
		}

		public static function get OxygenValue():String
		{
			return _OxygenValue;
		}

		public static function setOxygenValue(value:String):void
		{
			_OxygenValue = value;
			oxDevStateCheck();
		}
		
		
		public static function oxDevStateCheck():void
		{
			if((_OxygenDevice!="No value entered")&&(_IntakeUnit!="No value entered")&&(_OxygenValue!="No value entered"))
			{
				oxDevBool=true;
			}else{
				oxDevBool=false;
			}
		}
		

		public static function get OxygenSaturationSite():String
		{
			return _OxygenSaturationSite;
		}

		public static function setOxygenSaturationSite(value:String):void
		{
			_OxygenSaturationSite = value;
			oxSatStateCheck();
		}

		public static function get OxygenSaturationValue():String
		{
			return _OxygenSaturationValue;
		}

		public static function setOxygenSaturationValue(value:String):void
		{
			_OxygenSaturationValue = value;
			oxSatStateCheck();
		}
		
		public static function oxSatStateCheck():void
		{
			if((_OxygenSaturationSite!="No value entered")&&(_OxygenSaturationValue!="No value entered"))
			{
				oxSatBool=true;
			}else{
				oxSatBool=false;
			}
		}
		

		public static function get Painscale():String
		{
			return _Painscale;
		}

		public static function setPainscale(value:String):void
		{
			_Painscale = value;
			painStateCheck();
		}
		
		public static function painStateCheck():void
		{
			if(_Painscale!="No value entered")
			{
				painBool=true;
			}else{
				painBool=false;
			}
		}
		
		

		public static function get BradenSensory():String
		{
			return _BradenSensory;
		}

		public static function setBradenSensory(value:String):void
		{
			_BradenSensory = value;
			bradenStateCheck();
		}

		public static function get BradenMobility():String
		{
			return _BradenMobility;
		}

		public static function setBradenMobility(value:String):void
		{
			_BradenMobility = value;
			bradenStateCheck();
		}

		public static function get BradenMoisture():String
		{
			return _BradenMoisture;
		}

		public static function setBradenMoisture(value:String):void
		{
			_BradenMoisture = value;
			bradenStateCheck();
		}

		public static function get BradenActivity():String
		{
			return _BradenActivity;
		}

		public static function setBradenActivity(value:String):void
		{
			_BradenActivity = value;
			bradenStateCheck();
		}

		public static function get BradenNutrition():String
		{
			return _BradenNutrition;
		}

		public static function setBradenNutrition(value:String):void
		{
			_BradenNutrition = value;
			bradenStateCheck();
		}

		public static function get BradenFriction():String
		{
			return _BradenFriction;
		}

		public static function setBradenFriction(value:String):void
		{
			_BradenFriction = value;
			bradenStateCheck();
		}
		
		
		public static function bradenStateCheck():void
		{
			if((_BradenSensory!="No value entered")&&(_BradenMobility!="No value entered")&&(_BradenMoisture!="No value entered")&&
				(_BradenActivity!="No value entered")&&(_BradenNutrition!="No value entered")&&(_BradenFriction!="No value entered"))
			{
				bradenBool=true;
			}else{
				bradenBool=false;
			}
		}
		

		public static function get HeightMeasurementMethod():String
		{
			return _HeightMeasurementMethod;
		}

		public static function setHeightMeasurementMethod(value:String):void
		{
			_HeightMeasurementMethod = value;
			heightStateCheck();			
		}

		public static function get HeightCms():String
		{
			return _HeightCms;
		}

		public static function setHeightCms(value:String):void
		{
			_HeightCms = value;
			heightStateCheck();
		}
		
		
		public static function heightStateCheck():void
		{
			if((_HeightMeasurementMethod!="No value entered")&&(_HeightCms!="No value entered"))
			{
				hgtBool=true;
			}else{
				hgtBool=false;
			}
		}

		public static function get WeightMeasurementMethod():String
		{
			return _WeightMeasurementMethod;
		}

		public static function setWeightMeasurementMethod(value:String):void
		{
			_WeightMeasurementMethod = value;
			weightStateCheck();
		}

		public static function get WeightKgs():String
		{
			return _WeightKgs;
		}

		public static function setWeightKgs(value:String):void
		{
			_WeightKgs = value;
			weightStateCheck();
		}
		
		
		public static function weightStateCheck():void
		{
			if((_WeightMeasurementMethod!="No value entered")&&(_WeightKgs!="No value entered"))
			{
				wgtBool=true;
			}else{
				wgtBool=false;
			}
		}
		
		public static function get tempSiteBool():Boolean
		{
			return tempBool;
		}
		
		public static function get heartSiteBool():Boolean
		{
			return heartBool;
		}
		
		
		public static function get bloodSiteBool():Boolean
		{
			return bloodBool;
		}
		
		public static function get respRateBool():Boolean
		{
			return respBool;
		}
		
		public static function get oxyDevBool():Boolean
		{
			return oxDevBool;
		}
		
		public static function get oxySatBool():Boolean
		{
			return oxSatBool;
		}
		
		public static function get bradBool():Boolean
		{
			return bradenBool;
		}
		
		public static function get htBool():Boolean
		{
			return hgtBool;
		}
		
		public static function get wtBool():Boolean
		{
			return wgtBool;
		}
		
		
		public static function get pnBool():Boolean
		{
			return painBool;
		}
		
		
	}
}


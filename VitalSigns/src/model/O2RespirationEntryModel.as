package model
{
	import valueObjects.VitalSignDTO;

	public class O2RespirationEntryModel
	{
		private var _respirationValue : String;
		
		private var _o2Device : String;
		private var _o2Value : String;
		private var _o2Unit : String;
		
		private var _o2SaturationSite : String;
		private var _o2SaturationValue :String;
		
		public function O2RespirationEntryModel()
		{
			o2Device = "Nasal Prongs/ Cannula";
			o2Unit = "L/min";
			o2SaturationSite = "Finger";
		}

		public function get respirationValue():String
		{
			return _respirationValue;
		}

		public function set respirationValue(value:String):void
		{
			_respirationValue = value;
		}

		public function get o2Device():String
		{
			return _o2Device;
		}

		public function set o2Device(value:String):void
		{
			_o2Device = value;
		}

		public function get o2Value():String
		{
			return _o2Value;
		}

		public function set o2Value(value:String):void
		{
			_o2Value = value;
		}

		public function get o2SaturationSite():String
		{
			return _o2SaturationSite;
		}

		public function set o2SaturationSite(value:String):void
		{
			_o2SaturationSite = value;
		}

		public function get o2SaturationValue():String
		{
			return _o2SaturationValue;
		}

		public function set o2SaturationValue(value:String):void
		{
			_o2SaturationValue = value;
		}

		public function get o2Unit():String
		{
			return _o2Unit;
		}

		public function set o2Unit(value:String):void
		{
		 	if (value == "L/min"){
				_o2Unit = "l/min";
			}else{
				_o2Unit = value;
			}
		}
		
		public function get respVitalSignDTO():VitalSignDTO
		{
			var respVsDTO:VitalSignDTO = new VitalSignDTO();
			respVsDTO.alert = false;
			respVsDTO.description = "";
			respVsDTO.lastChgDtm = new Date();
			respVsDTO.method = "";
			respVsDTO.position = "";
			respVsDTO.sid = 0;
			respVsDTO.site = "";
			respVsDTO.type = "RESPOb";
			respVsDTO.unit = "BPM";
			respVsDTO.value = respirationValue;
			
			return respVsDTO;
		}
		
		public function get oxygenVitalSignDTO():VitalSignDTO
		{
			var oxyVsDTO:VitalSignDTO = new VitalSignDTO();
			oxyVsDTO.alert = false;
			oxyVsDTO.description = "";
			oxyVsDTO.lastChgDtm = new Date();
			oxyVsDTO.method = getCodeO2(o2Device);
			oxyVsDTO.position = "";
			oxyVsDTO.sid = 0;
			oxyVsDTO.site = "";
			oxyVsDTO.type = "OXYGEN";
			oxyVsDTO.unit = o2Unit;
			oxyVsDTO.value = o2Value;
			
			return oxyVsDTO;
		}
		
		public function get o2SatVitalSignDTO():VitalSignDTO
		{
			var o2SatVsDTO:VitalSignDTO = new VitalSignDTO();
			o2SatVsDTO.alert = false;
			o2SatVsDTO.description = "";
			o2SatVsDTO.lastChgDtm = new Date();
			o2SatVsDTO.method = "";
			o2SatVsDTO.position = "";
			o2SatVsDTO.sid = 0;
			o2SatVsDTO.site = getCodeO2Sat(o2SaturationSite);
			o2SatVsDTO.type = "SAO2";
			o2SatVsDTO.unit = "%";
			o2SatVsDTO.value = o2SaturationValue;
			
			return o2SatVsDTO;
		}
		
		private function getCodeO2(value:String):String
		{
			switch(value){
				//Oxygen Device
				case "Room Air": 				return "03AIRROM";
				case "Nasal Prongs / Cannula": 	return "10mxPROC";
				case "Nasal CPAP": 				return "15NASCPA";
				case "Full Face CPAP": 			return "18FFCPAP";
				case "Full Face BiPAP": 		return "23FFBPAP";
				case "Nasal BiPAP": 			return "20NABPAP";
				case "Mask (Partial Rebreather)": 	return "25mxPRMA";
				case "Mask (non-Rebreather)": 		return "30mxNRMA";
				case "High Humidity / Aerosol Mask": 	return "45HHAMAS";
				case "Mask Venturi (Multi-Concentration)": return "35mxVMCM";
				case "Mid Oxygen Concentration Mask": 	return "40mxMOCM";
				case "Trach Collar": 			return "48TRACOL";
				case "Other": 					return "95OTHER";
					
				default: return "";

			}
		}
		
		private function getCodeO2Sat(value:String):String
		{
			switch(value){
				//O2 Saturation Site
				case "Earlobe": 	return "EARLOBO2";
				case "Finger": 		return "FINGERO2";
				case "Toe/Foot": 	return "TOEFOTO2";
				case "Other": 		return "ZOTHRO2";
					
				default: return "";
			}
		}
	}
}
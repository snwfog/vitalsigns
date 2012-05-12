package model
{
	import valueObjects.VitalSignDTO;

	public class TemperatureEntryModel
	{
		private var _site : String;
		private var _value : String;
		public function TemperatureEntryModel()
		{
			_site = "Oral";
		}

		public function get site():String
		{
			return _site;
		}

		public function set site(value:String):void
		{
			_site = value;
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}
		
		public function get vitalSignDTO():VitalSignDTO
		{
			var tempVsDTO:VitalSignDTO = new VitalSignDTO();
			tempVsDTO.alert = false;
			tempVsDTO.description = "";
			tempVsDTO.lastChgDtm = new Date();
			tempVsDTO.method = "";
			tempVsDTO.position = "";
			tempVsDTO.sid = 0;
			tempVsDTO.site = getCode(site);
			tempVsDTO.type = "TEMPOb";
			tempVsDTO.unit = "C";
			tempVsDTO.value = value;
			
			return tempVsDTO;
		}
		
		private function getCode(value:String):String
		{
			switch(value){
				case "Oral": 	return "AORALTMP";
				case "Rectal": 	return "CRCTLTMP";
				case "Axillary": return "EAXILTMP";
				case "Topical": return "GTPCLTMP";
				case "Core": 	return "ICORETMP";
				default : 		return "";
			}
		}


	}
}
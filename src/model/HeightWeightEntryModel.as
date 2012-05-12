package model
{
	import valueObjects.VitalSignDTO;

	public class HeightWeightEntryModel
	{
		private var _heightMethod : String;
		private var _heightValue : String;
		
		private var _weightMethod : String;
		private var _weightValue : String;
		
		public function HeightWeightEntryModel()
		{
			heightMethod  = "Measured";
			weightMethod = "Measured";
		}

		public function get weightValue():String
		{
			return _weightValue;
		}

		public function set weightValue(value:String):void
		{
			_weightValue = value;
		}

		public function get weightMethod():String
		{
			return _weightMethod;
		}

		public function set weightMethod(value:String):void
		{
			_weightMethod = value;
		}

		public function get heightValue():String
		{
			return _heightValue;
		}

		public function set heightValue(value:String):void
		{
			_heightValue = value;
		}

		public function get heightMethod():String
		{
			return _heightMethod;
		}

		public function set heightMethod(value:String):void
		{
			_heightMethod = value;
		}
		
		public function get heightVitalSignDTO():VitalSignDTO
		{
			var heightVsDTO : VitalSignDTO = new VitalSignDTO ();
			heightVsDTO.alert = false;
			heightVsDTO.description = "";
			heightVsDTO.lastChgDtm = new Date();
			heightVsDTO.method = getCodeHt(heightMethod);
			heightVsDTO.position = "";
			heightVsDTO.sid = 0;
			heightVsDTO.site = "";
			heightVsDTO.unit = "cm";
			heightVsDTO.type = "HGHT";
			heightVsDTO.value = heightValue;
			
			return heightVsDTO;
		}
		
		public function get weightVitalSignDTO():VitalSignDTO
		{
			var weightVsDTO : VitalSignDTO = new VitalSignDTO();
			weightVsDTO.alert = false;
			weightVsDTO.description = "";
			weightVsDTO.lastChgDtm = new Date();
			weightVsDTO.method = getCodeWt(weightMethod);
			weightVsDTO.position = "";
			weightVsDTO.sid = 0;
			weightVsDTO.site = "";
			weightVsDTO.unit = "kg";
			weightVsDTO.type = "WEIGHT";
			weightVsDTO.value = weightValue;
			
			return weightVsDTO;
		}
		
		
		
		private function getCodeWt(value:String):String
		{
			switch(value){
				//Weight Method
				case "Standing Scale - Mechanical": return "05mcSTSC";
				case "Standing Scale - Electronic": return "07mcSTSE";
				case "Bed Scale": 					return "10BEDSCA";
				case "Patient Lift with Electronic Scale": return "13PLSCAL";
				case "Electronic Stretcher Scale": 	return "15mxESTC";
				case "Wheelchair Scale": 			return "17mxWHEE";
				case "Infant Scale": 				return "23cxINFS";
				case "Estimated": 					return "33EXTIMA";
				case "Stated": 						return "34STATED";
				case "Transfer Records": 			return "35TRANSF";
				case "Other": 						return "90OTHER";
					
				default : return "";
			}			
	
		}
		
		private function getCodeHt(value:String):String
		{
			switch(value){
				//Height Method
				case "Estimated": 	return "ESTHT";
				case "Measured": 	return "MSRDHT";
				case "Stated": 		return "STTDHT";
				case "Transfer Records": return "TRFRCHT";

				default : return "";
			}
		}
	}
}
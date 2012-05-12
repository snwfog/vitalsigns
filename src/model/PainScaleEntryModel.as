package model
{
	import valueObjects.VitalSignDTO;
	
	public class PainScaleEntryModel
	{
		private var _painScaleData : String;
		
		public function PainScaleEntryModel()
		{
		}
		
		public function get painScaleData():String
		{
			return _painScaleData;
		}
		
		public function set painScaleData(value:String):void
		{
			_painScaleData = value;
		}
		
		public function get painVitalSignDTO():VitalSignDTO
		{
			var painVsDTO : VitalSignDTO = new VitalSignDTO();
			painVsDTO.alert = false;
			painVsDTO.description = "";
			painVsDTO.lastChgDtm = new Date();
			painVsDTO.method = "";
			painVsDTO.position = "";
			painVsDTO.sid = 0;
			painVsDTO.site = "";
			painVsDTO.type = "PAINSCORE";
			painVsDTO.unit = "";
			painVsDTO.value = painScaleData;
			
			return painVsDTO;
		}
	}
}
package model
{
	import valueObjects.VitalSignDTO;

	public class HeartBPEntryModel
	{
		private var _heartSite : String;
		private var _heartPulse : String;
		private var _heartValue : String;
		
		private var _bpSite : String;
		private var _bpPosition : String;
		private var _bpCuff : String;
		private var _bpValue : String;
		
		public function HeartBPEntryModel()
		{
			heartSite = "Radial Right";
			heartPulse = "Regular";
			bpSite = "Arm Right";
			bpPosition = "Supine";
			bpCuff = "Automatic Cuff";
		}

		public function get heartSite():String
		{
			return _heartSite;
		}

		public function set heartSite(value:String):void
		{
			_heartSite = value;
		}

		public function get heartPulse():String
		{
			return _heartPulse;
		}

		public function set heartPulse(value:String):void
		{
			_heartPulse = value;
		}

		public function get heartValue():String
		{
			return _heartValue;
		}

		public function set heartValue(value:String):void
		{
			_heartValue = value;
		}

		public function get bpSite():String
		{
			return _bpSite;
		}

		public function set bpSite(value:String):void
		{
			_bpSite = value;
		}

		public function get bpPosition():String
		{
			return _bpPosition;
		}

		public function set bpPosition(value:String):void
		{
			_bpPosition = value;
		}

		public function get bpCuff():String
		{
			return _bpCuff;
		}

		public function set bpCuff(value:String):void
		{
			_bpCuff = value;
		}

		public function get bpValue():String
		{
			return _bpValue;
		}

		public function set bpValue(value:String):void
		{
			_bpValue = value;
		}
		
		public function get pulseVitalSignDTO():VitalSignDTO
		{
			var heartVsDTO:VitalSignDTO = new VitalSignDTO();
			heartVsDTO.alert = false;
			heartVsDTO.description = getCode(heartPulse);
			heartVsDTO.lastChgDtm = new Date();
			heartVsDTO.method = "";
			heartVsDTO.position = "";
			heartVsDTO.sid = 0;
			heartVsDTO.site = getCode(heartSite);
			heartVsDTO.type = "PULSE";
			heartVsDTO.unit = "bpm";
			heartVsDTO.value = heartValue;
			
			return heartVsDTO;
		}
		
		public function get systolicVitalSignDTO():VitalSignDTO
		{
			var sysVsDTO:VitalSignDTO = new VitalSignDTO();
			sysVsDTO.alert = false;
			sysVsDTO.description = "";
			sysVsDTO.lastChgDtm = new Date();
			sysVsDTO.method = getCode(bpCuff);
			sysVsDTO.position = getCode(bpPosition);
			sysVsDTO.sid = 0;
			sysVsDTO.site = getCode(bpSite);
			sysVsDTO.type = "SYSTOLIC";
			sysVsDTO.unit = "mmHg";
			sysVsDTO.value = bpValue.substring(0,bpValue.indexOf("/",0));
			
			return sysVsDTO;
		}
		
		public function get diastolicVitalSignDTO():VitalSignDTO
		{
			var diasVsDTO:VitalSignDTO = new VitalSignDTO();
			diasVsDTO.alert = false;
			diasVsDTO.description = "";
			diasVsDTO.lastChgDtm = new Date();
			diasVsDTO.method = getCode(bpCuff);
			diasVsDTO.position = getCode(bpPosition);
			diasVsDTO.sid = 0;
			diasVsDTO.site = getCode(bpSite);
			diasVsDTO.type = "DIASTOLIC";
			diasVsDTO.unit = "mmHg";
			diasVsDTO.value = bpValue.substring(bpValue..indexOf("/",0)+1,bpValue.length);
			
			return diasVsDTO;
		}
		
		
		private function getCode(value:String):String
		{
			switch(value){
				//Pulse
				case "Regular":			return "AAREGPLS";
				case "Irregular":		return "ABIRRGPL";
				//HR Site
				case "Apical":			return "APCLPLS";
				case "Axillary Left":	return "LAXLLPLS";
				case "Brachial Left":	return "LBRCHPLS";
				case "Carotid Left":	return "LCRTDPLS";
				case "Femoral Left":	return "LFEMPLS";
				case "Pedal Left":		return "LPDLPLS";
				case "Posterior Tibialis Left":	return "LPOTBPLS";
				case "Radial Left":		return "LRADLPLS";
				case "Axillary Right":	return "RAXLLPLS";
				case "Brachial Right":	return "RBRCHPLS";
				case "Carotid Right":	return "RCRTDPLS";
				case "Femoral Right":	return "RFEMPLS";
				case "Pedal Right":		return "RPDLPLS";
				case "Posterior Tibialis Right":	return "RPOTBPLS";
				case "Radial Right":	return "RRADLPLS";
				case "Electronic Device":	return "ELDEVPLS";
				//BP Site
				case "Arm Left":	return "LARMBP";
				case "Thigh Left":	return "LTHGHBP";
				case "Calf Left":	return "LCALBP";
				case "Arm Right":	return "RARMBP";
				case "Thigh Right":	return "RTHGHBP";
				case "Calf Right":	return "RCALBP";
				//BP Position
				case "Sitting":		return "SITBP";
				case "Supine":		return "ASUPBP";
				case "Standing":	return "STNDBP";
				//BP Method
				case "Automatic Cuff":		return "ATOCFFBP";
				case "Manual Cuff":		return "MANCFFBP";
				case "Manual/Palpation":		return "MPACFFBP";

				default: 				return "";
			}
		}


	}
}
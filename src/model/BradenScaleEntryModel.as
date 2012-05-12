package model
{
	import valueObjects.BradenScaleDTO;
	
	public class BradenScaleEntryModel
	{
		
		private var _b1SENSRY : int;
		private var _b2MOBLTY : int;
		private var _b3MSTURE : int;
		private var _b4ACTVTY : int;
		private var _b5NUTRTN : int;
		private var _b6FRCTSH : int;
		
		private var _b1SENSRYcode : String;
		private var _b2MOBLTYcode : String;
		private var _b3MSTUREcode : String;
		private var _b4ACTVTYcode : String;
		private var _b5NUTRTNcode : String;
		private var _b6FRCTSHcode : String;
		
		private var _TOTAL : int;
		
		public function BradenScaleEntryModel()
		{
			_b1SENSRY = 0;
			_b2MOBLTY = 0;
			_b3MSTURE = 0;
			_b4ACTVTY = 0;
			_b5NUTRTN = 0;
			_b6FRCTSH = 0;
			
			_TOTAL = 0;
		}
		
		public function get b1SENSRY():int
		{
			return _b1SENSRY;
		}
		
		public function set b1SENSRY(value:int):void
		{
			_b1SENSRY = value;
			
			if (value == 1){  _b1SENSRYcode = "1_CMPLTD"; }
			else if (value == 2){  _b1SENSRYcode = "2_VRYLTD"; }
			else if (value == 3){  _b1SENSRYcode = "3_SLTLTD"; }
			else if (value == 4){  _b1SENSRYcode = "3_SLTLTD"; }
		}
		
		public function get b1SENSRYcode():String
		{
			return _b1SENSRYcode;
		}
		
		public function get b2MOBLTY():int
		{
			return _b2MOBLTY;
		}
		
		public function set b2MOBLTY(value:int):void
		{
			_b2MOBLTY = value;
			
			if (value == 1){  _b2MOBLTYcode = "1_MCPLTD"; }
			else if (value == 2){  _b2MOBLTYcode = "2_MVRLTD"; }
			else if (value == 3){  _b2MOBLTYcode = "3_MSLLTD"; }
			else if (value == 4){  _b2MOBLTYcode = "4_MNOIMP"; }
		
		}
		
		public function get b2MOBLTYcode():String
		{
			return _b2MOBLTYcode;
		}
		
		public function get b3MSTURE():int
		{
			return _b3MSTURE;
		}
		
		public function set b3MSTURE(value:int):void
		{
			_b3MSTURE = value;
			
			if (value == 1){  _b3MSTUREcode = "1_CNSMST"; }
			else if (value == 2){  _b3MSTUREcode = "2_VRYMST"; }
			else if (value == 3){  _b3MSTUREcode = "3_OCCMST"; }
			else if (value == 4){  _b3MSTUREcode = "4_RARMST"; }
			
		}
		
		public function get b3MSTUREcode():String
		{
			return _b3MSTUREcode;
		}
		
		public function get b4ACTVTY():int
		{
			return _b4ACTVTY;
		}
		
		public function set b4ACTVTY(value:int):void
		{
			_b4ACTVTY = value;
			
			if (value == 1){  _b4ACTVTYcode = "1_BEDFST"; }
			else if (value == 2){  _b4ACTVTYcode = "2_CHRFST"; }
			else if (value == 3){  _b4ACTVTYcode = "3_WLKOCC"; }
			else if (value == 4){  _b4ACTVTYcode = "4_WLKFRQ"; }

		}
		
		public function get b4ACTVTYcode():String
		{
			return _b4ACTVTYcode;
		}
		
		public function get b5NUTRTN():int
		{
			return _b5NUTRTN;
		}
		
		public function set b5NUTRTN(value:int):void
		{
			_b5NUTRTN = value;
			
			if (value == 1){  _b5NUTRTNcode = "1_VRYPOR"; }
			else if (value == 2){  _b5NUTRTNcode = "2_PRINDQ"; }
			else if (value == 3){  _b5NUTRTNcode = "3_ADEQ"; }
			else if (value == 4){  _b5NUTRTNcode = "4_EXCLNT"; }

		}
		
		public function get b5NUTRTNcode():String
		{
			return _b5NUTRTNcode;
		}
		
		public function get b6FRCTSH():int
		{
			return _b6FRCTSH;
		}
		
		public function set b6FRCTSH(value:int):void
		{
			_b6FRCTSH = value;
			
			if (value == 1){  _b6FRCTSHcode = "1_PROBLM"; }
			else if (value == 2){  _b6FRCTSHcode = "2_POTPRB"; }
			else if (value == 3){  _b6FRCTSHcode = "3_NOAPRB"; }
			
		}
		
		public function get b6FRCTSHcode():String
		{
			return _b6FRCTSHcode;
		}
		
		public function get TOTAL():int
		{
			_TOTAL = _b1SENSRY + _b2MOBLTY + _b3MSTURE + _b4ACTVTY + _b5NUTRTN + _b6FRCTSH;

			return _TOTAL;
		}
		
		public function set TOTAL(value:int):void
		{
			_TOTAL = value;
		}
		
		public function get bradenScaleDTO():BradenScaleDTO{
			var bradenScaleModel : BradenScaleDTO = new BradenScaleDTO();
			bradenScaleModel.b1SENSRY = b1SENSRYcode;
			bradenScaleModel.b2MOBLTY = b2MOBLTYcode;
			bradenScaleModel.b3MSTURE = b3MSTUREcode;
			bradenScaleModel.b4ACTVTY = b4ACTVTYcode;
			bradenScaleModel.b5NUTRTN = b5NUTRTNcode;
			bradenScaleModel.b6FRCTSH = b6FRCTSHcode;
			
			return bradenScaleModel;
		}
	}
}
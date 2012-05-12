package domain.vitalsign
{
	public class BloodPressureVitalSign extends VitalSign
	{
		
		private var _diastolic:String;
		
		public function BloodPressureVitalSign( value:String = "", diastolic:String = "", description:String = "", lastChgDtm:Date = null,
										method:String = "", position:String = "", sid:Number = 0, site:String = "",
										type:String = "", unit:String = "", alert:Boolean = false ){
			super( value, description, lastChgDtm, method, position, sid, site, type, unit, alert );
			_diastolic = diastolic;
		}
		
		public function get systolic():String{
			return super.value;
		}
		
		public function set systolic( value:String ):void{
			super.value = value;
		}
		
		public function get diastolic():String{
			return _diastolic;
		}
		
		public function set diastolic( value:String ):void{
			_diastolic = value;
		}
		
		public override function toString():String{
			if( super.value.length == 0 )
				return "";
			if (super.value == "- no value -")
				return super.value;
			
			var intSys:int = int(super.value);
			var intDias:int = int(_diastolic);
			return intSys + "/" + intDias + " " + super.unit;
		}
	}
}
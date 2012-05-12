package domain.vitalsign
{
	public class RespirationVitalSign extends VitalSign
	{
		public function RespirationVitalSign( value:String = "", description:String = "", lastChgDtm:Date = null,
											  method:String = "", position:String = "", sid:Number = 0, site:String = "",
											  type:String = "", unit:String = "", alert:Boolean = false ){
			super( value, description, lastChgDtm, method, position, sid, site, type, unit, alert );
		}
		
		public function get respirationRate():String{
			return super.value;
		}
		
		public function set respirationRate( value:String ):void{
			super.value = value;
		}
		
		public override function toString():String{
			if( super.value.length == 0 )
				return "";
			if (super.value == "- no value -")
				return super.value;
			
			var intVal:int = int(super.value);
			return intVal + " " + super.unit;
		}
	}
}
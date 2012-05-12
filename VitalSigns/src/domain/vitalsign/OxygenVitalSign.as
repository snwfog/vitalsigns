package domain.vitalsign
{
	public class OxygenVitalSign extends VitalSign
	{
		public function OxygenVitalSign( value:String = "", description:String = "", lastChgDtm:Date = null,
										 method:String = "", position:String = "", sid:Number = 0, site:String = "",
										 type:String = "", unit:String = "", alert:Boolean = false){
			super( value, description, lastChgDtm, method, position, sid, site, type, unit, alert );
		}
		
		public function get oxygenValue():String{
			return super.value;
		}
		
		public function set oxygenValue( value:String ):void{
			super.value = value;
		}
		
		public override function toString():String{
			if( super.value.length == 0 )
				return "";
			return super.value + " " + super.unit;
		}
	}
}
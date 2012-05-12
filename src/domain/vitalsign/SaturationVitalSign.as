package domain.vitalsign
{
	public class SaturationVitalSign extends VitalSign
	{
		public function SaturationVitalSign( value:String = "", description:String = "", lastChgDtm:Date = null,
											 method:String = "", position:String = "", sid:Number = 0, site:String = "",
											 type:String = "", unit:String = "", alert:Boolean = false ){
			super( value, description, lastChgDtm, method, position, sid, site, type, unit, alert );
		}
		
		public function set saturation( value:String ):void{
			super.value = value;
		}
		
		public function get saturation():String{
			return value;
		}
		
		public override function toString():String{
			if( super.value.length == 0 )
				return "";
			return super.value + " " + super.unit;
		}
	}
}
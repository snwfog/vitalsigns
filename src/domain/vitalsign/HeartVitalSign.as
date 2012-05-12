package domain.vitalsign
{
	public class HeartVitalSign extends VitalSign
	{
		public function HeartVitalSign( value:String = "", description:String = "", lastChgDtm:Date = null,
										method:String = "", position:String = "", sid:Number = 0, site:String = "",
										type:String = "", unit:String = "", alert:Boolean = false ){
			super( value, description, lastChgDtm, method, position, sid, site, type, unit, alert );
		}
		
		public function get pulse():String{
			return super.value;
		}
		
		public function set pulse( value:String ):void{
			super.value = value;
		}
		
		public override function toString():String{
			if( super.value.length == 0 )
				return "";
			if (super.value == VitalSign.defaultValue)
				return super.value;
			
			var intVal:int = int(super.value);
			return intVal + " " + super.unit;
		}
	}
}
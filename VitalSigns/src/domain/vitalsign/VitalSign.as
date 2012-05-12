package domain.vitalsign
{
	import domain.model.IDomainObject;
	
	/**
	 * This class is meant to be an Abstract class, with each vital sign subclass
	 * have its own public accessor and mutator of _value to have a more
	 * significant function name
	 * <BR><BR>
	 * <B>Example: respiration vital sign:</B><BR>
	 * public function get respiration():String{<BR>
	 *       return super.getValue();
	 * <BR>}
	 */
	[Bindable]
	public class VitalSign implements IDomainObject
	{
		private var _alert:Boolean;
		private var _description:String;
		private var _lastChgDtm:Date;
		private var _method:String;
		private var _position:String;
		private var _sid:Number;
		private var _site:String;
		private var _type:String;
		private var _unit:String;
		private var _value:String;
		
		private var _intDate:Number;
		
		public static var defaultValue:String = "- no value -";
		
		public function VitalSign( value:String = "", description:String = "", lastChgDtm:Date = null, method:String = "", position:String = "", 
								   sid:Number = 0, site:String = "", type:String = "", unit:String = "", alert:Boolean = false ){
			_alert = alert;
			_description = description;
			if (!lastChgDtm)
				_lastChgDtm = new Date();
			else
				_lastChgDtm = lastChgDtm;
			_method = method;
			_position = position;
			_sid = sid;
			_site = site;
			_type = type;
			_unit = unit;
			_value = value.length == 0 ? defaultValue : value;
			
			_intDate = _lastChgDtm.valueOf() as Number;
		}
		
		public function set alert( v:Boolean ):void{
			_alert = v;
		}
		
		public function get alert():Boolean{
			return _alert;
		}
		
		public function set description( v:String ):void{
			_description = v;
		}
		
		public function get description():String{
			return _description;
		}
		
		public function set lastChgDtm( v:Date ):void{
			_lastChgDtm = v;
		}
		
		public function get lastChgDtm():Date{
			return _lastChgDtm;
		}
		
		public function set method( v:String ):void{
			_method = getMethodCode( v );
		}
		
		public function get method():String{
			return _method;
		}
		
		public function set position( v:String ):void{
			_position = getPositionCode( v );
		}
		
		public function get position():String{
			return _position;
		}
		
		public function set sid( v:Number ):void{
			_sid = v;
		}
		
		public function get sid():Number{
			return _sid;
		}
		
		public function set site( v:String ):void{
			_site = getSiteCode( v );
		}
		
		public function get site():String{
			return _site;
		}
		
		public function set type( v:String ):void{
			_type = v;
		}
		
		public function get type():String{
			return _type;
		}
		
		public function set unit( v:String ):void{
			_unit = getUnitCode( v );
		}
		
		public function get unit():String{
			return _unit;
		}
		
		public function set value( v:String ):void{
			_value = v;
		}
		
		public function get value():String{
			return _value;
		}
		
		public function set intDate( v:Number ):void{
			_intDate = v;
		}
		
		public function get intDate():Number{
			return _intDate;
		}
		
		public function toString():String{
			if( value.length == 0 )
				return defaultValue;
			return value + " " + unit;
		}
		
		protected function getMethodCode( v:String ):String{
			//throw new Error( "Not implemented" );
			return v;
		}
		
		protected function getPositionCode( v:String ):String{
			//throw new Error( "Not implemented" );
			return v;
		}
		
		protected function getSiteCode( v:String ):String{
			//throw new Error( "Not implemented" );
			return v;
		}
		
		protected function getUnitCode( v:String ):String{
			//throw new Error( "Not implemented" );
			return v;
		}
	}
}
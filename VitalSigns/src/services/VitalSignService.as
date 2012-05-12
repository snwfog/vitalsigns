package services
{
	import mx.rpc.events.FaultEvent;
	
	import services.vitalsignreg.VitalSignReg;
	
	public class VitalSignService
	{
		
		private static var _instance:VitalSignReg = null;
		private static var _forceRenew:Boolean = false;
		
		public function VitalSignService()
		{
			throw new Error( "Access only allowed through static function instance()" );
		}
		
		public static function get instance():VitalSignReg{
			if( _instance == null || _forceRenew ){
				_instance = new VitalSignReg();
				_forceRenew = false;
			}
			return _instance;
		}
		
		public static function set forceRenew( renew:Boolean ):void{
			_forceRenew = renew;
		}
		
		public static function get forceRenew():Boolean{
			return _forceRenew;
		}
		
	}
}
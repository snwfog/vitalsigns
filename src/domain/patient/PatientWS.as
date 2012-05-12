package domain.patient
{
	import domain.wrapper.WrapperWS;
	
	import services.VitalSignService;
	
	import valueObjects.UserDTO;
	
	public class PatientWS extends WrapperWS
	{
		public function PatientWS( resultCallback:Function, faultCallback:Function ){
			super( resultCallback, faultCallback );
		}
		
		public function getPatients( user:UserDTO ):void{
			addCallback( VitalSignService.instance.getPatients( user.site, user.unit ) );
		}
	}
}
package domain.lab
{
	import domain.wrapper.WrapperWS;
	import services.VitalSignService;
	
	import valueObjects.PatientDTO;

	public class LabListWS extends WrapperWS
	{
		public function LabListWS( resultCallback:Function, faultCallback:Function)
		{
			super( resultCallback, faultCallback );
		}
		
		public function getLabList(patient:PatientDTO):void
		{
			addCallback( VitalSignService.instance.getLabList( patient.patientId ) );	
		}
	}
}
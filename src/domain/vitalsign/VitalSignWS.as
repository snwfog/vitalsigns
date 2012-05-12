package domain.vitalsign
{
	import domain.wrapper.WrapperWS;
	
	import services.VitalSignService;
	
	import valueObjects.PatientDTO;
	
	public class VitalSignWS extends WrapperWS
	{
		public function VitalSignWS(resultCallback:Function, faultCallback:Function)
		{
			super(resultCallback, faultCallback);
		}
		
		public function getVitalSigns(patient:PatientDTO):void
		{
			addCallback( VitalSignService.instance.getAllVitalSigns(patient.encounterId));
		}
	}
}
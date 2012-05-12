package domain.command
{
	import domain.IObservable;
	import domain.patient.Patient;
	import domain.patient.PatientAssembler;
	import domain.vitalsign.VitalSign;
	import domain.vitalsign.VitalSignAssembler;
	import domain.vitalsign.VitalSignWS;
	
	import valueObjects.PatientDTO;
		
	public class GetVitalSignsCommand extends Command
	{
		private var _patient:Patient;
		private var _patientAssembler:PatientAssembler;
		private var _assembler:VitalSignAssembler;
		
		public function GetVitalSignsCommand(observable:IObservable, patient:Patient){
			super(observable);
			_patient = patient;
			_patientAssembler = new PatientAssembler();
			_assembler = new VitalSignAssembler();
		}
		
		override public function execute():void{
			var ws:VitalSignWS = new VitalSignWS( resultCallback, faultCallback );
			ws.getVitalSigns(_patientAssembler.createDataTransferObject(_patient) as PatientDTO);
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler( _assembler.createDOArray( resultObject ) );
		}
	}
}
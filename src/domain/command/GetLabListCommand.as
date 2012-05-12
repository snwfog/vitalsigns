package domain.command
{
	import domain.IObservable;
	import domain.lab.LabListAssembler;
	import domain.lab.LabListWS;
	import domain.patient.Patient;
	import domain.patient.PatientAssembler;
	
	import valueObjects.PatientDTO;

	public class GetLabListCommand extends Command
	{
		private var _patient:Patient;
		private var _patientAssembler:PatientAssembler;
		private var _labListAssember:LabListAssembler;
		
		public function GetLabListCommand( observable:IObservable, patient:Patient )
		{
			super(observable);
			_patient = patient;
			_patientAssembler = new PatientAssembler();
			_labListAssember = new LabListAssembler();
		}
		
		override public function execute():void{
			var ws:LabListWS = new LabListWS( resultCallback, faultCallback );
			ws.getLabList(_patientAssembler.createDataTransferObject( _patient ) as PatientDTO);
		}
		
		override protected function resultCallback(resultObject:Object):void{
			_observable.resultHandler( _labListAssember.createDOArray( resultObject ) );
		}
	}
}
package domain.command
{
	import domain.note.NoteAssembler;
	import domain.note.NoteWS;
	import domain.IObservable;
	
	public class GetAllNotesCommand extends Command {
		private var _patientID:int;
		private var _assembler:NoteAssembler;
		
		public function GetAllNotesCommand(observable:IObservable, patientID:int) {
			super(observable);
			_patientID = patientID;
			_assembler = new NoteAssembler();
		}
		
		override public function execute():void {
			var webService:NoteWS = new NoteWS(resultCallback, faultCallback);
			webService.getAllNotesByPatient(_patientID);
		}
		
		override protected function resultCallback(resultObject:Object):void {
			_observable.resultHandler(_assembler.createDOArray(resultObject));
		}
	}
}
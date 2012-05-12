package domain.command
{
	import domain.IObservable;
	import domain.note.Note;
	import domain.note.NoteAssembler;
	import domain.note.NoteWS;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.NoteDTO;

	public class CreateNewNoteCommand extends Command {
		private var _note:Note;
		private var _assembler:NoteAssembler;
		
		public function CreateNewNoteCommand(observable:IObservable, text:String, images:ArrayCollection, authorID:int,
											 patientID:int, creationDate:Date) {
			super(observable);
			_note = new Note(text, authorID, patientID, images, creationDate);
			_assembler = new NoteAssembler();
		}
		
		override public function execute():void {
			var noteWS:NoteWS = new NoteWS(resultCallback, faultCallback);
			noteWS.createNewNote(_assembler.createDataTransferObject(_note) as NoteDTO);
		}
		
		override protected function resultCallback(resultObject:Object):void {
			_observable.resultHandler(_note);
		}
	}
}
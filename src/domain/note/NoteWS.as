package domain.note
{
	import domain.wrapper.WrapperWS;
	import valueObjects.NoteDTO;
	
	import services.VitalSignService;

	public class NoteWS extends WrapperWS {
		public function NoteWS( resultCallback:Function, faultCallback:Function) {
			super(resultCallback, faultCallback);
		}
		
		public function getAllNotesByPatient(patientID:int):void {
			addCallback(VitalSignService.instance.getAllNotes(patientID));
		}
		
		public function createNewNote(noteDTO:NoteDTO):void {
			addCallback(VitalSignService.instance.insertNewNote(noteDTO));
		}
	}
}
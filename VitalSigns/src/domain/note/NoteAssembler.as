package domain.note
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.image.ImageAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.NoteDTO;

	public class NoteAssembler implements IAssembler {
		private var imageAssembler:ImageAssembler = new ImageAssembler();
		
		public function NoteAssembler() {}
		
		public function createDataTransferObject(DomainObject:IDomainObject):IDataTransferObject {
			var note:Note = DomainObject as Note;
			if (note == null)
				return null;
			var result:NoteDTO = new NoteDTO();
			result.authorID = note.getAuthor();
			result.patientID = note.getPatient();
			result._date = note.getDate();
			result.noteText = note.getText();
			result.photos = imageAssembler.createDTOArray(note.getImages());
			return result;
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection {
			if (DOArray == null || DOArray.length == 0)
				return null;
			var result:ArrayCollection = new ArrayCollection();
			for (var index:int = 0; index < DOArray.length; index++)
				result.addItem(createDataTransferObject(DOArray.getItemAt(index) as Note) as NoteDTO);
			return result;
		}
		
		public function createDomainObject(DataTransferObject:IDataTransferObject):IDomainObject {
			var noteDTO:NoteDTO = DataTransferObject as NoteDTO;
			if (noteDTO == null)
				return null;
			var note:Note = new Note();
			note.setAuthor(noteDTO.authorID);
			note.setDate(noteDTO._date);
			note.setImages(this.imageAssembler.createDOArray(noteDTO.photos));
			note.setPatient(noteDTO.patientID);
			note.setText(noteDTO.noteText);
			return note;
		}
		
		public function createDOArray(DTOArray:Object):ArrayCollection {
			if (DTOArray == null)
				return new ArrayCollection();
			var arrDTOs:ArrayCollection;
			var arrNotes:ArrayCollection = new ArrayCollection();
			
			if (DTOArray is ArrayCollection)
				arrDTOs = DTOArray as ArrayCollection;
			else
				arrDTOs = new ArrayCollection([this.buildDTOFromObjectProxy(DTOArray as ObjectProxy)]);
			
			for(var index:int = 0; index < arrDTOs.length; index++)
				arrNotes.addItem(this.createDomainObject(arrDTOs.getItemAt(index) as NoteDTO) as Note);
			return arrNotes;
		}
		
		public function buildDTOFromObjectProxy(proxy:ObjectProxy):IDataTransferObject {
			var dto:NoteDTO = new NoteDTO();
			dto.authorID = proxy.authorID;
			dto._date = proxy._date;
			dto.patientID = proxy.patientID;
			dto.noteText = proxy.noteText;
			dto.noteID = proxy.noteID;
			dto.photos = proxy.photos;
			return dto;
		}
	}
}
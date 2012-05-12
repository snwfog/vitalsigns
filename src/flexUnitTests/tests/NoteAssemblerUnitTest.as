package flexUnitTests.tests
{
	import domain.note.Note;
	import domain.note.NoteAssembler;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.NoteDTO;

	public class NoteAssemblerUnitTest
	{		
		private var noteDO:Note;
		private var noteDTO:NoteDTO;
		private var noteAssembler:NoteAssembler;
		private var noteDOArray:ArrayCollection;
		private var noteDTOArray:ArrayCollection;
		[Before]
		public function setUp():void
		{
			noteAssembler = new NoteAssembler();
			//CREATING NOTE DO
			noteDO = new Note("hello world", 10, 6, null, null);
			var imageObject:ArrayCollection = new ArrayCollection();
			//imageObject.addItem("kl");
			noteDO.setImages(imageObject);
			
			//CREATING NOTE DTO
			noteDTO = new NoteDTO();
			noteDTO._date = new Date(2012,1,12,5,6,54);
			noteDTO.authorID = 6;
			noteDTO.noteID = 44;
			noteDTO.noteText = "How are you?";
			noteDTO.patientID =1908;
			var image:ArrayCollection = new ArrayCollection();
			//image.addItem("fw");
			noteDTO.photos = image;
			
			//CREATING ARRAYS
			noteDOArray = new ArrayCollection();
			noteDTOArray = new ArrayCollection();
			
			for(var i:int = 0; i <= 8; i++){
				noteDOArray.addItem(noteDO);
				noteDTOArray.addItem(noteDTO);
			}
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function createDataTransferObjectTest():void{
			var dto:NoteDTO = noteAssembler.createDataTransferObject(this.noteDO) as NoteDTO;
			Assert.assertEquals(dto._date, this.noteDO.getDate());
			Assert.assertEquals(dto.authorID, this.noteDO.getAuthor());
			Assert.assertEquals(dto.patientID, this.noteDO.getPatient());
			Assert.assertEquals(dto.noteText, this.noteDO.getText());
			//Assert.assertEquals(dto.photos.getItemAt(0), this.noteDO.getImages().getItemAt(0))
			
		}
		
		[Test]
		public function createDomainObjectTest():void{
			var note:Note = noteAssembler.createDomainObject(this.noteDTO) as Note;
			Assert.assertEquals(note.getDate(), this.noteDTO._date);
			Assert.assertEquals(note.getAuthor(), this.noteDTO.authorID);
			Assert.assertEquals(note.getPatient(), this.noteDTO.patientID)
			Assert.assertEquals(note.getText(), this.noteDTO.noteText);
		}
		
		[Test]
		public function buildDTOFromObjectProxyTest():void{
			var objProxy:ObjectProxy = new ObjectProxy(this.noteDTO);
			var proxy:NoteDTO = noteAssembler.buildDTOFromObjectProxy(objProxy) as NoteDTO;
			Assert.assertEquals(proxy._date, this.noteDTO._date);
			Assert.assertEquals(proxy.authorID, this.noteDTO.authorID);
			Assert.assertEquals(proxy.patientID, this.noteDTO.patientID);
			Assert.assertEquals(proxy.noteText, this.noteDTO.noteText);
			Assert.assertEquals(proxy.noteID, this.noteDTO.noteID);
			
		}
		
		[Test]
		public function createDTOArrayTest():void{
			var noteArray:ArrayCollection = noteAssembler.createDTOArray(this.noteDOArray);
			Assert.assertNotNull(noteArray);
			Assert.assertEquals(noteArray.length, this.noteDOArray.length);
			for(var i:int = 0; i < noteArray.length; i++){
				Assert.assertTrue( noteArray[i] is NoteDTO );
			}
			Assert.assertNull(noteAssembler.createDTOArray(null));
			var emptyArray:ArrayCollection = new ArrayCollection();
			noteArray = noteAssembler.createDTOArray(emptyArray);
			Assert.assertNull(noteArray);
		}
		
		[Test]
		public function createDOArrayTest():void{
			var noteArray:ArrayCollection = noteAssembler.createDOArray(this.noteDTOArray);
			Assert.assertNotNull(noteArray);
			Assert.assertEquals(noteArray.length, this.noteDTOArray.length);
			for(var i:int = 0; i < noteArray.length; i++){
				Assert.assertTrue( noteArray[i] is Note );
			}
			Assert.assertEquals(noteAssembler.createDOArray(null).length, 0);
			
		}
	}
}
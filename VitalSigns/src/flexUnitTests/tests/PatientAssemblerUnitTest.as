package flexUnitTests.tests
{
	import domain.patient.Patient;
	import domain.patient.PatientAssembler;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import org.hamcrest.object.instanceOf;
	
	import valueObjects.PatientDTO;
	
	public class PatientAssemblerUnitTest
	{		
		
		private var patientDTO:PatientDTO;
		private var patientDO:Patient;
		private var patientAssembler:PatientAssembler;
		private var patientDTOArray:ArrayCollection;
		private var room:String;
		private var bed:String;
		[Before]
		public function setUp():void
		{
			//Init. PatientAssembler
			patientAssembler = new PatientAssembler;
			//Creating Patient DTO
			room = "1004";
			bed = "B";
			this.patientDTO = new PatientDTO();
			this.patientDTO.address = "Mount Olympus";
			this.patientDTO.bed = room+"-"+bed;
			this.patientDTO.birthDate = new Date(1966, 1, 1);
			this.patientDTO.city = "Mars";
			this.patientDTO.doctor = "Darth Vader";
			this.patientDTO.doctorTel = "555-555-5555";
			this.patientDTO.encounterId = 3;
			this.patientDTO.enFillerNum = "1";
			this.patientDTO.extAppId = "3";
			this.patientDTO.firstName = "Kirk";
			this.patientDTO.height = 6.0;
			this.patientDTO.heightUnit = "ft";
			this.patientDTO.lastName = "James";
			this.patientDTO.mrn = "LALA";
			this.patientDTO.nursingUnit ="HHH";
			this.patientDTO.patientId = 3;
			this.patientDTO.postalCode = "H0H 0H0"
			this.patientDTO.province = "Sol";
			this.patientDTO.readOnly =false;
			this.patientDTO.sexCd = "male";
			this.patientDTO.weight = 135;
			this.patientDTO.weightUnit = "pound";
			
			//CREATING PATIENT DO
			this.patientDO = new Patient();
			this.patientDO.address = "Kepler-10 b";
			this.patientDO.bed = "A";
			this.patientDO.birthDate = new Date(1985,12,12);
			this.patientDO.city = "Draco";
			this.patientDO.doctor = "Mordin Solus";
			this.patientDO.doctorTel = "333-333-3333";
			this.patientDO.encounterId = 4;
			this.patientDO.enFillerNum = "2";
			this.patientDO.extAppId = "3";
			this.patientDO.firstName = "Javik";
			this.patientDO.height = 6.2;
			this.patientDO.heightUnit = "ft";
			this.patientDO.lastName = "Corian";
			this.patientDO.mrn = "SSS";
			this.patientDO.nursingUnit = "Statis";
			this.patientDO.patientId = 3;
			this.patientDO.postalCode = "R45648";
			this.patientDO.province = "Milky Way";
			this.patientDO.readOnly = false;
			this.patientDO.room = "1008";
			this.patientDO.sexCd = "male";
			this.patientDO.weight = 130;
			this.patientDO.weightUnit = "pound";
			
			//CREATING PATIENT DTO ARRAY
			this.patientDTOArray = new ArrayCollection();
			for(var i:int = 0; i<= 4; i++){
				this.patientDTOArray.addItem(patientDTO);
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
			var objectDTO:PatientDTO = patientAssembler.createDataTransferObject(this.patientDO) as PatientDTO;
			Assert.assertEquals(objectDTO.address, this.patientDO.address);
			Assert.assertEquals(objectDTO.patientId, this.patientDO.patientId);
			Assert.assertEquals(objectDTO.bed, this.patientDO.bed);
			Assert.assertEquals(objectDTO.birthDate, this.patientDO.birthDate);
			Assert.assertEquals(objectDTO.city, this.patientDO.city);
			Assert.assertEquals(objectDTO.doctor, this.patientDO.doctor);
			Assert.assertEquals(objectDTO.doctorTel, this.patientDO.doctorTel);
			Assert.assertEquals(objectDTO.encounterId, this.patientDO.encounterId);
			Assert.assertEquals(objectDTO.enFillerNum, this.patientDO.enFillerNum);
			Assert.assertEquals(objectDTO.extAppId, this.patientDO.extAppId);
			Assert.assertEquals(objectDTO.firstName, this.patientDO.firstName);
			Assert.assertEquals(objectDTO.height, this.patientDO.height);
			Assert.assertEquals(objectDTO.heightUnit, this.patientDO.heightUnit);
			Assert.assertEquals(objectDTO.lastName, this.patientDO.lastName);
			Assert.assertEquals(objectDTO.mrn, this.patientDO.mrn);
			Assert.assertEquals(objectDTO.nursingUnit, this.patientDO.nursingUnit);
			Assert.assertEquals(objectDTO.postalCode, this.patientDO.postalCode);
			Assert.assertEquals(objectDTO.province, this.patientDO.province);
			Assert.assertEquals(objectDTO.readOnly, this.patientDO.readOnly);
			Assert.assertEquals(objectDTO.room, this.patientDO.room);
			Assert.assertEquals(objectDTO.sexCd, this.patientDO.sexCd);
			Assert.assertEquals(objectDTO.weight, this.patientDO.weight);
			Assert.assertEquals(objectDTO.weightUnit, this.patientDO.weightUnit);
			
		}
		
		[Test]
		public function createDomainObjectTest():void{
			var objectDO:Patient = patientAssembler.createDomainObject(patientDTO) as Patient;
			Assert.assertEquals(objectDO.address, this.patientDTO.address);
			Assert.assertEquals(objectDO.patientId, this.patientDTO.patientId);
			Assert.assertEquals(objectDO.bed, this.bed);
			Assert.assertEquals(objectDO.birthDate, this.patientDTO.birthDate);
			Assert.assertEquals(objectDO.city, this.patientDTO.city);
			Assert.assertEquals(objectDO.doctor, this.patientDTO.doctor);
			Assert.assertEquals(objectDO.doctorTel, this.patientDTO.doctorTel);
			Assert.assertEquals(objectDO.encounterId, this.patientDTO.encounterId);
			Assert.assertEquals(objectDO.enFillerNum, this.patientDTO.enFillerNum);
			Assert.assertEquals(objectDO.extAppId, this.patientDTO.extAppId);
			Assert.assertEquals(objectDO.firstName, this.patientDTO.firstName);
			Assert.assertEquals(objectDO.height, this.patientDTO.height);
			Assert.assertEquals(objectDO.heightUnit, this.patientDTO.heightUnit);
			Assert.assertEquals(objectDO.lastName, this.patientDTO.lastName);
			Assert.assertEquals(objectDO.mrn, this.patientDTO.mrn);
			Assert.assertEquals(objectDO.nursingUnit, this.patientDTO.nursingUnit);
			Assert.assertEquals(objectDO.postalCode, this.patientDTO.postalCode);
			Assert.assertEquals(objectDO.province, this.patientDTO.province);
			Assert.assertEquals(objectDO.readOnly, this.patientDTO.readOnly);
			Assert.assertEquals(objectDO.room, this.room);
			Assert.assertEquals(objectDO.sexCd, this.patientDTO.sexCd);
			Assert.assertEquals(objectDO.weight, this.patientDTO.weight);
			Assert.assertEquals(objectDO.weightUnit, this.patientDTO.weightUnit);
		}
		
		[Test]
		public function createDOArrayTest():void{
			var patientDOArray:ArrayCollection = patientAssembler.createDOArray(this.patientDTOArray);
			Assert.assertEquals(patientDOArray.length, patientDTOArray.length);
			Assert.assertNotNull(patientDOArray);
			for(var i:int = 0; i < patientDOArray.length; i++){
				Assert.assertTrue( patientDOArray[i] is Patient );
			}
		}
		
		[Test]
		public function buildDTOFromObjectProxyTest():void{
			var objProxy:ObjectProxy = new ObjectProxy(this.patientDTO);
			var dto:PatientDTO = patientAssembler.buildDTOFromObjectProxy(objProxy) as PatientDTO;
			Assert.assertEquals(dto.address, this.patientDTO.address);
			Assert.assertEquals(dto.patientId, this.patientDTO.patientId);
			Assert.assertEquals(dto.bed, this.bed);
			Assert.assertEquals(dto.birthDate, this.patientDTO.birthDate);
			Assert.assertEquals(dto.city, this.patientDTO.city);
			Assert.assertEquals(dto.doctor, this.patientDTO.doctor);
			Assert.assertEquals(dto.doctorTel, this.patientDTO.doctorTel);
			Assert.assertEquals(dto.encounterId, this.patientDTO.encounterId);
			Assert.assertEquals(dto.enFillerNum, this.patientDTO.enFillerNum);
			Assert.assertEquals(dto.extAppId, this.patientDTO.extAppId);
			Assert.assertEquals(dto.firstName, this.patientDTO.firstName);
			Assert.assertEquals(dto.height, this.patientDTO.height);
			Assert.assertEquals(dto.heightUnit, this.patientDTO.heightUnit);
			Assert.assertEquals(dto.lastName, this.patientDTO.lastName);
			Assert.assertEquals(dto.mrn, this.patientDTO.mrn);
			Assert.assertEquals(dto.nursingUnit, this.patientDTO.nursingUnit);
			Assert.assertEquals(dto.postalCode, this.patientDTO.postalCode);
			Assert.assertEquals(dto.province, this.patientDTO.province);
			Assert.assertEquals(dto.readOnly, this.patientDTO.readOnly);
			Assert.assertEquals(dto.room, this.room);
			Assert.assertEquals(dto.sexCd, this.patientDTO.sexCd);
			Assert.assertEquals(dto.weight, this.patientDTO.weight);
			Assert.assertEquals(dto.weightUnit, this.patientDTO.weightUnit);		
		}
		
	}
}
package flexUnitTests.tests
{
	import application.controller.PatientListController;
	
	import domain.patient.Patient;
	
	import flash.events.MouseEvent;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.BusyIndicator;
	
	public class PatientListControllerUnitTest extends PatientListController
	{	
		private var patient1:Patient;
		private var patient2:Patient;
		private var patientArray:ArrayCollection;
		private var event:MouseEvent; 
		
		public function PatientListControllerUnitTest(){
			super(false);
			addElement(busyIndicator);
		}
		
		[Before]
		public function setUp():void
		{
			event = new MouseEvent("click");
			//CREATING PATIENT 1
			patient1 = new Patient();
			patient1.address = "Kepler-10 b";
			patient1.bed = "K";
			patient1.birthDate = new Date(1985,8,9);
			patient1.city = "Draco";
			patient1.doctor = "Mordin Solus";
			patient1.doctorTel = "333-333-3333";
			patient1.encounterId = 4;
			patient1.enFillerNum = "2";
			patient1.extAppId = "3";
			patient1.firstName = "Javik";
			patient1.height = 6.2;
			patient1.heightUnit = "ft";
			patient1.lastName = "Corian";
			patient1.mrn = "SSS";
			patient1.nursingUnit = "Statis";
			patient1.patientId = 3;
			patient1.postalCode = "R45648";
			patient1.province = "Milky Way";
			patient1.readOnly = false;
			patient1.room = "1008";
			patient1.sexCd = "male";
			patient1.weight = 130;
			patient1.weightUnit = "pound";
			
			//CREATING PATIENT 2
			patient2 = new Patient();
			patient2.address = "Kepler";
			patient2.bed = "A";
			patient2.birthDate = new Date(1985,8,3);
			patient2.city = "Bear";
			patient2.doctor = "Fuma";
			patient2.doctorTel = "334-343-3443";
			patient2.encounterId = 6;
			patient2.enFillerNum = "8";
			patient2.extAppId = "12";
			patient2.firstName = "Grunt";
			patient2.height = 6.5;
			patient2.heightUnit = "ft";
			patient2.lastName = "Krogan";
			patient2.mrn = "SYS";
			patient2.nursingUnit = "Stat";
			patient2.patientId = 4;
			patient2.postalCode = "R44548";
			patient2.province = "Somewhere";
			patient2.readOnly = false;
			patient2.room = "1003";
			patient2.sexCd = "male";
			patient2.weight = 300;
			patient2.weightUnit = "pound";
			
			//Add to ARRAY
			patientArray = new ArrayCollection();
			patientArray.addItem(patient1);
			patientArray.addItem(patient2);
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
		public function testResultHandler():void
		{
			resultHandler(patientArray);
			var result:ArrayCollection = sortedList;
			Assert.assertEquals( result.length, patientArray.length);
			Assert.assertEquals( result[0].separator, patient1.lastName.charAt(0));
			Assert.assertEquals( result[1].separator, patient2.lastName.charAt(0));
			
		}
		
		[Test]
		public function testGetRoomInfo():void
		{	
			sortbyname_clickHandler(event);
			var roomInfo:String = getRoomInfo(patient1);
			Assert.assertEquals(roomInfo, patient1.room + "-" + patient1.bed);
			
			sortbyroom_clickHandler(event);
			roomInfo =  getRoomInfo(patient2);
			Assert.assertEquals(roomInfo, patient2.bed);
		}
		
		[Test]
		public function testsortByRoom():void{
			resultHandler(patientArray);
			sortbyroom_clickHandler(event);
			var result:ArrayCollection = sortedList;
			
			Assert.assertEquals( result.length, patientArray.length);
			Assert.assertEquals( result[0].separator, patient2.room);
			Assert.assertEquals( result[1].separator, patient1.room);
		}
		
		
		
	}
}
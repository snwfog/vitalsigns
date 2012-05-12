package flexUnitTests.tests
{
	import application.controller.PatientProfileController;
	
	import domain.patient.Patient;
	
	import flexunit.framework.Assert;

	public class PatientProfileControllerUnitTest extends PatientProfileController
	{		
		private var patientDO:Patient;
		
		public function PatientProfileControllerUnitTest(){
			super(false);
		}
		
		[Before]
		public function setUp():void
		{
			patientDO = new Patient();
			//CREATING PATIENT DO
			patientDO = new Patient();
			patientDO.address = "Kepler-10 b";
			patientDO.bed = "A";
			patientDO.birthDate = new Date(1985,8,12);
			patientDO.city = "Draco";
			patientDO.doctor = "Mordin Solus";
			patientDO.doctorTel = "333-333-3333";
			patientDO.encounterId = 4;
			patientDO.enFillerNum = "2";
			patientDO.extAppId = "3";
			patientDO.firstName = "Javik";
			patientDO.height = 6.2;
			patientDO.heightUnit = "ft";
			patientDO.lastName = "Corian";
			patientDO.mrn = "SSS";
			patientDO.nursingUnit = "Statis";
			patientDO.patientId = 3;
			patientDO.postalCode = "R45648";
			patientDO.province = "Milky Way";
			patientDO.readOnly = false;
			patientDO.room = "1008";
			patientDO.sexCd = "male";
			patientDO.weight = 130;
			patientDO.weightUnit = "pound";

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
		public function CreatingProfileTest():void 
		{
			creatingProfile(patientDO);
			var date:Date = new Date();
			Assert.assertEquals(age_Month, (date.month) - patientDO.birthDate.month);
			Assert.assertEquals(age_Year, (date.fullYear) - patientDO.birthDate.fullYear);
			Assert.assertEquals(patientName, patientDO.lastName + ", " + patientDO.firstName);
		}
	}
}
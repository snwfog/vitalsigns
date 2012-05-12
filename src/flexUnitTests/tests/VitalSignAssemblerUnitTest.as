package flexUnitTests.tests
{
	import domain.vitalsign.AllVitalSigns;
	import domain.vitalsign.VitalSign;
	import domain.vitalsign.VitalSignAssembler;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.VitalSignDTO;
	
	public class VitalSignAssemblerUnitTest extends VitalSignAssembler
	{	
		private var vitalSignDTO:VitalSignDTO;
		private var vitalSignArray:ArrayCollection;
		
		[Before]
		public function setUp():void
		{
			this.vitalSignArray = new ArrayCollection();
			
			vitalSignDTO = new VitalSignDTO();
			vitalSignDTO.sid = 1;
			vitalSignDTO.unit1 = "mml";
			vitalSignDTO.unit2 = "g";
			vitalSignDTO.type = "SYSTOLIC"
			vitalSignDTO.type1 = "diabetic";
			vitalSignDTO.type2 = "type 2";
			vitalSignDTO.value1 = "11";
			vitalSignDTO.value2 = "30";
			vitalSignDTO.lastChgDtm = new Date(2011,08,15,7,45,32);
			vitalSignDTO.intDate = 2011;
			vitalSignDTO.description = "Hello EveryBody";
			vitalSignDTO.method = "good work";
			vitalSignDTO.unit = "gmml";
			vitalSignDTO.value = "200";
			vitalSignDTO.site = "FGR";
			vitalSignDTO.position = "up";
			
			
			vitalSignArray.addItem(vitalSignDTO);
			
			vitalSignDTO = new VitalSignDTO();
			vitalSignDTO.sid = 2;
			vitalSignDTO.unit1 = "%";
			vitalSignDTO.unit2 = "L";
			vitalSignDTO.type = "DIASTOLIC";
			vitalSignDTO.type1 = "blood";
			vitalSignDTO.type2 = "WBC";
			vitalSignDTO.value1 = "45";
			vitalSignDTO.value2 = "78";
			vitalSignDTO.lastChgDtm = new Date(2011,08,15,7,45,32);
			vitalSignDTO.intDate = 2010;
			vitalSignDTO.description = "Happy Birthday";
			vitalSignDTO.method = "working";
			vitalSignDTO.unit = "L";
			vitalSignDTO.value = "30";
			vitalSignDTO.site = "FGR";
			vitalSignDTO.position = "udown";
			
			
			vitalSignArray.addItem(vitalSignDTO);
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
		//Also testing for createDomainObject, which in turn test for VitalSignFactory createDomainObjectFromDTO

		[Test]
		public function testCreateDOArray():void
		{
			var resultArray:ArrayCollection = createDOArray(vitalSignArray);
			Assert.assertEquals(resultArray[0].type, vitalSignArray[0].type);
			Assert.assertEquals(resultArray.length, 1);
			
		}
	}
}
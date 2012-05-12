package flexUnitTests.tests
{
	import application.controller.DataConfirmationController;
	
	import flexunit.framework.Assert;
	
	public class DataConfirmationControllerUnitTest extends DataConfirmationController
	{		
		
		public function DataConfirmationControllerUnitTest():void{
			super();
		}
		[Before]
		public function setUp():void
		{
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
		public function testBpStateCheck():void
		{
			setBloodPressureSite("D");
			setBloodPressurePosition("D");
			Assert.assertFalse(bloodSiteBool);
			setBloodPressureCuff("D");
			setBloodPressureValue("D");
			Assert.assertTrue(bloodSiteBool);
		}
		
		[Test]
		public function testBradenStateCheck():void
		{
			setBradenSensory("E");
			setBradenMobility("E");
			setBradenMoisture("E");
			Assert.assertFalse(bradBool);
			setBradenActivity("E");
			setBradenNutrition("E");
			setBradenFriction("E");
			Assert.assertTrue(bradBool);
		}
		
		[Test]
		public function testHeartStateCheck():void
		{
			setHeartRateSite("P");
			Assert.assertFalse(heartSiteBool);
			setHeartRateValue("s");
			setPulseRate("I");
			Assert.assertTrue(heartSiteBool);
		}
		
		[Test]
		public function testOxDevStateCheck():void
		{
			setOxygenDevice("O");
			setIntakeUnit("I");
			Assert.assertFalse(oxyDevBool);
			setOxygenValue("T");
			Assert.assertTrue(oxyDevBool);
		}
		
		[Test]
		public function testOxSatStateCheck():void
		{
			setOxygenSaturationSite("L");
			Assert.assertFalse(oxySatBool);
			setOxygenSaturationValue("J");
			Assert.assertTrue(oxySatBool);
		}
		
		[Test]
		public function testPainStateCheck():void
		{
			Assert.assertFalse(pnBool);
			setPainscale("D");
			Assert.assertTrue(pnBool);
		}
		
		[Test]
		public function testResetAllFields():void
		{
			resetAllFields();
			Assert.assertFalse(respRateBool);
			Assert.assertFalse(oxySatBool);
			Assert.assertFalse(pnBool);
		}
		
		[Test]
		public function testRespStateCheck():void
		{
			Assert.assertFalse(respRateBool);
			setRespirationRate("lalalalalala");
			Assert.assertTrue(respRateBool);
		}
		
		[Test]
		public function testTempStateCheck():void
		{
			setTemperatureSite("h");
			Assert.assertFalse(tempSiteBool);
			setTemperatureValue("g");
			Assert.assertTrue(tempSiteBool);
		}
		
		[Test]
		public function testHeightStateCheck():void
		{
			setHeightMeasurementMethod("Y");
			Assert.assertFalse(htBool);
			setHeightCms("Y");
			Assert.assertTrue(htBool);
		}
		
		[Test]
		public function testWeightStateCheck():void
		{
			setWeightMeasurementMethod("Y");
			Assert.assertFalse(wtBool);
			setWeightKgs("Y");
			Assert.assertTrue(wtBool);
		}
	}
}
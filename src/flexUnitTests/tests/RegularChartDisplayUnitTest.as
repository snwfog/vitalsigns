package flexUnitTests.tests
{
	import application.controller.chart.ChartController;
	import application.controller.chart.strategy.RegularChartDisplay;
	
	import domain.patient.Patient;
	import domain.vitalsign.TemperatureVitalSign;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	public class RegularChartDisplayUnitTest
	{		
		private var patient:Patient;
		
		private var chartController:ChartController;
		
		private var tempVitalSign:TemperatureVitalSign;
		private var tempArray:ArrayCollection;
		
		private var regularChart:RegularChartDisplay;
		
		[Before]
		public function setUp():void
		{
			this.chartController = new ChartController(false);
			//CREATING PATIENT DO
			
			patient = new Patient();
			patient.address = "Kepler-10 b";
			patient.bed = "A";
			patient.birthDate = new Date(1985,8,12);
			patient.city = "Draco";
			patient.doctor = "Mordin Solus";
			patient.doctorTel = "333-333-3333";
			patient.encounterId = 4;
			patient.enFillerNum = "2";
			patient.extAppId = "3";
			patient.firstName = "Javik";
			patient.height = 6.2;
			patient.heightUnit = "ft";
			patient.lastName = "Corian";
			patient.mrn = "SSS";
			patient.nursingUnit = "Statis";
			patient.patientId = 3;
			patient.postalCode = "R45648";
			patient.province = "Milky Way";
			patient.readOnly = false;
			patient.room = "1008";
			patient.sexCd = "male";
			patient.weight = 130;
			patient.weightUnit = "pound";
			
			//CREATING TEMP ARRAY
			tempArray= new ArrayCollection();
			tempVitalSign = new TemperatureVitalSign("35", "Ok", new Date(2011,5,6), "mouth", "none", 1, "FFG", "fever", "celcius", false);
			tempArray.addItem(tempVitalSign);
			tempVitalSign = new TemperatureVitalSign("37", "Ok", new Date(2011,5,7), "arm", "left", 2, "FFG", "fever", "celcius", false);
			tempArray.addItem(tempVitalSign);
			tempVitalSign = new TemperatureVitalSign("30", "Ok", new Date(2011,5,8), "arm", "right", 1, "FFG", "fever", "celcius", false);
			tempArray.addItem(tempVitalSign);
			
			regularChart = new RegularChartDisplay(patient, tempArray, "Temperature" );
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
		public function testPrepareData():void
		{
			regularChart.prepareData(chartController);
			var resultArray:ArrayCollection = this.chartController.lstChart;
			Assert.assertEquals(resultArray.length, tempArray.length );
			Assert.assertEquals(resultArray.length, chartController.arrRawData.length );
			Assert.assertEquals(resultArray[0].temperature, tempArray[0].temperature);
			Assert.assertEquals(resultArray[2].temperature, tempArray[2].temperature);
		}
	}
}
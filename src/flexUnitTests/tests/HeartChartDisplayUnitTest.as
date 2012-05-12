package flexUnitTests.tests
{
	import application.controller.chart.ChartController;
	import application.controller.chart.strategy.HeartChartDisplay;
	
	import domain.patient.Patient;
	import domain.vitalsign.BloodPressureVitalSign;
	import domain.vitalsign.HeartVitalSign;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	public class HeartChartDisplayUnitTest
	{		
		private var patient:Patient;
		
		private var chartController:ChartController;
		
		private var heartVitalSign:HeartVitalSign;
		private var heartArray:ArrayCollection;
		
		private var bpVitalSign:BloodPressureVitalSign;
		private var bpArray:ArrayCollection;
		
		private var heartChart:HeartChartDisplay;
		
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
			
			//CREATING OXYGEN ARRAY
			heartArray = new ArrayCollection();
			heartVitalSign = new HeartVitalSign("67", "heart testing", new Date(2011,6,8), "chest", "left", 10, "MGF", "heart rate", "rmp", false);
			heartArray.addItem(heartVitalSign);
			heartVitalSign = new HeartVitalSign("76", "heart testing", new Date(2011,6,9), "chest", "none", 8, "MGF", "heart rate", "rmp", false);
			heartArray.addItem(heartVitalSign);
		
			
			//CREATING SATURATION ARRAY
			bpArray = new ArrayCollection();
			bpVitalSign =  new BloodPressureVitalSign("140","80" ,"bp testing", new Date(2011,6,8), "arm", "left", 10, "MGF", "bp", "mml", false); 
			bpArray.addItem(bpVitalSign);
			bpVitalSign =  new BloodPressureVitalSign("135","99" ,"bp testing", new Date(2011,6,9), "arm", "right", 8, "MGF", "bp", "mml", false); 
			bpArray.addItem(bpVitalSign);
		
			heartChart = new HeartChartDisplay(patient, bpArray, heartArray);
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
			heartChart.prepareData(chartController);
			var resultArray:ArrayCollection = chartController.lstChart;
			Assert.assertEquals(resultArray.length, chartController.arrRawData.length );
			Assert.assertEquals(resultArray[0].rate, heartArray[1].pulse );
			Assert.assertEquals(resultArray[0].diastolic, bpArray[1].diastolic);
			Assert.assertEquals(resultArray[0].lastChgDtm, heartArray[1].lastChgDtm);
			
		}
	}
}
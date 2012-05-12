package flexUnitTests.tests
{
	import application.controller.chart.ChartController;
	import application.controller.chart.strategy.OxygenChartDisplay;
	
	import domain.patient.Patient;
	import domain.vitalsign.OxygenVitalSign;
	import domain.vitalsign.SaturationVitalSign;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	public class OxygenChartDisplayUnitTest
	{		
		private var patient:Patient;
		
		private var chartController:ChartController;
		
		private var oxygenVitalSign:OxygenVitalSign;
		private var oxygenArray:ArrayCollection;
		
		private var saturationVitalSign:SaturationVitalSign;
		private var saturationArray:ArrayCollection;
		
		private var oxygenChart:OxygenChartDisplay;
		
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
			oxygenArray = new ArrayCollection();
			oxygenVitalSign = new OxygenVitalSign("75", "oxygen testing", null, "noise", "left", 4, "MGF", "oxygen", "%", false);
			oxygenArray.addItem(oxygenVitalSign);
			oxygenVitalSign = new OxygenVitalSign("90", "oxygen testing", null, "mouth", "none", 3, "MGF", "oxygen", "%", false);
			oxygenArray.addItem(oxygenVitalSign);
			oxygenVitalSign = new OxygenVitalSign("34", "oxygen testing", null, "mouth", "none", 9, "MGF", "oxygen", "%", false);
			oxygenArray.addItem(oxygenVitalSign);
			oxygenVitalSign = new OxygenVitalSign("90", "oxygen testing", null, "mouth", "none", 3, "MGF", "oxygen", "%", false);
			oxygenArray.addItem(oxygenVitalSign);
			
			//CREATING SATURATION ARRAY
			saturationArray = new ArrayCollection();
			saturationVitalSign =  new SaturationVitalSign("98", "oxygen testing", null, "noise", "left", 10, "MGF", "oxygen", "%", false); 
			saturationArray.addItem(saturationVitalSign);
			saturationVitalSign =  new SaturationVitalSign("76", "oxygen testing", null, "noise", "left", 14, "MGF", "oxygen", "%", false); 
			saturationArray.addItem(saturationVitalSign);
			saturationVitalSign =  new SaturationVitalSign("88", "oxygen testing", null, "noise", "left", 24, "MGF", "oxygen", "%", false); 
			saturationArray.addItem(saturationVitalSign);
			saturationVitalSign =  new SaturationVitalSign("88", "oxygen testing", null, "noise", "left", 24, "MGF", "oxygen", "%", false); 
			saturationArray.addItem(saturationVitalSign);
			
			oxygenChart = new OxygenChartDisplay(patient, oxygenArray, saturationArray);
			
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
			oxygenChart.prepareData(chartController);
			var resultArray:ArrayCollection = chartController.lstChart;
			Assert.assertEquals(resultArray.length, chartController.arrRawData.length );
			Assert.assertEquals(resultArray[0].saturation, saturationArray[3].value);
			Assert.assertEquals(resultArray[0].oxygen, oxygenArray[3].value );
			Assert.assertEquals(resultArray[3].oxygen,"- no value -");
			
		}
	}
}
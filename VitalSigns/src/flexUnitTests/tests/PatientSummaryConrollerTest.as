package flexUnitTests.tests
{
	import application.controller.PatientSummaryController;
	import application.controller.SummaryAccordionController;
	
	import domain.vitalsign.AllVitalSigns;
	import domain.vitalsign.BloodPressureVitalSign;
	import domain.vitalsign.HeartVitalSign;
	import domain.vitalsign.TemperatureVitalSign;
	import domain.vitalsign.VitalSign;
	import domain.vitalsign.VitalSignList;
	
	import flashx.textLayout.debug.assert;
	
	import model.DataEntryData;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.BusyIndicator;
	import valueObjects.VitalSignDTO;

	public class PatientSummaryConrollerTest extends PatientSummaryController
	{		
		private var vitalSignsArray:ArrayCollection;
		private var allVitalSigns:AllVitalSigns;
		private var vslist:VitalSignList;
		
		private var tempArray:ArrayCollection = new ArrayCollection();
		private var heartArray:ArrayCollection = new ArrayCollection();
		private var bpArray:ArrayCollection = new ArrayCollection();
		
		public function PatientSummaryConrollerTest(){
			super();
		}
		
		[Before]
		public function setUp():void
		{
			vitalSignsArray = new ArrayCollection();
			accordion = new SummaryAccordionController();
			busyIndicator = new BusyIndicator()
			addElement( busyIndicator );
			
			allVitalSigns = new AllVitalSigns();
			var i:int
			for (i = 0; i < 6; i++) {
				var tvs:VitalSignDTO = new VitalSignDTO();
				tvs.lastChgDtm = new Date(2012, i, 1, 0, 0, 0, 0);
				tvs.type = "TEMPERATURE";
				tvs.value = "33";
				tempArray.addItem(tvs);
			}
			vslist = new VitalSignList("TEMPERATURE");
			vslist.list = tempArray;
			vitalSignsArray.addItem(vslist);
			
			for (i = 0; i < 6; i++) {
				var hvs:VitalSignDTO = new VitalSignDTO();
				hvs.lastChgDtm = new Date(2012, i, 1, 0, 0, 0, 0);
				hvs.type = "PULSE";
				hvs.value = "55";
				heartArray.addItem(hvs);
			}
			vslist = new VitalSignList("HEARTRATE");
			vslist.list = heartArray;
			vitalSignsArray.addItem(vslist);
			
			for (i = 0; i < 6; i += 2) {
				var bpvs:VitalSignDTO = new VitalSignDTO();
				bpvs.lastChgDtm = new Date(2012, i, 1, 0, 0, 0, 0);
				bpvs.type = "SYSTOLIC";
				bpvs.value = "66";
				bpArray.addItem(bpvs);
			}
			vslist = new VitalSignList("SYSTOLIC");
			vslist.list = bpArray;
			vitalSignsArray.addItem(vslist);
			
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
		public function formatDateTest():void
		{
			// setup input and expected output
			var date:Date = new Date(2010, 10, 06, 8, 43, 09);
			var expectedResult:String = "Nov-06 08:43:09";
			
			// execute method
			var result:String = formatDate(date);
			
			// verify actual output
			assertEquals(result, expectedResult);
		}
		
		[Test]
		public function resultHandlerTest():void
		{
			
			// execute method
			resultHandler(vitalSignsArray);
			// verify recent vital sign lists have a length of 4
			assertEquals(recentTemp.length, 4);
			
			// verify that recent lists are sorted from most recent to least, and that dates 
			// from recentBP and recentRate lists are synchronized 
			var i:int;
			for (i = 0; i < 4; i ++) {
				var vs1:VitalSign = recentBP.getItemAt(i) as VitalSign;
				var vs2:VitalSign = recentRate.getItemAt(i) as VitalSign;
				assertEquals(vs1.intDate, vs2.intDate);
				
				if (i > 0){
					var prevVs:VitalSign = recentBP.getItemAt(i-1) as VitalSign;
					assertTrue(prevVs.intDate > vs1.intDate);
				}
			}
		}
	}
}
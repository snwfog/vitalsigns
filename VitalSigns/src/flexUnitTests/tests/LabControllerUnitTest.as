package flexUnitTests.tests
{
	import application.controller.LabsController;
	
	import domain.lab.LabList;
	import domain.user.User;
	
	import flash.display.Stage;
	
	import flexunit.framework.Assert;
	
	import model.DataEntryData;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	import spark.components.BusyIndicator;
	import flash.events.MouseEvent;
	
	public class LabControllerUnitTest extends LabsController
	{		
		private var lablistDO:LabList;
		private var userDO:User;
		private var event:MouseEvent; 
		
		public function LabControllerUnitTest(){
			super(false);
			addElement(busyIndicator);
		}
		
		[Before]
		public function setUp():void
		{	
			event = new MouseEvent("click");
			//CREATING LABLIST
			lablistDO = new LabList();
			lablistDO.collectedDate = new Date(2011,11,3,10,34,12);
			lablistDO.encounterID = 2;
			lablistDO.fillerNumber = "A12";
			lablistDO.genLabType = "G6";
			lablistDO.pid = 2;
			lablistDO.rangeIndicator = "123-145";
			lablistDO.rangeReference = "L";
			lablistDO.result = "165";
			lablistDO.resultDate = new Date(2011,11,3,10,34,12);
			lablistDO.resultUnit = "mmg";
			lablistDO.servTypeChildAcro = "RGG";
			lablistDO.servTypeChildLongDesc = "RGG";
			lablistDO.servTypeRootAcro = "RG";
			lablistDO.sortChildSeq = "1";
			lablistDO.sid = 3;
			lablistDO.state = "alive";
			
			LabListArray.addItem(lablistDO);
			
			lablistDO.collectedDate = new Date(2011,5,3,10,34,12)
			lablistDO.resultDate = new Date(2011,9,5,10,34,12);	
			lablistDO.servTypeChildAcro = "RGGT";
			lablistDO.servTypeChildLongDesc = "RGGT";
			lablistDO.servTypeRootAcro = "RGT";
			
			LabListArray.addItem(lablistDO);
		}
		
		[After]
		public function tearDown():void
		{
			lablistDO = null;
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
		public function getTimeTest():void
		{
			var time:String = getTime(lablistDO);
			var hour:Number = lablistDO.resultDate.hours;
			var minute:Number = lablistDO.resultDate.minutes;
			var second:Number = lablistDO.resultDate.seconds;
			Assert.assertEquals( time, hour+":"+minute+":"+second);
		}
		
		[Test]
		public function getResultTest():void{
			var result:String = getResult(lablistDO);
			Assert.assertEquals( result, lablistDO.result+" "+lablistDO.resultUnit);
			var lab:LabList = lablistDO;
			lab.result = null;
			result = getResult(lab);
			Assert.assertEquals(result, "N/A");
			lab.result = "GHF";
			lab.resultUnit = null;
			result = getResult(lablistDO);
			Assert.assertEquals(result, "N/A");
		}
		
		//also covert for girdCreation and arrangeItem
		[Test] 
		public function resultHandlerTest():void{
			
			addElement(busyIndicator);
			var lablistArray:ArrayCollection = new ArrayCollection();
			resultHandler( lablistArray );
			Assert.assertEquals(currentState,"NoData");
			
			lablistArray.addItem(lablistDO);
			addElement(busyIndicator);
			resultHandler( lablistArray );
			Assert.assertEquals(currentState,"ContainsData");
			
			var resultList:ArrayCollection = arrangeList;
			Assert.assertNotNull(resultList);
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "MMM DD, YYYY";
			Assert.assertEquals(resultList[0].separator,dateFormatter.format(lablistDO.resultDate) );
		}
		
		[Test]
		public function getInfoTest():void{
			getInfo( lablistDO.servTypeChildAcro );
			Assert.assertEquals(definitionStr, lablistDO.servTypeChildLongDesc);
			Assert.assertEquals(referenceStr, lablistDO.rangeReference);
			Assert.assertEquals(indicatorStr, lablistDO.rangeIndicator);
		}
		
		[Test]
		public function filterArray_initializerTest():void{
			var length:Number = filterArray_initializer(lablistDO.servTypeChildLongDesc);
			Assert.assertEquals(length, filterArray.length);
			Assert.assertEquals(filterArray[0].servTypeChildAcro, "RGGT");
		}
		
		[Test]
		public function getAllLabs_clickHandlerTest():void{
			filterArray.addItem(lablistDO);
			getAllLabs_clickHandler(event);
			Assert.assertEquals( filterArray.length, 0);
		}
		
	}
}
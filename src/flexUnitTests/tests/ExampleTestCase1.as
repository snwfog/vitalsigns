package flexUnitTests.tests
{
	import org.flexunit.Assert;
	
	import testing.DBConnection;
	
	public class ExampleTestCase1
	{		
		private var count:int = 0;
		
		[Before]
		public function setUp():void
		{
			count = 10;
		}
		
		[After]
		public function tearDown():void
		{
			count = 0;
			
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
		public function exampleTestFun():void { 
			DBConnection.init();
			DBConnection.insert(5,"dsf",0);
			count = DBConnection.getMaxRunID();
			Assert.assertEquals(1, 3-2); 
		}
		
	}
}
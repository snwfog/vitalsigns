package flexUnitTests.tests
{
	import domain.image.ImageFactory;
	
	import flash.utils.ByteArray;
	
	import flexunit.framework.Assert;
	import domain.image.Image;

	public class ImageFactoryUnitTest
	{		
		private var rawImage:ByteArray;
		[Before]
		public function setUp():void
		{
			rawImage = new ByteArray();
			for(var i:int = 0; i < 10; i++){
				rawImage.writeInt(i);
			}
			
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
		public function createImageFromByteArrayTest():void{
			var image:Image = ImageFactory.createImageFromByteArray(rawImage);
			Assert.assertNotNull(image.image);
			Assert.assertEquals(image.image.length, rawImage.length);
			Assert.assertTrue(image.image is ByteArray);
		}
		
		
	}
}
package flexUnitTests.tests
{
	import domain.image.Image;
	import domain.image.ImageAssembler;
	
	import flash.utils.ByteArray;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.ImageDTO;

	public class ImageAssemblerUnitTest
	{		
		
		private var imageDO:Image;
		private var imageDTO:ImageDTO;
		private var imageAssembler:ImageAssembler;
		private var imageDOArray:ArrayCollection;
		private var imageDTOArray:ArrayCollection;
		private var imageArray:Array;
		[Before]
		public function setUp():void
		{
			imageAssembler = new ImageAssembler();
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeInt(14);
			
			//CREATING IMAGE DO
			imageDO = new Image(15, null, "animals", "bacon" );
		
			imageDO.image = byteArray;
			
			//CREATING IMAGE DTO
			imageDTO = new ImageDTO();
			imageDTO.category = "weapons";
			imageDTO.imageId = 17;
			imageDTO.originalName = "P90";
			imageDTO.image = byteArray;
			
			//CREATING IMAGE DO ARRAY and IMAGE DTO
			imageDOArray = new ArrayCollection();
			imageDTOArray = new ArrayCollection();
			imageArray = new Array();
			
			for(var i:int = 0; i <= 6; i++){
				imageDOArray.addItem(imageDO);
				imageDTOArray.addItem(imageDTO);
				imageArray.push(imageDTO);
			}
		
		}
		
		[After]
		public function tearDown():void
		{
			imageDO.image.clear();
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
		public function createDataTransferObjectTest():void{
			var imageDTO:ImageDTO = imageAssembler.createDataTransferObject(imageDO) as ImageDTO;
			Assert.assertEquals(imageDTO.category, imageDO.category);
			Assert.assertEquals(imageDTO.imageId, imageDO.imageId);
			Assert.assertEquals(imageDTO.originalName, imageDO.originalName);
			Assert.assertNotNull(imageDTO.image);
			Assert.assertEquals(imageDTO.image.length, imageDO.image.length);
			Assert.assertTrue(imageDTO.image as ByteArray);
		}
		
		[Test]
		public function createDTOArrayTest():void{
			var dtoArray:ArrayCollection = imageAssembler.createDTOArray(imageDOArray);
			Assert.assertNotNull(dtoArray);
			Assert.assertEquals(dtoArray.length, imageDOArray.length);
			for(var i:int = 0; i < dtoArray.length; i++ ){
				Assert.assertTrue(dtoArray[i] is ImageDTO);
			}
			
			Assert.assertNull(imageAssembler.createDTOArray(null));
			var emptyArray:ArrayCollection = new ArrayCollection();
			Assert.assertNull(imageAssembler.createDTOArray( emptyArray ));
			
		}
		
		[Test]
		public function createDOArrayTest():void{
			var doArray:ArrayCollection = imageAssembler.createDOArray(imageDTOArray);
			Assert.assertNotNull(doArray);
			Assert.assertEquals(doArray.length, imageDOArray.length);
			for(var i:int = 0; i < doArray.length; i++ ){
				Assert.assertTrue(doArray[i] is Image);
			}
		}
		
		[Test]
		public function buildDTOFromObjectProxyTest():void{
			var objProxy:ObjectProxy = new ObjectProxy(imageDTO);
			var image:ImageDTO = imageAssembler.buildDTOFromObjectProxy(objProxy) as ImageDTO;
			Assert.assertEquals(image.category, imageDTO.category);
			Assert.assertEquals(image.imageId, imageDTO.imageId);
			Assert.assertEquals(image.originalName, imageDTO.originalName);
			Assert.assertNotNull(image.image);
			Assert.assertEquals(image.image.length, imageDTO.image.length);
		}
	}
}
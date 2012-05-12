package flexUnitTests.tests
{
	import domain.image.Image;
	import domain.user.User;
	import domain.user.UserAssembler;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import org.flexunit.Assert;
	
	import valueObjects.UserDTO;
	import flash.utils.ByteArray;

	public class UserAssemblerUnitTest
	{		
		private var user:UserDTO;
		private var userAssembler:UserAssembler;
		private var userObject:User;
		private var userArrayCollection:ArrayCollection;
		
		[Before]
		public function setUp():void
		{
			//Creating USER DTO
			this.user = new UserDTO();
			this.userAssembler = new UserAssembler();
			this.user.firstName = "test";
			this.user.lastName = "me";
			this.user.imageCategory = "passwords";
			this.user.memo = "hello";
			this.user.unit = "MGH";
			this.user.site = "transplate";
			this.user.nullPassword = false;
			this.user.username = "UXMG443";
			this.user.userId = 1234;
			var imgPassword:ArrayCollection = new ArrayCollection();
			this.user.passwords = imgPassword;
			
			//CREATING USER DO
			this.userObject = new User("YUYUY", 5678, true, "Im here", "super", "man");
			this.userObject.site = "HJG";
			this.userObject.unit = "VGH";
				
			//CREATING USER DTO ARRAY COLLECTION	
			this.userArrayCollection = new ArrayCollection();
			for(var i:int = 0; i <= 5 ; i++){
				userArrayCollection.addItem(user);
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
		public function createDOArrayTest():void{
			var object:ArrayCollection = userAssembler.createDOArray(userArrayCollection);
			Assert.assertEquals(object.length, userArrayCollection.length);
			Assert.assertNotNull(object);
			for(var i:int = 0; i < object.length; i++){
				Assert.assertTrue( object[i] is User );
			}
		
		}
		
		[Test]
		public function createDataTransferObjectTest():void{
			var userDTO: UserDTO = userAssembler.createDataTransferObject(this.userObject) as UserDTO;
			
			Assert.assertEquals( userDTO.userId, this.userObject.userId );
			Assert.assertEquals( userDTO.username, this.userObject.username) ;
			Assert.assertEquals( userDTO.nullPassword, this.userObject.nullPassword );
			Assert.assertEquals( userDTO.memo, this.userObject.memo );
			Assert.assertEquals( userDTO.site, userObject.site);
			Assert.assertEquals( userDTO.unit, this.userObject.unit ); 
		}
		
		[Test] 
		public function createDomainObjectTest():void{
			var userDO:User = userAssembler.createDomainObject(this.user) as User;
			
			Assert.assertEquals(userDO.firstName, this.user.firstName);
			Assert.assertEquals(userDO.lastName, this.user.lastName);
			Assert.assertEquals(userDO.memo, this.user.memo);
			Assert.assertEquals(userDO.nullPassword, this.user.nullPassword);
			Assert.assertEquals(userDO.userId, this.user.userId);
			Assert.assertEquals(userDO.username, this.user.username);
		}
		
		[Test]
		public function buildDTOFromObjectProxyTest():void{
			var objProxy:ObjectProxy = new ObjectProxy(this.user);
			var userDTO:UserDTO = userAssembler.buildDTOFromObjectProxy(objProxy) as UserDTO;
		
			Assert.assertEquals(userDTO.memo, this.user.memo);
			Assert.assertEquals(userDTO.nullPassword, this.user.nullPassword);
			Assert.assertEquals(userDTO.userId, this.user.userId);
			Assert.assertEquals(userDTO.username, this.user.username);
			Assert.assertEquals(userDTO.site, this.user.site);
			Assert.assertEquals(userDTO.unit, this.user.unit);
		}
	}
}
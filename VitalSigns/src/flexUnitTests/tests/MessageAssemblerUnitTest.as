package flexUnitTests.tests
{
	import domain.message.Message;
	import domain.message.MessageAssembler;
	
	import mx.utils.ObjectProxy;

	public class MessageAssemblerUnitTest
	{		
		import flexunit.framework.Assert;
		import valueObjects.MessageDTO;
		import domain.message.Message;
		import domain.image.ImageAssembler;
		
		private var messageDO:Message;
		private var messageDTO:MessageDTO;
		private var messageAssembler:MessageAssembler;
		
		[Before]
		public function setUp():void
		{
			this.messageAssembler = new MessageAssembler();
			//CREATING MESSAGE DO
			this.messageDO = new Message(5, 2, 9, "Still alive?", null, false);
			
			//CREATING MESSAGE DTO
			this.messageDTO = new MessageDTO();
			this.messageDTO.authorid = 6;
			this.messageDTO.body = "No pain, no game";
			this.messageDTO.conversationid = 11;
			this.messageDTO.created = new Date(2012,3,8,12,30,34);
			this.messageDTO.isNew = false;
			this.messageDTO.messageid = 87;
			this.messageDTO.recipientid = 2;
			
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
		public function createDataTransferObjectTest():void{
			var dto:MessageDTO = messageAssembler.createDataTransferObject(this.messageDO) as MessageDTO;
			Assert.assertEquals(dto.authorid, this.messageDO.authorid);
			Assert.assertEquals(dto.body, this.messageDO.body);
			Assert.assertEquals(dto.recipientid, this.messageDO.recipientid);
			Assert.assertEquals(dto.conversationid, (this.messageDO.authorid + this.messageDO.recipientid));
			Assert.assertEquals(dto.created, this.messageDO.created);
		}
		
		[Test]
		public function createDomainObjectTest():void{
			var message:Message = messageAssembler.createDomainObject(this.messageDTO) as Message;
			Assert.assertEquals(message.authorid, this.messageDTO.authorid);
			Assert.assertEquals(message.body, this.messageDTO.body);
			Assert.assertEquals(message.recipientid, this.messageDTO.recipientid);
			Assert.assertEquals(message.created, this.messageDTO.created);
			Assert.assertEquals(message.isNew, this.messageDTO.isNew);
		}
		
		[Test]
		public function buildDTOFromObjectProxyTest():void{
			var objProxy:ObjectProxy = new ObjectProxy(this.messageDTO);
			var dto:MessageDTO = messageAssembler.buildDTOFromObjectProxy(objProxy) as MessageDTO;
			Assert.assertEquals(dto.authorid, this.messageDTO.authorid);
			Assert.assertEquals(dto.body, this.messageDTO.body);
			Assert.assertEquals(dto.recipientid, this.messageDTO.recipientid);
			Assert.assertEquals(dto.conversationid, this.messageDTO.conversationid);
			Assert.assertEquals(dto.created, this.messageDTO.created);
			Assert.assertEquals(dto.messageid, this.messageDTO.messageid);
			
		}
		
	}
}
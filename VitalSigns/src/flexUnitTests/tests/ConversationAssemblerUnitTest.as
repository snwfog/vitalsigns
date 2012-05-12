package flexUnitTests.tests
{
	import domain.conversation.ConversationAssembler;
	import domain.message.MessageAssembler;
	import domain.user.User;
	
	import mx.collections.ArrayCollection;

	public class ConversationAssemblerUnitTest
	{		
		import flexunit.framework.Assert;
		import valueObjects.MessageDTO;
		import domain.message.Message;
		import domain.conversation.Conversation;
		
		private var messageDTO:MessageDTO;
		private var messageDTOArray:ArrayCollection;
		private var conversationAssembler:ConversationAssembler;
		
		[Before]
		public function setUp():void
		{
			var user:User = new User("YUYUY", 5678, true, "Im here", "super", "man");
			user.site = "HJG";
			user.unit = "VGH";
	
			this.conversationAssembler = new ConversationAssembler(user);
			
			this.messageDTOArray = new ArrayCollection();
			
			this.messageDTO = new MessageDTO();
			//CREATING MESSAGE DTO
			this.messageDTO.authorid = 6;
			this.messageDTO.body = "No pain, no game";
			this.messageDTO.conversationid = 12;
			this.messageDTO.created = new Date(2012,3,8,12,30,34);
			this.messageDTO.isNew = false;
			this.messageDTO.messageid = 87;
			this.messageDTO.recipientid = 2;
			
			this.messageDTOArray.addItem(this.messageDTO);
			
			this.messageDTO.authorid = 2;
			this.messageDTO.body = "curiosity kills the cat";
			this.messageDTO.conversationid = 12;
			this.messageDTO.created = new Date(2012,3,8,12,44,22);
			this.messageDTO.isNew = true;
			this.messageDTO.messageid = 88;
			this.messageDTO.recipientid = 6;
			
			this.messageDTOArray.addItem(this.messageDTO);
			
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
			var conversationArray:ArrayCollection = conversationAssembler.createDOArray(this.messageDTOArray);
			Assert.assertNotNull( conversationArray);
			var conversation:Conversation =  conversationArray[0];
			var messageCounter:int = conversation.messagecount ;
			Assert.assertEquals(messageCounter, messageDTOArray.length);
			for(var i:int = 0; i < messageCounter; i++){
				Assert.assertTrue(conversation.getMessage(i) is Message);
			}
			conversationArray = conversationAssembler.createDOArray(null);
			Assert.assertNotNull( conversationArray );
			Assert.assertEquals(conversationArray.length, 0);
			
		}
	}
}
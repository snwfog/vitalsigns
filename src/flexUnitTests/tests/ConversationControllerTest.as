package flexUnitTests.tests
{
	import application.controller.ConversationController;
	
	import domain.conversation.Conversation;
	import domain.message.Message;
	import domain.user.User;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.asserts.assertEquals;
	
	public class ConversationControllerTest
	{		
		private var conversationController:ConversationController;
		private var conversation:Conversation;
		private var emptyConversation:Conversation;
		private var user1:User;
		private var user2:User;
		private var user3:User;
		
		[Before]
		public function setUp():void
		{
			conversationController = new ConversationController(false);
			
			user1 = new User("User1", 5, false, "", "Test", "User1");
			user2 = new User("User2", 11, false, "", "Test", "User2");
			user3 = new User("User3", 3, false, "", "Test", "User3");
			VitalSigns.currentUser = user1;
			var usersArray:Array = new Array(user1, user2, user3,
				new User("User4", 5, false, "", "Test", "User4"),
				new User("User5", 5, false, "", "Test", "User5"),
				new User("User6", 5, false, "", "Test", "User6")
			);
			conversationController.arrUsers = new ArrayCollection(usersArray);
			
			conversation = new Conversation(1, user1);
			for (var i:int = 0; i < 10; i++) {
				conversation.addMessage(new Message(0, user1.userId, user2.userId, "test"+i, new Date(), false));
			}
			for (i = 0; i < 5; i++) {
				conversation.addMessage(new Message(0, user2.userId, user1.userId, "test"+i, new Date(), true));
			}
			for (i = 0; i < 5; i++) {
				conversation.addMessage(new Message(0, user1.userId, user2.userId, "test"+i, new Date(), true));
			}
			conversationController.arrConversations.addItem(conversation);
			emptyConversation = new Conversation(0, user1);
			conversationController.arrConversations.addItem(emptyConversation);
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
		public function testGetCountInfo():void
		{
			var expectedResult:String = "(20, 5 new)";
			var result:String = conversationController.getCountInfo(conversation);
			assertEquals(result, expectedResult);
		}
		
		[Test]
		public function testGetLastMessageDate():void
		{
			// test with populated conversation
			var date:Date = new Date(2010, 3, 1, 11, 11);
			var expectedResult:String = "Apr 01 - 11:11";
			
			conversation.addMessage(new Message(0, user1.userId, user2.userId, "hi", date, false));
			var result:String = conversationController.getLastMessageDate(conversation);
			assertEquals(result, expectedResult);
			
			// test with empty conversation
			var expectedResult2:String = "";	
			var result2:String = conversationController.getLastMessageDate(emptyConversation);
			assertEquals(result2, expectedResult2);
		}
		
		[Test]
		public function testGetOtherParticipantName():void
		{
			// test with populated conversation
			var expectedResult:String = "Test User2";
			var result:String = conversationController.getOtherParticipantName(conversation);
			assertEquals(result, expectedResult);
			
			// test with empty conversation
			var expectedResult2:String = "";
			var result2:String = conversationController.getOtherParticipantName(emptyConversation);
			assertEquals(result2, expectedResult2);
		}
		
		[Test]
		public function testTryGetConversation():void
		{
			// test with a user who has is recipient of a conversation
			var expectedResult:Conversation = conversation;
			var result:Conversation = conversationController.tryGetConversation(user2);
			assertEquals(result, expectedResult);
			
			// test with a user who is not part of any conversation
			var expectedResult2:Conversation = new Conversation(8, user1);
			expectedResult2.otherParticipant = user3;
			var result2:Conversation = conversationController.tryGetConversation(user3);
			assertEquals(result2.conversationid, expectedResult2.conversationid);
			assertEquals(result2.otherParticipant, expectedResult2.otherParticipant);
			assertEquals(result2.messagecount, expectedResult2.messagecount);
		}
	}
}
package flexUnitTests.tests
{
	import application.controller.MessagingController;
	
	import domain.conversation.Conversation;
	import domain.message.Message;
	import domain.user.User;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	
	public class MessagingControllerTest
	{
		private var messagingController:MessagingController;
		private var msgFromCurrentUser:Message;
		private var msgFromOtherUser:Message;
		private var user1:User;
		private var user2:User;
		
		[Before]
		public function setUp():void
		{
			messagingController = new MessagingController();
			user1 = new User("User1", 5, false, "", "Test", "User1");
			user2 = new User("User2", 11, false, "", "Test", "User2");
			messagingController.conversation = new Conversation(0, user1);
			VitalSigns.currentUser = user1;
			
			msgFromCurrentUser = new Message(0, user1.userId, user2.userId, "testing", new Date(), false);
			msgFromOtherUser = new Message(0, user2.userId, user1.userId, "testing", new Date(), false);
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
		public function testFormatTime():void
		{
			var date:Date = new Date(2012, 3, 1, 11, 11, 11);
			var expectedResult:String = "Sun, Apr 01 2012 - 11:11:11";
			
			msgFromCurrentUser.created = date;
			var result:String = messagingController.formatTime(msgFromCurrentUser);
			assertEquals(result, expectedResult);
		}
		
		[Test]
		public function testGetCssClass():void
		{
			// test with message sent by non-current user
			var expectedResult:String = "other_color";
			var result:String = messagingController.getCssClass(msgFromOtherUser);
			assertEquals(result, expectedResult);
			
			// test with message sent by non-current user
			var expectedResult2:String = "user_color";
			var result2:String = messagingController.getCssClass(msgFromCurrentUser);
			assertEquals(result2, expectedResult2);
		}
		
		[Test]
		public function testNewMessageHandler():void
		{
			messagingController.newMessageHandler(msgFromCurrentUser);
			assertTrue(messagingController.arrMessages.contains(msgFromCurrentUser));
			assertEquals(messagingController.txtMessage.text, "");
		}
	}
}
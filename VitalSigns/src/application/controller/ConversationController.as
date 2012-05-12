package application.controller
{
	import application.component.ListBox;
	import application.component.PopupList;
	import application.controller.messaging.NotificationController;
	import application.view.MessagingView;
	
	import domain.IObservable;
	import domain.conversation.Conversation;
	import domain.message.Message;
	import domain.user.User;
	
	import flash.events.MouseEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionDirection;
	
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
		
	public class ConversationController extends NotificationController
	{	
		public const listItemHeight:int = 72;
		
		protected function Conversation_addHandler(event:FlexEvent):void
		{	
			VitalSigns.registerSwipeListener(viewChange);
		}
		
		private function viewChange(slide:SlideViewTransition = null, direction:String = null):void{
			//If valid direction remove listener and move to that view
			if(direction!=null&&direction!="UP"&&direction!="RIGHT"&&direction!="LEFT"){
				VitalSigns.removeSwipeListener();
				if (direction == "DOWN")
					navigator.popView(slide);	
			}
		}
		
		public function ConversationController( defaultBehaviour:Boolean = true ){
			super(defaultBehaviour);
		}
		
		protected function btnNewMessage_clickHandler( event:MouseEvent ):void{
			var popup:PopupList = new PopupList();
			popup.callback = popupCallback;
			popup.dataProvider = arrNames;
			popup.open( this, true );
		}
		
		
		public function popupCallback( commit:Boolean, selectedIndex:int ):void{
			if( commit ){
				var recipient:User = arrUsers.getItemAt( selectedIndex ) as User;
				var newConversation:Conversation = tryGetConversation( recipient );
				VitalSigns.doViewPush( MessagingView, newConversation );
			}
		}
		
		public function tryGetConversation( recipient:User ):Conversation{
			for each( var existing:Conversation in arrConversations ){
				if( recipient.userId == existing.getOtherParticipantId() )
					return existing;
			}
			var newConversation:Conversation = new Conversation( calculateConversationid( VitalSigns.currentUser, recipient ), VitalSigns.currentUser );
			newConversation.otherParticipant = recipient;
			
			return newConversation;
		}
		
		public function calculateConversationid( userOne:User, userTwo:User ):int{
			return userOne.userId + userTwo.userId;
		}
		
		// ============================== conversation list view methods ==================================
		
		public function getOtherParticipantName( listObject:Object ):String{
			var conversation:Conversation = listObject as Conversation;
			var otherId:int = conversation.getOtherParticipantId();
			if( otherId != -1 ){
				for each( var user:User in arrUsers ){
					if( user.userId == otherId ){
						conversation.otherParticipant = user;
						return user.fullName;
					}
				}
			}
			return "";
		}
		
		public function getCountInfo( listObject:Object ):String{
			var conversation:Conversation = listObject as Conversation;
			var newCount:int = conversation.getNumberOfNewMessages();
			
			return "(" + conversation.messagecount + ", " + newCount + " new)";
		}
		
		public function getLastMessageDate( listObject:Object ):String{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "MMM DD - HH:NN";
			
			var conversation:Conversation = listObject as Conversation;
			var lastIndex:int = conversation.messagecount - 1;
			if( lastIndex >= 0 )
				return formatter.format( conversation.getMessage( lastIndex ).created );
			return "";
		}
		
		// ============================ end conversation list view methods ================================
		
		// ============================== conversation click handler ======================================
		
		public function listBox_clickHandler( event:MouseEvent ):void{
			var listBox:ListBox = event.currentTarget as ListBox;
			var conversationid:int = parseInt( listBox.name );
			
			var conversation:Conversation = getConversation( conversationid );
			VitalSigns.doViewPush( MessagingView, conversation );
		}
		
		private function getConversation( conversationid:int ):Conversation{
			for each( var conversation:Conversation in arrConversations )
				if( conversation.conversationid == conversationid )
					return conversation;
			return null;
		}
		
		// ============================= end conversation click handler ===================================
	}
}
package domain.conversation
{
	import domain.message.Message;
	import domain.model.IDomainObject;
	import domain.user.User;
	
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	
	[Bindable]
	public class Conversation implements IDomainObject
	{
		
		private var _arrMessages:ArrayCollection;
		private var _conversationid:int;
		private var _viewer:User; // the user logged in
		private var _otherParticipant:User; // the other user associated to the conversation
		
		private var _newMessageIds:ArrayCollection;
		
		public function Conversation( conversationid:int, viewer:User, message:Message = null ){
			_conversationid = conversationid;
			_viewer = viewer;
			_otherParticipant = null;
			_arrMessages = new ArrayCollection();
			_newMessageIds = new ArrayCollection();
			if( message )
				addMessage( message );
		}
		
		public function get conversationid():int{
			return _conversationid;
		}
		
		public function addMessage( message:Message ):void{
			_arrMessages.addItem( message );
		}
		
		public function addMessages( newConversation:Conversation ):Boolean{
			var lastRetrievedMessage:Message = getMessage( _arrMessages.length - 1 );
			var lastMessageTime:Number = lastRetrievedMessage.created.time;
			var startIndex:int = 0;
			
			var startAdding:Boolean = false;
			
			for( ; !startAdding && startIndex < newConversation.messagecount; startIndex++ ){
				 var message:Message = newConversation.getMessage( startIndex );
				 startAdding = ( message.created.time > lastMessageTime );
			}
			
			if( startAdding ){
				startIndex--;
				for( ; startIndex < newConversation.messagecount; startIndex++ )
					addMessage( newConversation.getMessage( startIndex ) );
				
				// in the event a new message is sent by the other participant before a message from current user is sent
				var sorter:Sort = new Sort();
				sorter.fields = [ new SortField( "created" ) ];
				_arrMessages.sort = sorter;
				_arrMessages.refresh();
			}
			
			return startAdding;
		}
		
		public function get messagecount():int{
			return _arrMessages.length;
		}
		
		public function getMessage( index:int ):Message{
			if( index < 0 )
				return null;
			return _arrMessages.getItemAt( index ) as Message;
		}
		
		/**
		 * New messages consist of those which are only new for the recipient
		 */ 
		public function getNumberOfNewMessages():int{
			var numNew:int = 0;
			_newMessageIds.removeAll();
			for each( var message:Message in _arrMessages ){
				if( message.isNew && message.recipientid == _viewer.userId ){
					_newMessageIds.addItem( message.messageid );
					numNew++;
				}
			}
			return numNew;
		}
		
		public function getNewMessageIds():String{
			return GeneralFunctions.flattenList( _newMessageIds );
		}
		
		public function markConversationAsRead():void{
			for each( var message:Message in _arrMessages ){
				if( message.recipientid == _viewer.userId )
					message.isNew = false;
			}
			_newMessageIds.removeAll();
		}
		
		public function set otherParticipant( value:User ):void{
			_otherParticipant = value;
		}
		
		public function get otherParticipant():User{
			return _otherParticipant;
		}
		
		public function getOtherParticipantId():int{
			
			if( _otherParticipant )
				return _otherParticipant.userId;
			
			if( messagecount == 0 )
				return -1;
			
			var message:Message = getMessage( 0 );
			if( message.authorid == _viewer.userId )
				return message.recipientid;
			return message.authorid;
		}
	}
}
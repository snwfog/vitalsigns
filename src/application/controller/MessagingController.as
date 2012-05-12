package application.controller
{
	import domain.IObservable;
	import domain.command.MarkAsReadCommand;
	import domain.command.SendNewMessageCommand;
	import domain.conversation.Conversation;
	import domain.message.Message;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
	
	import spark.components.TextArea;
	import spark.components.View;
	
	public class MessagingController extends View implements IObservable
	{
		
		public var txtMessage:TextArea = new TextArea();
		
		private const myColorClass:String = "user_color";
		private const otherColorClass:String = "other_color";
		private var _conversation:Conversation;
		
		[Bindable]public var otherName:String = "";
		[Bindable]public var messageFont:Number = 25;
		[Bindable]public var dateFont:Number = 20;
		[Bindable]public var listSpace:Number = 2;

		[Bindable]public var arrMessages:ArrayCollection = new ArrayCollection();
		
		private var _resultFunction:Function = null;
		
		public function MessagingController(){
			super();
		}
		
		protected function messagingcontroller_creationCompleteHandler( event:FlexEvent ):void{
			this.currentState = "keyboard_hidden";
			
			conversation = data as Conversation;
			
			markConversationAsRead( conversation );
			
			for( var i:int = 0; i < conversation.messagecount; i++ )
				arrMessages.addItem( conversation.getMessage( i ) );
			
			otherName = conversation.otherParticipant.fullName;
		}
		
		public function markConversationAsRead( conversation:Conversation ):void{
			if( conversation.messagecount > 0 ){
				conversation.markConversationAsRead();
				
				var cmd:MarkAsReadCommand = new MarkAsReadCommand( this, conversation.conversationid, VitalSigns.currentUser.userId );
				_resultFunction = markReadHandler;
				cmd.execute();
			}
		}
		
		public function getCssClass( listObject:Object ):String{
			var message:Message = listObject as Message;
			var authorid:int = message.authorid;
			
			var currentUserId:int = VitalSigns.currentUser.userId;
			
			if( currentUserId == authorid )
				return myColorClass;
			return otherColorClass;
			
		}
		
		public function formatTime( listObject:Object ):String{
			var message:Message = listObject as Message;
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "EEE, MMM DD YYYY - H:NN:SS";
			
			return formatter.format( message.created );
		}
		
		
		public function faultHandler( message:String ):void{
			VitalSigns.showErrorMessage();
		}
		
		public function resultHandler( DO:Object ):void{
			cursorManager.removeBusyCursor();
			_resultFunction( DO );
		}
		
		public function markReadHandler( DO:Object ):void{
			
		}
		
		public function newMessageHandler( DO:Object ):void{
			var newMessage:Message = DO as Message;
			conversation.addMessage( newMessage );
			
			arrMessages.addItem( newMessage );
			
			txtMessage.text = "";
		}
		
		
		public function get conversation():Conversation
		{
			return _conversation;
		}
		public function set conversation(value:Conversation):void
		{
			_conversation = value;
		}
		
		// ======================================== message sending events ==================================
		
		protected function txtMessage_softKeyboardActivatingHandler( event:SoftKeyboardEvent ):void{
			currentState = "keyboard_visible";
		}
		
		protected function txtMessage_focusOutHandler( event:FocusEvent ):void{			
			setTimeout(function():void{
				currentState = "keyboard_hidden";
			}, 500);
		}
		
		protected function btnSend_clickHandler( event:MouseEvent ):void{
			cursorManager.setBusyCursor();
			var cmd:SendNewMessageCommand = new SendNewMessageCommand( this, VitalSigns.currentUser.userId, conversation.otherParticipant.userId, txtMessage.text );
			_resultFunction = newMessageHandler;
			cmd.execute();
		}
		
		// ======================================= end message sending events ================================
		
	}
}
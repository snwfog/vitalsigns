package application.controller.messaging
{
	
	import application.factory.INotifier;
	import application.view.ConversationView;
	
	import domain.IObservable;
	import domain.conversation.Conversation;
	import domain.user.User;
	
	import flash.events.StatusEvent;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.View;
	
	
	/**
	 * The NotificationController is not directly used by a view (.mxml file). It is meant to be
	 * extended by any other controller to add the notification/messaging functionality
	 * to those controllers.
	 * <BR><BR>
	 * <DL>
	 * <DT>Ex: LoginController extends View implements IObservable</DT>
	 * <DD>LoginController will behave normally</DD>
	 * <DT><BR>Ex: PatientListController extends NotificationController implements IObservable</DT>
	 * <DD>PatientListController will have the extra functionality of the notification/messaging,
	 * along with behaving normally.</DD>
	 * </DL>
	 */ 
	public class NotificationController extends View
	{
		
		private static var _notifier:INotifier = VitalSigns.PlatformFactory.createNotificationCenter();
		
		private static var _arrUsers:ArrayCollection = new ArrayCollection();
		private static var _arrConversations:ArrayCollection = new ArrayCollection();
	
		private static var _innerClass:InnerClass = null;
		
		/**
		 * Upon instantiation of a new NotificationController, the current state
		 * of the NotificationController will run (initialize or update)
		 * 
		 * @param defaultBehaviour (Default value: true) Runs the current state. False prevents the
		 * state from executing
		 */
		public function NotificationController( defaultBehaviour:Boolean = true ){
			this.cursorManager.setBusyCursor();
			if( _innerClass == null )
				_innerClass = new Initializer( this );
			
			if( defaultBehaviour )
				_innerClass.apply();
		}
		
		public function set innerClass( innerClass:InnerClass ):void{
			_innerClass = innerClass;
		}
		
		public function showNotification():void{
			var iNewMessages:int = 0;
			var newMessageIds:ArrayCollection = new ArrayCollection();
			for each( var conversation:Conversation in _arrConversations ){
				var numNew:int = conversation.getNumberOfNewMessages();
				iNewMessages += numNew;
				if( numNew > 0 )
					newMessageIds.addItem( conversation.getNewMessageIds() );
			}
			
			_notifier.generateNotification( iNewMessages, GeneralFunctions.flattenList( newMessageIds ) );
		}
		
		
		
		
		public static function cancelNotifications():void{
			_notifier.cancelNotification();
		}
		
		
		// ================================== Notification event handlers ==========================================
		
		// ================================ end Notification event handlers ========================================
		
		
		/**
		 * Returns the list of other Users in the same site and unit
		 */ 
		[Bindable]
		public function get arrUsers():ArrayCollection{
			return _arrUsers;
		}
		
		public function set arrUsers( array:ArrayCollection ):void{
			if( _arrUsers.length == 0 )
				_arrUsers = array;
		}
		
		public function get arrNames():ArrayCollection{
			var arrNames:ArrayCollection = new ArrayCollection();
			for each( var user:User in _arrUsers )
				arrNames.addItem( user.fullName );
			
			return arrNames;
		}
		
		/**
		 * Returns the Conversation Array.
		 */
		[Bindable]
		public function get arrConversations():ArrayCollection{
			return _arrConversations;
		}
		
		public function set arrConversations( array:ArrayCollection ):void{
			if( _arrConversations.length == 0 )
				_arrConversations = array;
		}
		
		
	}
}

import application.controller.messaging.NotificationController;

import domain.IObservable;
import domain.command.GetAllMessagesCommand;
import domain.command.GetNewMessagesCommand;
import domain.command.GetOtherUsersCommand;
import domain.conversation.Conversation;
import domain.message.Message;
import domain.user.User;

import mx.collections.ArrayCollection;

/**
 * Inner classes to hide and isolate functionality of messaging from
 * public classes, so other views can just extend NotificationController
 * and all functionality will be present in the subclass of NotificationController
 */
class InnerClass implements IObservable{
	
	protected var _parent:NotificationController;
	private static var _isAvailable:Boolean = true; // semaphore to block access while updating
	
	/**
	 * Pointer to the actual result handler function to be run.
	 * Many web service calls made within this controller 
	 */
	protected var _resultFunction:Function;
	
	public function InnerClass( parent:NotificationController ){
		_parent = parent;
		_resultFunction = emptyFunction;
	}
	
	public function apply():void{
		throw new Error( "Not Implemented" );
	}
	
	public function faultHandler( message:String ):void{
		VitalSigns.showErrorMessage();
	}
	
	public function resultHandler( DO:Object ):void{
		_parent.cursorManager.removeBusyCursor();
		_resultFunction( DO );
	}
	
	public function setOtherParticipant( conversation:Conversation ):void{
		var newArray:ArrayCollection = new ArrayCollection( [ conversation ] );
		setOtherParticipants( newArray );
	}
	
	public function setOtherParticipants( conversations:ArrayCollection ):void{
		for each( var conversation:Conversation in conversations ){
			conversation.otherParticipant = getUser( conversation.getOtherParticipantId() );
		}
	}
	
	public function getUser( userid:int ):User{
		for each( var user:User in _parent.arrUsers ){
			if( userid == user.userId )
				return user;
		}
		
		return null;
	}
	
	private function emptyFunction( DO:Object ):void{}
}

class Initializer extends InnerClass{
	
	public function Initializer( parent:NotificationController ){
		super( parent );
	}
	
	public override function apply():void{
		var cmd:GetOtherUsersCommand = new GetOtherUsersCommand( this, VitalSigns.currentUser );
		_resultFunction = otherUsersHandler;
		cmd.execute();
	}
	
	/**
	 * Result Handler for command: GetOtherUsersCommand
	 */ 
	public function otherUsersHandler( DO:Object ):void{
		_parent.arrUsers = DO as ArrayCollection;
		var cmd:GetAllMessagesCommand = new GetAllMessagesCommand( this, VitalSigns.currentUser );
		_resultFunction = allMessagesHandler;
		cmd.execute();
	}
	
	/**	
	 * Result Handler for command: GetAllMessagesCommand
	 */
	public function allMessagesHandler( DO:Object ):void{
		_parent.arrConversations = DO as ArrayCollection;
		setOtherParticipants( _parent.arrConversations );
		// change State of parent (NotificationController) to be updating only
		_parent.innerClass = new Updater( _parent );
		_parent.showNotification();
	}
}

class Updater extends InnerClass{
	
	public function Updater( parent:NotificationController ){
		super( parent );
	}
	
	public override function apply():void{
		var cmd:GetNewMessagesCommand = new GetNewMessagesCommand( this, VitalSigns.currentUser );
		_resultFunction = appendNewMessages;
		cmd.execute();
	}
	
	/**
	 * Result Handler for command: GetNewMessagesCommand
	 */ 
	public function appendNewMessages( DO:Object ):void{
		var arrConversations:ArrayCollection = _parent.arrConversations;
		var newMessages:ArrayCollection = DO as ArrayCollection;
		
		var conversationIndex:int = 0;
		
		for each( var conversation:Conversation in newMessages ){
			var found:Boolean = false;
			for( ; !found && conversationIndex < arrConversations.length; conversationIndex++ ){
				var currentConversation:Conversation = arrConversations.getItemAt( conversationIndex ) as Conversation;
				if( conversation.conversationid == currentConversation.conversationid ){
					found = true;
					currentConversation.addMessages( conversation );
				}
			}
			
			// add the rest of the new conversations
			if( !found )
				arrConversations.addItem( conversation );
		}

		setOtherParticipants( newMessages );
		
		_parent.showNotification();
	}
}


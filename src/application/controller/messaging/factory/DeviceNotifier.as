package application.controller.messaging.factory
{
	import application.view.ConversationView;
	
	import com.adobe.ep.notifications.Notification;
	import com.adobe.ep.notifications.NotificationAlertPolicy;
	import com.adobe.ep.notifications.NotificationEvent;
	import com.adobe.ep.notifications.NotificationIconType;
	import com.adobe.ep.notifications.NotificationManager;
	import application.factory.INotifier;
	
	public class DeviceNotifier implements INotifier
	{
		private static var _notificationManager:NotificationManager = new NotificationManager();
		
		private const NOTIFICATIONCODE:String = "VITALSIGNS_NOTIFICATION";
		
		private static var _lastNewMessageIds:String = "";
		
		private static var thisObject:DeviceNotifier;
		
		private static var _setupFunction:Function = startSetup;
		
		public function DeviceNotifier(){
			thisObject = this;
			_setupFunction();
		}
		
		
		private static function startSetup():void{
			_notificationManager.addEventListener( NotificationEvent.NOTIFICATION_ACTION, thisObject.onNotificationActionEvent ); 
			_setupFunction = function():void{};
		}
		
		protected function onNotificationActionEvent( event:NotificationEvent ):void{
			VitalSigns.doViewPush( ConversationView );
		}
		
		public function generateNotification( iNewMessages:int, strNewIds:String ):void{
			var notification:Notification = createNotification( iNewMessages, strNewIds );
			_notificationManager.notifyUser( NOTIFICATIONCODE, notification );
		}
		
		private function createNotification( iNewMessages:int, strNewIds ):Notification{
			var n:Notification = new Notification();
			
			var title:String = iNewMessages + " new message" + ( iNewMessages == 1 ? "" : "s" );
			n.tickerText = "VitalSigns - " + title;
			n.body = title;
			n.title = "VitalSigns Messaging";
			n.actionLabel = "Open";
			n.alertPolicy = NotificationAlertPolicy.EACH_NOTIFICATION;
			n.cancelOnSelect = false; // do not remove notification from "ongoing"
			
			n.hasAction = true;
			n.actionData = "This is the action";
			
			n.iconType = NotificationIconType.MESSAGE;
			n.numberAnnotation = iNewMessages;
			
			n.ongoing = true; // put notification in "ongoing" section
			n.playSound = true;
			n.repeatAlertUntilAcknowledged = false;
			
			var alert:Boolean = strNewIds != _lastNewMessageIds;
			n.vibrate = alert;
			
			if( alert )
				_notificationManager.cancel( NOTIFICATIONCODE );
			
			_lastNewMessageIds = strNewIds;
			
			return n;
		}
		
		public function cancelNotification():void{
			_notificationManager.cancelAll();
		}
	}
}
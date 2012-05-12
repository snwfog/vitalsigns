package application.controller.messaging.factory
{
	import application.factory.INotifier;

	public class DesktopNotifier implements INotifier
	{
		public function DesktopNotifier(){}
		public function generateNotification( iNewMessages:int, strNewIds:String ):void{}
		public function cancelNotification():void{}
	}
}
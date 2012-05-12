package application.factory
{
	public interface INotifier
	{
		function generateNotification( iNewMessages:int, strNewIds:String ):void;
		function cancelNotification():void;
	}
}
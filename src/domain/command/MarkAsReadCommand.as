package domain.command
{
	import domain.IObservable;
	import domain.conversation.ConversationWS;
	
	public class MarkAsReadCommand extends Command
	{
		private var _conversationid:int;
		private var _userid:int;
		
		public function MarkAsReadCommand( observable:IObservable, conversationid:int, userid:int ){
			super( observable );
			_conversationid = conversationid;
			_userid = userid;
		}
		
		override public function execute():void{
			var ws:ConversationWS = new ConversationWS( resultCallback, faultCallback );
			ws.markConversationAsRead( _conversationid, _userid );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler(resultObject);
		}
		
		
	}
}
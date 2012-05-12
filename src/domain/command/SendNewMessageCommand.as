package domain.command
{
	import domain.IObservable;
	import domain.conversation.ConversationWS;
	import domain.message.Message;
	import domain.message.MessageAssembler;
	
	import valueObjects.MessageDTO;
	
	public class SendNewMessageCommand extends Command
	{
		
		private var _message:Message;
		private var _assembler:MessageAssembler;
		
		public function SendNewMessageCommand( observable:IObservable, authorid:int, recipientid:int, body:String ){
			super( observable );
			_message = new Message( 0, authorid, recipientid, body, new Date(), true );
			_assembler = new MessageAssembler();
		}
		
		override public function execute():void{
			var ws:ConversationWS = new ConversationWS( resultCallback, faultCallback );
			ws.insertNewMessage( _assembler.createDataTransferObject( _message ) as MessageDTO );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			var messageid:int = resultObject as int;
			var returnMessage:Message = new Message( messageid, _message.authorid, _message.recipientid, _message.body, _message.created, true );
			_observable.resultHandler( returnMessage );
		}
		
		
	}
}
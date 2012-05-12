package domain.command
{
	import domain.IObservable;
	import domain.conversation.*;
	import domain.user.User;
	import domain.user.UserAssembler;
	
	import valueObjects.UserDTO;
	
	public class GetNewMessagesCommand extends Command
	{
		private var _user:User;
		private var _assembler:ConversationAssembler;
		
		public function GetNewMessagesCommand( observable:IObservable, user:User ){
			super( observable );
			_user = user;
			_assembler = new ConversationAssembler( _user );
		}
		
		override public function execute():void{
			var userAssembler:UserAssembler = new UserAssembler();
			
			var ws:ConversationWS = new ConversationWS( resultCallback, faultCallback );
			ws.getNewMessagesByUser( userAssembler.createDataTransferObject( _user ) as UserDTO );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler( _assembler.createDOArray( resultObject ) );
		}
		
		
	}
}
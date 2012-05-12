package domain.command
{
	import domain.IObservable;
	import domain.user.*;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.UserDTO;
	
	public class VerifyUserCommand extends Command
	{
		private var _user:User;
		private var _assembler:UserAssembler;
		
		public function VerifyUserCommand( observable:IObservable, user:User ){
			super( observable );
			_user = user;
			_assembler = new UserAssembler();
		}
		
		override public function execute():void{
			var ws:UserWS = new UserWS( resultCallback, faultCallback );
			ws.getUserVerifyPassword( _assembler.createDataTransferObject( _user ) as UserDTO );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			if( resultObject === true )
				_observable.resultHandler( _user );
			else
				_observable.resultHandler( null );
		}
		
	}
}
package domain.command
{
	import domain.IObservable;
	import domain.user.*;
	
	import valueObjects.UserDTO;
	
	public class RegisterUserCommand extends Command
	{
		private var _user:User;
		private var _assembler:UserAssembler;
		
		public function RegisterUserCommand( observable:IObservable, user:User ){
			super( observable );
			_user = user;
			_assembler = new UserAssembler();
		}
		
		override public function execute():void{
			var ws:UserWS = new UserWS( resultCallback, faultCallback );
			ws.registerUser( _assembler.createDataTransferObject( _user ) as UserDTO );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			if( resultObject === true )
				_observable.resultHandler( resultObject );
			else
				_observable.resultHandler( null );
		}
		
		
	}
}
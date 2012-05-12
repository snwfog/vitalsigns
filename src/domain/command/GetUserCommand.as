package domain.command
{
	import domain.IObservable;
	import domain.user.*;
	
	import valueObjects.UserDTO;
	
	public class GetUserCommand extends Command
	{
		private var _username:String;
		private var _assembler:UserAssembler;
		
		public function GetUserCommand( observable:IObservable, username:String ){
			super( observable );
			_username = username;
			_assembler = new UserAssembler();
		}
		
		override public function execute():void{
			var ws:UserWS = new UserWS( resultCallback, faultCallback );
			ws.GetUserByUsername( _username );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler( _assembler.createDomainObject( resultObject as UserDTO ) );
		}
	}
}
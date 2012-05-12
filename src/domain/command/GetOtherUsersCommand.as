package domain.command
{
	import domain.IObservable;
	import domain.user.*;
	
	import valueObjects.UserDTO;
	
	public class GetOtherUsersCommand extends Command
	{
		private var _user:User;
		private var _assembler:UserAssembler;
		
		public function GetOtherUsersCommand( observable:IObservable, user:User ){
			super( observable );
			_user = user;
			_assembler = new UserAssembler();
		}
		
		override public function execute():void{
			var ws:UserWS = new UserWS( resultCallback, faultCallback );
			ws.getOtherUsersInUnit( _assembler.createDataTransferObject( _user ) as UserDTO );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler( _assembler.createDOArray( resultObject ) );
		}
		
		
	}
}
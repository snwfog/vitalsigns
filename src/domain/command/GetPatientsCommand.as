package domain.command
{
	import domain.IObservable;
	import domain.patient.*;
	import domain.user.User;
	import domain.user.UserAssembler;
	
	import valueObjects.UserDTO;
	
	public class GetPatientsCommand extends Command
	{
		
		private var _user:User;
		private var _userAssembler:UserAssembler;
		private var _assembler:PatientAssembler;
		
		public function GetPatientsCommand( observable:IObservable, user:User ){
			super( observable );
			_user = user;
			_userAssembler = new UserAssembler();
			_assembler = new PatientAssembler();
		}
		
		override public function execute():void{
			var ws:PatientWS = new PatientWS( resultCallback, faultCallback );
			ws.getPatients( _userAssembler.createDataTransferObject( _user ) as UserDTO );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler( _assembler.createDOArray( resultObject ) );
		}
	}
}
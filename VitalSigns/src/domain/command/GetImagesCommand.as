package domain.command
{
	import domain.IObservable;
	import domain.image.*;
	import domain.user.User;
	
	import valueObjects.ImageDTO;
	
	public class GetImagesCommand extends Command
	{
		private var _user:User;
		private var _assembler:ImageAssembler;
		
		public function GetImagesCommand( observable:IObservable, user:User ){
			super( observable );
			_user = user;
			_assembler = new ImageAssembler();
		}
		
		override public function execute():void{
			var ws:ImageWS = new ImageWS( resultCallback, faultCallback );
			ws.GetUserImageChallenge( _user.username );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler( _assembler.createDOArray( resultObject ) );
		}
	}
}
package domain.command
{
	import domain.IObservable;
	import domain.image.*;
	
	public class GetImagesByCategoryCommand extends Command
	{
		private var _category:String;
		private var _assembler:ImageAssembler;
		
		public function GetImagesByCategoryCommand( observable:IObservable, category:String ){
			super( observable );
			_category = category;
			_assembler = new ImageAssembler();
		}
		
		override public function execute():void{
			var ws:ImageWS = new ImageWS( resultCallback, faultCallback );
			ws.getImagesByCategory( _category );
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			_observable.resultHandler( _assembler.createDOArray( resultObject ) );
		}
	}
}
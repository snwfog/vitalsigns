package domain.command
{
	import domain.IObservable;
	import domain.image.*;
	
	import mx.collections.ArrayCollection;
	
	public class GetImageCategoriesCommand extends Command
	{
		
		public function GetImageCategoriesCommand( observable:IObservable ){
			super( observable );
		}
		
		override public function execute():void{
			var ws:ImageWS = new ImageWS( resultCallback, faultCallback );
			ws.getImageCategories();
		}
		
		override protected function resultCallback( resultObject:Object ):void{
			// web service method returns an array of Strings.
			if( resultObject is ArrayCollection )
				 _observable.resultHandler( resultObject as ArrayCollection );
			else
				_observable.resultHandler( new ArrayCollection( [ resultObject ] ) );
		}
		
		
	}
}
package domain.wrapper
{
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.VitalSignService;

	/**
	 * Intended as an Abstract class, to be extended as concrete wrappers for
	 * the DTO stack.<BR><BR>
	 * 
	 * Base class for wrapping the main callbacks from accessing the web service
	 * functions. Also hides the base functionality of calling the web service.<BR><BR>
	 * 
	 * result and fault functions are protected to allow overridding if necessary.
	 */
	public class WrapperWS
	{
		private var _resultCallback:Function;
		private var _faultCallback:Function;
		
		public function WrapperWS( resultCallback:Function = null, faultCallback:Function = null ){
			_resultCallback = resultCallback;
			_faultCallback = faultCallback;
			
			// handles the case when the Web Service instance was created while the application
			// couldn't connect to the web service, and regular fault (loss of connection after)
			if( !VitalSignService.instance.hasEventListener( FaultEvent.FAULT ) )
				VitalSignService.instance.addEventListener( FaultEvent.FAULT, fault );
			
			
			//VitalSignService.instance.addEventListener( ResultEvent.RESULT, result );
			
		}
		
		protected function addCallback( token:AsyncToken ):void{
			token.addResponder( new AsyncResponder( result, function( e:FaultEvent, token:Object = null ):void{} ) );
		}
		
		private function result( event:ResultEvent, token:Object = null ):void{
			//VitalSignService.instance.removeEventListener( ResultEvent.RESULT, result );
			if( _resultCallback != null )
				_resultCallback( event.result );
		}
		
		private function fault( event:FaultEvent, token:Object = null ):void{
			VitalSignService.forceRenew = true;
			if( _faultCallback != null )
				_faultCallback( event.fault.faultString );
		}
	}
}
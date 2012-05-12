package domain.command
{
	import domain.IObservable;
	import domain.wrapper.WrapperWS;

	public class Command
	{		
		protected var _observable:IObservable;
		
		public function Command( observable:IObservable = null ){
			_observable = observable;
		}
		
		/**
		 * <B>Must be overridden by any inheriting class</B>
		 * <BR>Provides the base method signature for the controllers to call.
		 */ 
		public function execute():void{
			throw new Error( "Not Implemented" );
		}
		
		/**
		 * Method called when the Web Service encounters a fault (example: loss of connection).<BR>
		 * Can be overridden to modify the default behaviour. If not overridden, the message is sent back to the observer.
		 * <BR><BR>
		 * @param message This message is from the FaultEvent's message. It is not the actual message to be shown to the user.
		 * For debugging purposes only.
		 */
		protected function faultCallback( message:String ):void{
			_observable.faultHandler( message );
		}
		
		/**
		 * <B>This method must be overridden by any inheriting class</B>
		 * <BR>Method called when the Web Service successfully returns an object.
		 * <BR><BR>
		 * @param resultObject This object is what is returned from ResultEvent's result object. It is a DTO object.
		 */ 
		protected function resultCallback( resultObject:Object ):void{
			throw new Error( "Not Implemented" );
		}
	}
}
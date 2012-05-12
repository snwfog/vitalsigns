package domain
{
	import domain.model.IDomainObject;
	

	/**
	 * Interface to be implemented by view controllers. The functions implemented by
	 * the controllers are called by the domain Commands, after the respective handler
	 * is fired from the web service.
	 */ 
	public interface IObservable
	{
		/**
		 * Handles a successful web service call, on the application level
		 */ 
		function resultHandler( DO:Object ):void;
		
		/**
		 * Handles a failed web service call, on the application level
		 */ 
		function faultHandler( message:String ):void;
	}
}
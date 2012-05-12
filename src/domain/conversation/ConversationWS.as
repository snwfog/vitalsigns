package domain.conversation
{
	import domain.wrapper.WrapperWS;
	
	import services.VitalSignService;
	
	import valueObjects.MessageDTO;
	import valueObjects.UserDTO;
	
	public class ConversationWS extends WrapperWS
	{
		public function ConversationWS( resultCallback:Function, faultCallback:Function ){
			super( resultCallback, faultCallback );
		}
		
		public function getAllMessagesByUser( user:UserDTO ):void{
			addCallback( VitalSignService.instance.getAllMessagesByUser( user ) );
		}
		
		public function getNewMessagesByUser( user:UserDTO ):void{
			addCallback( VitalSignService.instance.getNewMessagesByUser( user ) );
		}
		
		public function markConversationAsRead( conversationid:int, userid:int ):void{
			addCallback( VitalSignService.instance.markConversationAsRead( conversationid, userid ) );
		}
		
		public function insertNewMessage( message:MessageDTO ):void{
			addCallback( VitalSignService.instance.insertNewMessage( message ) );
		}
	}
}
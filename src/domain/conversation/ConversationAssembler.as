package domain.conversation
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.message.Message;
	import domain.message.MessageAssembler;
	import domain.model.IDomainObject;
	import domain.user.User;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.MessageDTO;
	
	public class ConversationAssembler implements IAssembler
	{
		
		private var _messageAssembler:MessageAssembler;
		private var _viewer:User; // the user logged in
		
		public function ConversationAssembler( user:User ){
			_messageAssembler = new MessageAssembler();
			_viewer = user;
		}
		
		public function createDataTransferObject(DomainObject:IDomainObject):IDataTransferObject
		{
			return null;
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection
		{
			return null;
		}
		
		public function createDomainObject(DTO:IDataTransferObject):IDomainObject
		{
			return null;
		}
		
		public function createDOArray(DTOArray:Object):ArrayCollection
		{
			if( DTOArray == null )
				return new ArrayCollection();
			
			var arrDTOs:ArrayCollection;
			var arrConversations:ArrayCollection = new ArrayCollection();
			
			if( DTOArray is ArrayCollection )
				arrDTOs = DTOArray as ArrayCollection;
			else
				arrDTOs = new ArrayCollection( [ _messageAssembler.buildDTOFromObjectProxy( DTOArray as ObjectProxy ) ] );
			
			for each( var dto:MessageDTO in arrDTOs ){
				var message:Message = _messageAssembler.createDomainObject( dto as MessageDTO ) as Message;
				var isAdded:Boolean = false;
				for each( var conversation:Conversation in arrConversations ){
					if( conversation.conversationid == dto.conversationid ){
						conversation.addMessage( message );
						isAdded = true;
					}
				}
				if( !isAdded )
					arrConversations.addItem( new Conversation( dto.conversationid, _viewer, message ) );
			}
			
			return arrConversations;
		}
		
		public function updateDomainObject(DTO:IDataTransferObject):void
		{
		}
		
		public function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject{
			return null;
		}
	}
}
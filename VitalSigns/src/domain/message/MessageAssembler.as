package domain.message
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.MessageDTO;
	
	public class MessageAssembler implements IAssembler
	{
		public function MessageAssembler()
		{
		}
		
		public function createDataTransferObject( DomainObject:IDomainObject ):IDataTransferObject{
			var message:Message = DomainObject as Message;
			var newMessageDTO:MessageDTO = new MessageDTO();
			newMessageDTO.authorid = message.authorid;
			newMessageDTO.recipientid = message.recipientid;
			newMessageDTO.body = message.body;
			newMessageDTO.conversationid = message.authorid + message.recipientid;
			newMessageDTO.created = message.created;
			
			return newMessageDTO;
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection
		{
			return null;
		}
		
		public function createDomainObject(DTO:IDataTransferObject):IDomainObject
		{
			var messageDTO:MessageDTO = DTO as MessageDTO;
			var messageid:int = messageDTO.messageid;
			var authorid:int = messageDTO.authorid;
			var recipientid:int = messageDTO.recipientid;
			var body:String = messageDTO.body;
			var created:Date = messageDTO.created;
			var isNew:Boolean = messageDTO.isNew;
			var message:Message = new Message( messageid, authorid, recipientid, body, created, isNew );
			
			return message;
		}
		
		public function createDOArray(DTOArray:Object):ArrayCollection
		{
			return null;
		}
		
		public function updateDomainObject(DTO:IDataTransferObject):void
		{
		}
		
		public function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject{
			var dto:MessageDTO = new MessageDTO();
			dto.messageid = proxy.messageid;
			dto.authorid = proxy.authorid;
			dto.recipientid = proxy.recipientid;
			dto.body = proxy.body;
			dto.conversationid = proxy.conversationid;
			dto.created = proxy.created;
			dto.isNew = proxy.isNew;
			
			return dto;
		}
	}
}
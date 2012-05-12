package domain.user
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.image.Image;
	import domain.image.ImageAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.UserDTO;
	
	public class UserAssembler implements IAssembler
	{
		
		public function UserAssembler(){}
		
		public function createDOArray( DTOArray:Object ):ArrayCollection
		{
			var arrDTO:ArrayCollection = null;
			if( DTOArray is ArrayCollection )
				arrDTO = DTOArray as ArrayCollection;
			else
				arrDTO = new ArrayCollection( [ buildDTOFromObjectProxy( DTOArray as ObjectProxy ) ] );
			
			var arrUsers:ArrayCollection = new ArrayCollection();
			
			for each( var dto:UserDTO in arrDTO )
				arrUsers.addItem( createDomainObject( dto ) );
				
			return arrUsers;
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function createDataTransferObject( DomainObject:IDomainObject ):IDataTransferObject{
			var user:User = DomainObject as User;
			var userDTO:UserDTO = new UserDTO();
			userDTO.userId = user.userId;
			userDTO.username = user.username;
			userDTO.nullPassword = user.nullPassword;
			userDTO.memo = user.memo;
			userDTO.passwords = addImageDTOs( user.passwords );
			userDTO.site = user.site;
			userDTO.unit = user.unit;
			return userDTO;
		}
		
		public function createDomainObject( DTO:IDataTransferObject ):IDomainObject{
			if( DTO == null )
				return null;
			
			var userDTO:UserDTO = DTO as UserDTO;
			var user:User = new User( userDTO.username, userDTO.userId, userDTO.nullPassword, userDTO.memo, userDTO.firstName, userDTO.lastName );
			return user;
		}
		
		public function updateDomainObject(DTO:IDataTransferObject):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject{
			var userDTO:UserDTO = new UserDTO();
			userDTO.userId = proxy.userId;
			userDTO.username = proxy.username;
			userDTO.nullPassword = proxy.nullPassword;
			userDTO.memo = proxy.memo;
			userDTO.site = proxy.site;
			userDTO.unit = proxy.unit;
			return userDTO;
		}
		
		/**
		 * transforms the images in password to an array of ImageDTOs
		 * 
		 * @param images ArrayCollection of Image objects
		 * @return ArrayCollection of ImageDTOs
		 */
		private function addImageDTOs( images:ArrayCollection ):ArrayCollection{
			var imageAssembler:ImageAssembler = new ImageAssembler();
			var arrImageDTO:ArrayCollection = new ArrayCollection();
			for( var i:int = 0; i < images.length; i++ )
				arrImageDTO.addItem( imageAssembler.createDataTransferObject( images.getItemAt( i ) as Image ) );
			
			return arrImageDTO;
		}
		
		
	}
}
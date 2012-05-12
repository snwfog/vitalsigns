package domain.image
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.ImageDTO;
	
	public class ImageAssembler implements IAssembler
	{
		
		public function ImageAssembler(){}
		
		public function createDataTransferObject(DomainObject:IDomainObject):IDataTransferObject
		{
			var image:Image = DomainObject as Image;
			if( image == null )
				return null;
			
			var imageDTO:ImageDTO = new ImageDTO();
			imageDTO.imageId = image.imageId;
			imageDTO.image = image.image;
			imageDTO.category = image.category;
			imageDTO.originalName = image.originalName;
			
			return imageDTO;
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection
		{
			if (DOArray == null || DOArray.length == 0)
				return null;
			var result:ArrayCollection = new ArrayCollection();
			for(var index:int = 0; index < DOArray.length; index++)
				result.addItem(createDataTransferObject(DOArray.getItemAt(index) as Image) as ImageDTO);
			return result;
		}
		
		public function createDOArray( DTOArray:Object ):ArrayCollection{
			var arrDTO:ArrayCollection;
			var arrDO:ArrayCollection = new ArrayCollection();
			if( DTOArray is ArrayCollection )
				arrDTO = DTOArray as ArrayCollection;
			else
				arrDTO = new ArrayCollection( [ buildDTOFromObjectProxy( DTOArray as ObjectProxy ) ] );
			
			for each( var item:Object in arrDTO )
				arrDO.addItem( new Image( item.imageId, item.image, item.category, item.originalName ) );
					
			return arrDO;
			
		}
		
		public function createDomainObject(DTO:IDataTransferObject):IDomainObject{
			return null;
		}
		
		public function updateDomainObject(DTO:IDataTransferObject):void
		{
		}
		
		public function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject{
			var imageDTO:ImageDTO = new ImageDTO();
			imageDTO.imageId = proxy.imageId;
			imageDTO.image = proxy.image;
			imageDTO.category = proxy.category;
			imageDTO.originalName = proxy.originalName;
			
			return imageDTO;
		}
	}
}
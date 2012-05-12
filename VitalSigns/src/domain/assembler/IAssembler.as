package domain.assembler
{
	import domain.DTO.IDataTransferObject;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;

	public interface IAssembler
	{
		function createDataTransferObject( DomainObject:IDomainObject ):IDataTransferObject;
		function createDTOArray( DOArray:ArrayCollection ):ArrayCollection;
		
		function createDomainObject( DTO:IDataTransferObject ):IDomainObject;
		function createDOArray( DTOArray:Object ):ArrayCollection;
		
		function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject;
	}
}
package domain.lab
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.LabListDTO;

	public class LabListAssembler implements IAssembler
	{
		public function LabListAssembler()
		{
		}
		
		public function createDataTransferObject(DomainObject:IDomainObject):IDataTransferObject
		{
			return null;
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection
		{
			return null;
		}
		
		public function createDOArray(DTOArray:Object):ArrayCollection
		{
			var arrDTOs:ArrayCollection;
			var arrLabList:ArrayCollection = new ArrayCollection();
			if(DTOArray is ArrayCollection)
				arrDTOs = DTOArray as ArrayCollection;
			else 
				arrDTOs = new ArrayCollection( [ buildDTOFromObjectProxy( DTOArray as ObjectProxy ) ] );
			
			for each(var dto:LabListDTO in arrDTOs){
				if(dto == null)
					return null;
				arrLabList.addItem( createDomainObject( dto ) );
			}
			
			return arrLabList;
		}
		
		public function updateDomainObject(DTO:IDataTransferObject):void
		{
		}
		
		public function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject
		{
			var dto:LabListDTO = new LabListDTO();
			if( proxy === null ){
				return null;
			}
			var resultDate:Date = new Date(proxy.resultDate);
			var collectedDate:Date = new Date(proxy.collectedDate);
			
			dto.resultDate = resultDate;
			dto.servTypeChildAcro = proxy.servTypeChildAcro;
			dto.servTypeChildLongDesc = proxy.servTypeChildLongDesc;
			dto.result = proxy.result;
			dto.resultUnit = proxy.resultUnit;
			dto.rangeReference = proxy.rangeReference;
			dto.rangeIndicator = proxy.rangeIndicator;
			dto.pid = proxy.pid;
			dto.sid = proxy.sid;
			dto.encounterID = proxy.encounterID;
			dto.collectedDate = collectedDate;
			dto.genLabType = proxy.genLabType;
			dto.state = proxy.state;
			dto.fillerNumber = proxy.fillerNumber;
			dto.servTypeRootAcro = proxy.servTypeRootAcro;
			dto.sortChildSeq = proxy.sortChildSeq;
			
			return dto;
		}
		
		public function createDomainObject(DTO:IDataTransferObject):IDomainObject
		{	
			var item:LabListDTO = DTO as LabListDTO;
			var temp:LabList = new LabList();
			
			var resultDate:Date = new Date(item.resultDate);
			var collectedDate:Date = new Date(item.collectedDate);
			
			temp.resultDate = resultDate;
			temp.servTypeChildAcro = item.servTypeChildAcro;
			temp.servTypeChildLongDesc = item.servTypeChildLongDesc;
			temp.result = item.result;
			temp.resultUnit = item.resultUnit;
			temp.rangeReference = item.rangeReference;
			temp.rangeIndicator = item.rangeIndicator;
			temp.pid = item.pid;
			temp.sid = item.sid;
			temp.encounterID = item.encounterID;
			temp.collectedDate = collectedDate;
			temp.genLabType = item.genLabType;
			temp.state = item.state;
			temp.fillerNumber = item.fillerNumber;
			temp.servTypeRootAcro = item.servTypeRootAcro;
			temp.sortChildSeq = item.sortChildSeq;
			
			return temp;
		}
		
		
	}
}
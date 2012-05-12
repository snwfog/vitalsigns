package domain.patient
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.PatientDTO;
	
	public class PatientAssembler implements IAssembler
	{
		public function PatientAssembler(){}
		
		public function createDataTransferObject(DomainObject:IDomainObject):IDataTransferObject
		{
			var patient:Patient = DomainObject as Patient;
			var patientDTO:PatientDTO = new PatientDTO();
			patientDTO.patientId = patient.patientId;
			patientDTO.address = patient.address;
			patientDTO.bed = patient.bed;
			patientDTO.birthDate = patient.birthDate;
			patientDTO.city = patient.city;
			patientDTO.doctor = patient.doctor;
			patientDTO.doctorTel = patient.doctorTel;
			patientDTO.encounterId = patient.encounterId;
			patientDTO.enFillerNum = patient.enFillerNum;
			patientDTO.extAppId = patient.extAppId;
			patientDTO.firstName = patient.firstName;
			patientDTO.height = patient.height;
			patientDTO.heightUnit = patient.heightUnit;
			patientDTO.lastName = patient.lastName;
			patientDTO.mrn = patient.mrn;
			patientDTO.nursingUnit = patient.nursingUnit;
			patientDTO.postalCode = patient.postalCode;
			patientDTO.province = patient.province;
			patientDTO.readOnly = patient.readOnly;
			patientDTO.room = patient.room;
			patientDTO.sexCd = patient.sexCd;
			patientDTO.weight = patient.weight;
			patientDTO.weightUnit = patient.weightUnit;
			return patientDTO;
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection
		{
			
			return null;
		}
		
		public function createDomainObject(DTO:IDataTransferObject):IDomainObject
		{
			var item:PatientDTO = DTO as PatientDTO;
			var temp:Patient = new Patient();
			
			var roomBed:Array = item.bed.split( "-" );
			
			temp.address = item.address;
			temp.bed = roomBed[ 1 ];
			temp.birthDate = item.birthDate as Date;
			temp.city = item.city;
			temp.doctor = item.doctor;
			temp.doctorTel = item.doctorTel;
			temp.encounterId = item.encounterId as Number;
			temp.enFillerNum = item.enFillerNum;
			temp.extAppId = item.extAppId;
			temp.firstName = item.firstName;
			temp.height = item.height as Number;
			temp.heightUnit = item.heightUnit;
			temp.lastName = item.lastName;
			temp.mrn = item.mrn;
			temp.nursingUnit = item.nursingUnit;
			temp.patientId = item.patientId as Number;
			temp.postalCode = item.postalCode;
			temp.province = item.province;
			temp.readOnly = item.readOnly as Boolean;
			temp.sexCd = item.sexCd;
			temp.weight = item.weight as Number;
			temp.weightUnit = item.weightUnit;
			temp.room = roomBed[ 0 ];
			
			return temp;
		}
		
		public function createDOArray(DTOArray:Object):ArrayCollection{
			var arrDTOs:ArrayCollection;
			var arrPatients:ArrayCollection = new ArrayCollection();
			
			if( DTOArray is ArrayCollection )
				arrDTOs = DTOArray as ArrayCollection;
			else
				arrDTOs = new ArrayCollection( [ buildDTOFromObjectProxy( DTOArray as ObjectProxy ) ] );
			
			for each( var dto:PatientDTO in arrDTOs ){
				arrPatients.addItem( createDomainObject( dto ) );
			}
			
			return arrPatients;
		}
		
		public function updateDomainObject(DTO:IDataTransferObject):void
		{
		}
		
		public function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject{
			var dto:PatientDTO = new PatientDTO();
			
			var roomBed:Array = proxy.bed.split( "-" );
			
			dto.address = proxy.address;
			dto.bed = roomBed[ 1 ];
			dto.birthDate = proxy.birthDate as Date;
			dto.city = proxy.city;
			dto.doctor = proxy.doctor;
			dto.doctorTel = proxy.doctorTel;
			dto.encounterId = proxy.encounterId as Number;
			dto.enFillerNum = proxy.enFillerNum;
			dto.extAppId = proxy.extAppId;
			dto.firstName = proxy.firstName;
			dto.height = proxy.height as Number;
			dto.heightUnit = proxy.heightUnit;
			dto.lastName = proxy.lastName;
			dto.mrn = proxy.mrn;
			dto.nursingUnit = proxy.nursingUnit;
			dto.patientId = proxy.patientId as Number;
			dto.postalCode = proxy.postalCode;
			dto.province = proxy.province;
			dto.readOnly = proxy.readOnly as Boolean;
			dto.sexCd = proxy.sexCd;
			dto.weight = proxy.weight as Number;
			dto.weightUnit = proxy.weightUnit;
			dto.room = roomBed[ 0 ];
			
			return dto;
		}
	}
}
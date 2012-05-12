package domain.vitalsign
{
	import domain.DTO.IDataTransferObject;
	import domain.assembler.IAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import valueObjects.VitalSignDTO;

	public class VitalSignAssembler implements IAssembler
	{
		public function VitalSignAssembler(){}
		
		public function createDOArray( DTOArray:Object ):ArrayCollection{
			if( DTOArray == null )
				return new ArrayCollection();
			
			var arrDTOs:ArrayCollection;
			var arrVitalSigns:ArrayCollection = new ArrayCollection();
			
			var systolicList:VitalSignList;
			var diastolicList:VitalSignList;
			var diastolicListIndex:int = 0;
			
			if( DTOArray is ArrayCollection )
				arrDTOs = DTOArray as ArrayCollection;
			else
				arrDTOs = new ArrayCollection( [ buildDTOFromObjectProxy( DTOArray as ObjectProxy ) ] );
	
			for each( var dto:VitalSignDTO in arrDTOs ){
				var vs:VitalSign = createDomainObject( dto ) as VitalSign;
				var isAdded:Boolean = false;
				for each( var currentList:VitalSignList in arrVitalSigns ){
					if( currentList.type == dto.type ){
						currentList.list.addItem( vs );
						isAdded = true;
					}
				}
				
				if( !isAdded ){
					var newList:VitalSignList = new VitalSignList( vs.type );
					if( vs.type == VitalSignType.SYSTOLIC )
						systolicList = newList;
					else if( vs.type == VitalSignType.DIASTOLIC ){
						diastolicList = newList;
						diastolicListIndex = arrVitalSigns.length; // index is current length because it has not been added yet
					}
					newList.list.addItem( vs );
					arrVitalSigns.addItem( newList );
				}
			}
			
			concatenateBloodPressure( systolicList, diastolicList );
			arrVitalSigns.removeItemAt( diastolicListIndex ); // remove diastolic from list of Vital Signs
			
			return arrVitalSigns;
			
		}
		
		public function createDTOArray(DOArray:ArrayCollection):ArrayCollection{
			return null;
		}
		
		public function createDataTransferObject( DomainObject:IDomainObject ):IDataTransferObject{
			return null;
		}
		
		public function createDomainObject( DTO:IDataTransferObject ):IDomainObject{
			if( DTO == null )
				return null;
			
			var vsDTO:VitalSignDTO = DTO as VitalSignDTO;
			var newVS:VitalSign = VitalSignFactory.createVitalSign( vsDTO.type );
			
			if( newVS != null ){
				newVS.sid = vsDTO.sid;
				newVS.description = vsDTO.description;
				newVS.value = vsDTO.value;
				newVS.lastChgDtm = vsDTO.lastChgDtm;
				newVS.method = vsDTO.method;
				newVS.type = vsDTO.type;
				newVS.position = vsDTO.position;
				newVS.unit = vsDTO.unit;
				newVS.alert = vsDTO.alert;
				newVS.site = vsDTO.site;
				newVS.intDate = vsDTO.lastChgDtm.valueOf();
				
				if( newVS is BloodPressureVitalSign )
					( newVS as BloodPressureVitalSign ).diastolic = VitalSign.defaultValue;
			}
			
			return newVS;
		}
		
		public function updateDomainObject(DTO:IDataTransferObject):void{
			
		}
		
		public function buildDTOFromObjectProxy( proxy:ObjectProxy ):IDataTransferObject{
			return null;
		}
		
		private function concatenateBloodPressure( systolicList:VitalSignList, diastolicList:VitalSignList ):void{
			var systolicIndex:int = 0;
			var diastolicIndex:int = 0;
			
			for( ; diastolicIndex < diastolicList.list.length; diastolicIndex++ ){
				var currentDiastolic:BloodPressureVitalSign = diastolicList.list.getItemAt( diastolicIndex ) as BloodPressureVitalSign;
				while( currentDiastolic.intDate > ( systolicList.list.getItemAt( systolicIndex ) as VitalSign ).intDate ){
					systolicIndex++;
					if( systolicIndex == systolicList.list.length ){
						for( ; diastolicIndex < diastolicList.list.length; diastolicIndex++ ){
							currentDiastolic = diastolicList.list.getItemAt( diastolicIndex ) as BloodPressureVitalSign;
							switchDiastolic( currentDiastolic );
							systolicList.list.addItem( currentDiastolic );
						}
						return;
					}
				}
				
				var currentSystolic:BloodPressureVitalSign = systolicList.list.getItemAt( systolicIndex ) as BloodPressureVitalSign;
				if( currentDiastolic.intDate == currentSystolic.intDate )
					currentSystolic.diastolic = currentDiastolic.value;
				else{
					switchDiastolic( currentDiastolic );
					systolicList.list.addItemAt( currentDiastolic, systolicIndex );
				}
			}
		}
		
		private function switchDiastolic( currentDiastolic:BloodPressureVitalSign ):void{
			currentDiastolic.diastolic = currentDiastolic.value;
			currentDiastolic.systolic = VitalSign.defaultValue;
		}
	}
}
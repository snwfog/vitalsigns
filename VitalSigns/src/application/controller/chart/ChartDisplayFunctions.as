package application.controller.chart
{
	import domain.vitalsign.VitalSign;
	
	import mx.collections.ArrayCollection;

	public class ChartDisplayFunctions
	{
		public function ChartDisplayFunctions(){
			throw new Error( "Only static functions" );
		}
		
		public static function isValueOk( value:String ):Boolean{
			return !( value == "" || value == VitalSign.defaultValue );
		}
		
		public static function syncLists( list1:ArrayCollection, list2:ArrayCollection, arrRawData:ArrayCollection,
										   addToRawDataList:Function, newEmptyVitalSign:Function ):void{
			var index1:int = list1.length - 1;
			var index2:int = list2.length - 1;
			
			while( index1 >= 0 && index2 >= 0 ){
				var list1Vital:VitalSign = list1.getItemAt( index1 ) as VitalSign;
				var list2Vital:VitalSign = list2.getItemAt( index2 ) as VitalSign;
				
				if( list1Vital.intDate == list2Vital.intDate ){
					addToRawDataList( arrRawData, list1Vital, list2Vital, list1Vital.lastChgDtm );
					index1--;
					index2--;
				} else if( list1Vital.intDate < list2Vital.intDate ){
					addToRawDataList( arrRawData, new VitalSign( VitalSign.defaultValue ), list2Vital, list2Vital.lastChgDtm );
					index2--;
				} else {
					addToRawDataList( arrRawData, list1Vital, newEmptyVitalSign(), list1Vital.lastChgDtm );
					index1--;
				}
			}
			
			// if index1 still > 0
			for( ; index1 >= 0; index1-- ){
				var l1Vital:VitalSign = list1.getItemAt( index1 ) as VitalSign;
				addToRawDataList( arrRawData, l1Vital, newEmptyVitalSign(), l1Vital.lastChgDtm ); 
			}
			
			// if index2 still > 0
			for( ; index2 >= 0; index2-- ){
				var l2Vital:VitalSign = list2.getItemAt( index2 ) as VitalSign;
				addToRawDataList( arrRawData, new VitalSign( VitalSign.defaultValue ), l2Vital, l2Vital.lastChgDtm ); 
			}
		}
		
		public static function addToList( arrRawData:ArrayCollection, firstVS:VitalSign, secondVS:VitalSign, lastChgDtm:Date ):void{
			var rawDataObject:Object = new Object();
			rawDataObject.lastChgDtm = lastChgDtm;
			rawDataObject.firstVitalSign = firstVS;
			rawDataObject.secondVitalSign = secondVS;
			arrRawData.addItem( rawDataObject );
		}
	}
}
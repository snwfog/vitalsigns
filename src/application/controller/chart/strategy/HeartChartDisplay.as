package application.controller.chart.strategy
{
	import application.component.TriangleRenderer;
	import application.component.chart.MultiValueRenderer;
	import application.controller.chart.ChartController;
	import application.controller.chart.ChartDisplayFunctions;
	
	import domain.patient.Patient;
	import domain.vitalsign.BloodPressureVitalSign;
	import domain.vitalsign.VitalSign;
	import domain.vitalsign.VitalSignType;
	
	import mx.charts.renderers.CircleItemRenderer;
	import mx.charts.renderers.TriangleItemRenderer;
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	
	public class HeartChartDisplay implements IChartDisplay
	{
		
		private var _patient:Patient;
		private var _bpList:ArrayCollection; // list of BloodPressureVitalSign
		private var _hrList:ArrayCollection; // list of HeartVitalSign
		
		private const _interval:int = 15;
		
		private var currentmin:Number = 0;
		private var currentmax:Number = 0;
		
		private var seriesArray:ArrayCollection;
		
		public function HeartChartDisplay( patient:Patient, bpList:ArrayCollection, hrList:ArrayCollection ){
			_patient = patient;
			_bpList = bpList;
			_hrList = hrList;
			seriesArray = new ArrayCollection();
		}
		
		public function prepareData( chartController:ChartController ):void{
			chartController.patient_name = _patient.firstName + " " + _patient.lastName;
			chartController.chart_type = VitalSignType.NormalName[ VitalSignType.HEARTRATE ] + " / " + VitalSignType.NormalName[ VitalSignType.SYSTOLIC ];

			currentmin = Number( ( _bpList.getItemAt( 0 ) as VitalSign ).value );
			currentmax = currentmin;
			
			ChartDisplayFunctions.syncLists( _hrList, _bpList, chartController.arrRawData, addToRawDataList, createBPVital );
			
			chartController.lstChart = seriesArray;
			chartController.verticalmin = currentmin - _interval > 0 ? currentmin - _interval : 0;
			chartController.verticalmax = currentmax + _interval;
			
			chartController.lineData = generateLines();
		}
		
		public function compareBloodPressure( list1VS:VitalSign ):void{
			var bpVital:BloodPressureVitalSign = list1VS as BloodPressureVitalSign;
			var systolic:Number = Number( bpVital.systolic );
			var diastolic:Number = Number( bpVital.diastolic );
			
			if( diastolic < currentmin )
				currentmin = diastolic;
			
			if( systolic < currentmin )
				currentmin = systolic;
			
			if( diastolic > currentmax )
				currentmax = diastolic;
			
			if( systolic > currentmax )
				currentmax = systolic;
		}
		
		public function compareRespiration( list2VS:VitalSign ):void{
			var nValue:Number = Number( list2VS.value );
			
			if( nValue < currentmin )
				currentmin = nValue;
			
			if( nValue > currentmax )
				currentmax = nValue;
		}
		
		private function generateLines():ArrayCollection{
			var lineArr:ArrayCollection = new ArrayCollection();
			
			for each( var obj:Object in seriesArray ){
				if( obj.systolic != "" && obj.diastolic != "" ){
					var obj1:Object = new Object();
					var obj2:Object = new Object();
					obj1.date = obj.lastChgDtm;
					obj1.datay = obj.systolic;
					
					obj2.date = obj.lastChgDtm;
					obj2.datay = obj.diastolic;
					
					lineArr.addItem( obj1 );
					lineArr.addItem( obj2 );
				}
			}
			return lineArr;
		}
		
		private function createBPVital():VitalSign{
			return new BloodPressureVitalSign();
		}
		
		private function addToRawDataList( arrRawData:ArrayCollection, firstVS:VitalSign, secondVS:VitalSign, lastChgDtm:Date ):void{
			ChartDisplayFunctions.addToList( arrRawData, firstVS, secondVS, lastChgDtm );
			
			var seriesObject:Object = new Object();
			seriesObject.lastChgDtm = lastChgDtm;
			seriesObject.systolic = ( secondVS as BloodPressureVitalSign ).systolic;
			seriesObject.diastolic = ( secondVS as BloodPressureVitalSign ).diastolic;
			seriesObject.rate = firstVS.value;
			
			compareRespiration( firstVS );
			compareBloodPressure( secondVS );
			
			seriesArray.addItem( seriesObject );
		}
		
		public function getRawDataRenderer():ClassFactory{
			return new ClassFactory( MultiValueRenderer );
		}
		
		public function getState( isPortrait:Boolean ):String{
			if( isPortrait )
				return ChartController.RAWDATASTATE;
			return ChartController.HEARTCHARTSTATE;
		}
		
		public function getDisplayName():String{
			return "";
		}
		
		public function getInterval():int{
			return _interval;
		}
	}
}
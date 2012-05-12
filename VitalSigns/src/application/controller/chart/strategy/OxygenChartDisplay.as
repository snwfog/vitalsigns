package application.controller.chart.strategy
{
	import application.component.chart.MultiValueRenderer;
	import application.controller.chart.ChartController;
	import application.controller.chart.ChartDisplayFunctions;
	
	import domain.patient.Patient;
	import domain.vitalsign.VitalSign;
	import domain.vitalsign.VitalSignType;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	
	public class OxygenChartDisplay implements IChartDisplay
	{
		
		private var _patient:Patient;
		private var _oxygenList:ArrayCollection;
		private var _saturationList:ArrayCollection;
		
		private var currentminOxygen:Number;
		private var currentmaxOxygen:Number;
		
		private var currentminSaturation:Number;
		private var currentmaxSaturation:Number;
		
		private var arrSeries:ArrayCollection;
		
		public function OxygenChartDisplay( patient:Patient, oxygenList:ArrayCollection, saturationList:ArrayCollection ){
			_patient = patient;
			_oxygenList = oxygenList;
			_saturationList = saturationList;
			
			arrSeries = new ArrayCollection();
		}
		
		public function prepareData( chartController:ChartController ):void{
			chartController.patient_name = _patient.firstName + " " + _patient.lastName;
			chartController.chart_type = VitalSignType.NormalName[ VitalSignType.OXYGEN ] + " / " + VitalSignType.NormalName[ VitalSignType.O2SATURATION ];
			
			currentminOxygen = Number( ( _oxygenList.getItemAt( 0 ) as VitalSign ).value );
			currentmaxOxygen = currentminOxygen;
			
			currentminSaturation = Number( ( _saturationList.getItemAt( 0 ) as VitalSign ).value );
			currentmaxSaturation = currentminSaturation;
			
			ChartDisplayFunctions.syncLists( _oxygenList, _saturationList, chartController.arrRawData, addToRawDataList, newEmptyVitalSign );
			chartController.lstChart = arrSeries;
			
			chartController.minO2 = currentminOxygen - 1 > 0 ? currentminOxygen - 1 : 0;
			chartController.maxO2 = currentmaxOxygen + 1;
			
			chartController.minSat = currentminSaturation - 1 > 0 ? currentminSaturation - 1 : 0;
			chartController.maxSat = currentmaxSaturation + 1;
		}
		
		public function addToRawDataList( arrRawData:ArrayCollection, firstVS:VitalSign, secondVS:VitalSign, lastChgDtm:Date ):void{
			ChartDisplayFunctions.addToList( arrRawData, firstVS, secondVS, lastChgDtm );
			
			compareOxygen( firstVS );
			compareSaturation( secondVS );
			
			var newObj:Object = new Object();
			newObj.lastChgDtm = lastChgDtm;
			newObj.oxygen = firstVS.value;
			newObj.saturation = secondVS.value;
			arrSeries.addItem( newObj );
		}
		
		public function newEmptyVitalSign():VitalSign{
			return new VitalSign( VitalSign.defaultValue );	
		}
		
		private function compareOxygen( firstVS:VitalSign ):void{
			var nValue:Number = Number( firstVS.value );
			if( nValue < currentminOxygen )
				currentminOxygen = nValue;
			
			if( nValue > currentmaxOxygen )
				currentmaxOxygen = nValue;
		}
		
		private function compareSaturation( secondVS:VitalSign ):void{
			var nValue:Number = Number( secondVS.value );
			if( nValue < currentminSaturation )
				currentminSaturation = nValue;
			
			if( nValue > currentmaxSaturation )
				currentmaxSaturation = nValue;
		}
		
		public function getRawDataRenderer():ClassFactory{
			return new ClassFactory( MultiValueRenderer );
		}
		
		public function getState( isPortrait:Boolean ):String{
			if( isPortrait )
				return ChartController.RAWDATASTATE;
			return ChartController.OXYGENCHARTSTATE;
		}
		
		public function getDisplayName():String{
			return "";
		}
		
		public function getInterval():int{
			return 0;
		}
	}
}
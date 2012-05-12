package application.controller.chart.strategy
{
	import application.component.chart.SingleValueRenderer;
	import application.controller.chart.ChartController;
	import application.controller.chart.ChartDisplayFunctions;
	
	import domain.patient.Patient;
	import domain.vitalsign.VitalSign;
	import domain.vitalsign.VitalSignType;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	
	/**
	 * Displays the chart and raw data for Vital Sign categories with only 1 Vital Sign.<BR>
	 * Handles the following: Temperature, Respiration, Pain Scale, Height, Weight 
	 */ 
	public class RegularChartDisplay implements IChartDisplay
	{
		private var _patient:Patient;
		private var inputList:ArrayCollection;
		private var chartType:String;
		
		private const _interval:int = 1;
		
		public function RegularChartDisplay( patient:Patient, list:ArrayCollection, type:String ){
			_patient = patient;
			inputList = list;
			chartType = type;
		}
		
		public function prepareData( chartController:ChartController ):void{
			chartController.patient_name = _patient.firstName + " " + _patient.lastName;
			chartController.chart_type = VitalSignType.NormalName[ chartType ];
			
			var currentmin:Number = Number( ( inputList.getItemAt( 0 ) as VitalSign ).value );
			var currentmax:Number = currentmin;
			
			for( var i:int = inputList.length - 1; i >= 0; i-- ){
				var currentVitalSign:VitalSign = inputList.getItemAt( i ) as VitalSign;
				chartController.arrRawData.addItem( currentVitalSign );
				if( ChartDisplayFunctions.isValueOk( currentVitalSign.value ) ){
					var nValue:Number = Number( currentVitalSign.value );
					currentmax = nValue > currentmax ? nValue : currentmax;
					currentmin = nValue < currentmin ? nValue : currentmin;
				}
			}
			
			chartController.verticalmin = currentmin - _interval > 0 ? currentmin - _interval : 0;
			chartController.verticalmax = currentmax + _interval;
			
			chartController.lstChart = inputList;
		}
		
		public function getRawDataRenderer():ClassFactory{
			return new ClassFactory( SingleValueRenderer );
		}
		
		public function get interval():int{
			return _interval;
		}
		
		public function getState( isPortrait:Boolean ):String{
			if( isPortrait )
				return ChartController.RAWDATASTATE;
			return ChartController.DEFAULTCHARTSTATE;
		}
		
		public function getDisplayName():String{
			return VitalSignType.NormalName[ chartType ];
		}
		
		public function getInterval():int{
			return _interval;
		}
	}
}
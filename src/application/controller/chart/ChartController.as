package application.controller.chart
{
	import application.controller.chart.strategy.IChartDisplay;
	import application.controller.messaging.NotificationController;
	
	import mx.charts.CategoryAxis;
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
	
	public class ChartController extends NotificationController
	{
		[Bindable]public var patient_name:String = "John Smith";
		[Bindable]public var chart_type:String = "Generic Chart";
		
		[Bindable]public var arrRawData:ArrayCollection = new ArrayCollection(); // raw data list dataprovider
		[Bindable]public var lstChart:ArrayCollection = new ArrayCollection(); // list of objects to be displayed on the chart
		[Bindable]public var lineData:ArrayCollection = new ArrayCollection(); // list of line objects to connect systolic and diastolic
		
		[Bindable]public var verticalmax:Number = 0;
		[Bindable]public var verticalmin:Number = 0;
		
		[Bindable]public var minSat:Number;
		[Bindable]public var maxSat:Number;
		[Bindable]public var minO2:Number;
		[Bindable]public var maxO2:Number;
		
		public static const RAWDATASTATE:String = "rawdata";
		public static const DEFAULTCHARTSTATE:String = "defaultChart";
		public static const HEARTCHARTSTATE:String = "heartChart";
		public static const OXYGENCHARTSTATE:String = "oxygenChart";
		
		private var chartDisplay:IChartDisplay = null;
		
		public function ChartController( defaultBehaviour:Boolean = true ){
			super( defaultBehaviour );
		}
		
		public function chartcontroller_creationcompleteHandler( event:FlexEvent ):void{
			chartDisplay = data as IChartDisplay;
			chartDisplay.prepareData( this );
			VitalSigns.registerOrientationChangeListener( orientationChange, false );
		}
		
		public function selectItemRenderer( item:Object ):ClassFactory{
			return chartDisplay.getRawDataRenderer();
		}
		
		public function orientationChange():void{
			this.currentState = chartDisplay.getState( VitalSigns.isPortraitMode );
		}
		
		public function getDisplayName():String{
			return chartDisplay.getDisplayName();
		}
		
		public function getInterval():int{
			return chartDisplay.getInterval();
		}
		
		protected function categoryAxis_labelFunc(item:Object, prevValue:Object, axis:CategoryAxis, categoryItem:Object):String 
		{
			var dateNum:Number = Date.parse(item);
			var tempDate:Date = new Date(dateNum);
			
			var dateFormatter:DateFormatter = new DateFormatter();
			var timeFormatter:DateFormatter = new DateFormatter();
			
			dateFormatter.formatString = "MM-DD";
			timeFormatter.formatString = "JJ:NN A";
			var strDate:String = dateFormatter.format(tempDate).toUpperCase() + "\n" +
				timeFormatter.format(tempDate).toUpperCase();
			return strDate;
		}
	}
}
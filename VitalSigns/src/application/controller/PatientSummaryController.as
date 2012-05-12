package application.controller
{
	import application.controller.chart.strategy.HeartChartDisplay;
	import application.controller.chart.strategy.OxygenChartDisplay;
	import application.controller.chart.strategy.RegularChartDisplay;
	import application.view.DataEntry;
	import application.view.LoginView;
	import application.view.ConversationView;
	import application.view.ResourcesView;
	import application.view.chart.ChartView;
	import application.view.PatientProfileView;
	
	import domain.IObservable;
	import domain.command.GetVitalSignsCommand;
	import domain.patient.Patient;
	import domain.vitalsign.VitalSign;
	import domain.vitalsign.VitalSignFactory;
	import domain.vitalsign.VitalSignList;
	import domain.vitalsign.VitalSignType;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import model.ChartData;
	import model.DataEntryData;
	import model.StopWatch;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
	
	import spark.components.BusyIndicator;
	import spark.components.Label;
	import spark.components.View;
	import spark.events.PopUpEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionDirection;
	
	import testing.Timer;
	
	public class PatientSummaryController extends View implements IObservable
	{	
		public var patientName:Label;
		public var busyIndicator:BusyIndicator;
		public var accordion:SummaryAccordionController;
		
		private var dateformatter:DateFormatter = new DateFormatter();
		
		private var allVitalSigns:Dictionary;
		
		[Bindable]protected var patient:Patient;
		[Bindable]protected var recentResp:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentOxygen:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentO2:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentPain:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentRate:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentBP:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentTemp:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentWeight:ArrayCollection = new ArrayCollection();
		[Bindable]protected var recentHeight:ArrayCollection = new ArrayCollection();
		
		public var stopwatch:StopWatch = new StopWatch();
		
		public function PatientSummaryController(){
			super();
		}
		
		protected function patientsummarycontroller_addHandler(event:FlexEvent):void
		{			
			if(!data)
				return;
			
			patient = data as Patient;
			patientName.text = patient.lastName + ", " + patient.firstName;
			
			stopwatch.start();
			this.addElement(busyIndicator);
			var cmd:GetVitalSignsCommand = new GetVitalSignsCommand(this, patient);
			cmd.execute();
			
			this.accordion.enabled = false;
			this.accordion.mouseEnabled = false;
			
			VitalSigns.registerSwipeListener(viewChange);
		}
		
		private function viewChange(slide:SlideViewTransition = null, direction:String = null):void{
			//If valid direction remove listener and move to that view
			if(direction!=null){
				VitalSigns.removeSwipeListener();
				if(direction == "UP")
					navigator.pushView(ConversationView);
				else if (direction == "DOWN")
					navigator.popView(slide);
				else if (direction == "LEFT")
					navigator.replaceView(DataEntry, patient, null, slide);
				else if (direction == "RIGHT")
					navigator.replaceView(PatientProfileView, patient, null, slide);		
			}
		}
		
		private function makeSummaryLabelData():void
		{
			var iLimit:int = 4;
			
			// get "iLimit" latest entries for each vital sign
			getLatestDataLimit( allVitalSigns[ VitalSignType.RESPIRATION ], recentResp, iLimit );
			getLatestDataLimit( allVitalSigns[ VitalSignType.PAINSCALE ], recentPain, iLimit );
			getLatestDataLimit( allVitalSigns[ VitalSignType.TEMPERATURE ], recentTemp, iLimit );
			getLatestDataLimit( allVitalSigns[ VitalSignType.HEIGHT ], recentHeight, iLimit );
			getLatestDataLimit( allVitalSigns[ VitalSignType.WEIGHT ], recentWeight, iLimit );	
			getLatestDataLimit( allVitalSigns[ VitalSignType.SYSTOLIC ], recentBP, iLimit );
			getLatestDataLimit( allVitalSigns[ VitalSignType.HEARTRATE ], recentRate, iLimit );
			getLatestDataLimit( allVitalSigns[ VitalSignType.O2SATURATION ], recentO2, iLimit );
			getLatestDataLimit( allVitalSigns[ VitalSignType.OXYGEN ], recentOxygen, iLimit );
			
			if (recentBP.length > 0 || recentRate.length > 0)
				synchronizeData( recentBP, recentRate, iLimit );
			
			if (recentO2.length > 0 || recentOxygen.length > 0)
				synchronizeData( recentO2, recentOxygen, iLimit );
			
			this.accordion.enabled = true;
			this.accordion.mouseEnabled = true;
			
			this.removeElement(busyIndicator);
			stopwatch.stop();
			trace("Summary sorting/display complete: " + stopwatch.getTimeInMilliSeconds());
		}
		
		/**
		 * Gets the latest four entries from the source array and puts it into the recent array.
		 * Guarantees a recent array length of value indicated by the parameter <I>limit</I>
		 * 
		 * @param source full array of all VitalSigns of a given type
		 * @param recent a collection of the most recent VitalSigns
		 * @param limit the amount of VitalSigns to add to the recent list
		 */
		private function getLatestDataLimit( source:ArrayCollection, recent:ArrayCollection, limit:int ):void{
			if( source != null && source.length > 0){
				var max:int = source.length > limit ? limit : source.length;
				for( var i:int = source.length - 1; i >= source.length - max; i-- )
					recent.addItem( source.getItemAt( i ) as VitalSign );
				
				for( var remaining:int = max; remaining < limit; remaining++ )
					recent.addItem( new VitalSign() );
			}
		}
		
		/**
		 * For some lists that show in the same category, date matches are attempted to be found to display them
		 * in the same row. Each collection has a minimal guarantee of a size of <I>limit</I>
		 */ 
		public function synchronizeData( firstList:ArrayCollection, secondList:ArrayCollection, limit:int ):void{
			for( var index:int = 0; index < limit; index++ ){
				var vsFirstList:VitalSign = firstList.getItemAt( index ) as VitalSign;
				var firstListItemDate:Number = vsFirstList.intDate;
				
				var vsSecondList:VitalSign = secondList.getItemAt( index ) as VitalSign;
				var secondListItemDate:Number = vsSecondList.intDate;
				
				if( firstListItemDate == secondListItemDate )
					continue;
				else if( firstListItemDate < secondListItemDate )
					addBlankVitalSign( firstList, index, vsFirstList.type, vsSecondList.lastChgDtm );
				else
					addBlankVitalSign( secondList, index, vsSecondList.type, vsFirstList.lastChgDtm );
			}
			
			// remove all elements after limit in both lists
			clearExtras( firstList, limit );
			clearExtras( secondList, limit );
		}
		
		private function addBlankVitalSign( target:ArrayCollection, index:int, type:String, created:Date ):void{
			var vs:VitalSign = VitalSignFactory.createVitalSign( type );
			vs.lastChgDtm = created;
			target.addItemAt( vs, index );
		}
		
		private function clearExtras( target:ArrayCollection, limit:int ):void{
			while( target.length > limit )
				target.removeItemAt( limit );
		}
		
		protected function formatDate(date:Date):String
		{
			dateformatter.formatString = "MMM-DD JJ:NN:SS";
			return dateformatter.format(date);
		}
		
		public function onPopUpClose(event:PopUpEvent):void
		{
			if( event.commit )
				navigator.pushView(LoginView);
		}
		
		/**
		 * Generates a RegularChartDisplay and pushes to ChartView
		 */ 
		protected function btnMoreDataRegular_clickHandler( event:MouseEvent, type:String ):void{
			var chartDisplay:RegularChartDisplay = new RegularChartDisplay( patient, allVitalSigns[ type ], type );
			navigator.pushView( ChartView, chartDisplay );
		}
		
		/**
		 * Generates a HeartChartDisplay (for blood pressure and pulse) and pushes to ChartView
		 */
		protected function btnMoreDataHeart_clickHandler( event:MouseEvent ):void{
			var heartChartDisplay:HeartChartDisplay = new HeartChartDisplay( patient, allVitalSigns[ VitalSignType.SYSTOLIC ], allVitalSigns[ VitalSignType.HEARTRATE ] );
			navigator.pushView( ChartView, heartChartDisplay );
		}
		
		/**
		 * Generates a OxygenChartDisplay (for Oxygen and Saturation) and pushes to ChartView
		 */
		protected function btnMoreDataOxygen_clickHandler( event:MouseEvent ):void{
			var oxygenChartDisplay:OxygenChartDisplay = new OxygenChartDisplay( patient, allVitalSigns[ VitalSignType.OXYGEN ], allVitalSigns[ VitalSignType.O2SATURATION ] );
			navigator.pushView( ChartView, oxygenChartDisplay );
		}
		
		protected function btnDataEntry_clickHandler(event:MouseEvent):void
		{
			navigator.pushView(DataEntry, patient);
		}
		
		protected function resources_clickHandler(event:MouseEvent):void
		{
			navigator.pushView(ResourcesView);
		}
		
		
		public function faultHandler( message:String ):void{
			this.removeElement( busyIndicator );
			VitalSigns.showErrorMessage();
		}
		
		public function resultHandler( DO:Object ):void{
			if( DO != null ){
				allVitalSigns = new Dictionary();
				stopwatch.stop();
				trace( "Summary web service return: " + stopwatch.getTimeInMilliSeconds() );
				stopwatch.reset();
				stopwatch.start();
				
				var arrVitalSigns:ArrayCollection = DO as ArrayCollection;
				for each( var vsList:VitalSignList in arrVitalSigns )
				allVitalSigns[ vsList.type ] = vsList.list;
			}
			
			makeSummaryLabelData();
		}
	}
}
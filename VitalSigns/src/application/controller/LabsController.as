package application.controller
{
	import application.component.ListBox;
	import application.component.PopupLabs;
	import application.component.PopupLabsFilter;
	import application.controller.messaging.NotificationController;
	import application.view.ConversationView;
	import application.view.notes.NotesView;
	
	import domain.IObservable;
	import domain.command.Command;
	import domain.command.GetLabListCommand;
	import domain.lab.LabList;
	import domain.patient.Patient;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import flexunit.utils.Collection;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.BusyIndicator;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.components.View;
	import spark.events.PopUpEvent;
	import spark.formatters.DateTimeFormatter;
	import spark.primitives.Rect;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionDirection;

	public class LabsController extends NotificationController implements IObservable
	{
		
			private var currentPopup:PopupLabs = null;
			private var filterPopup:PopupLabsFilter = null;
			
			protected var referenceStr:String = "";
			protected var indicatorStr:String = "";
			protected var definitionStr:String = "";
			
			[Bindable]public var filterArray:ArrayCollection=new ArrayCollection();
			[Bindable]public var arrangeList:ArrayCollection = new ArrayCollection();
			protected var LabListArray : ArrayCollection = new ArrayCollection();
			
			[Bindable]public var filterBtnText:String;
			public var patientName:Label = new Label();
	
			[Bindable]protected var patient:Patient;//patient object
			
			private var currentBox:HBox = null;
			public var acrTxt:TextInput = new TextInput();
			public var mainRect:Rect = new Rect();
			public var busyIndicator:BusyIndicator =  new BusyIndicator();
			public var popUp:PopupLabs= new PopupLabs();
			public var popUpF:PopupLabsFilter= new PopupLabsFilter();
			
		public function LabsController(defaultBehaviour:Boolean = true )
		{
			super(defaultBehaviour);
		}
		
		//initializes the dataentrydata object and creates the grid
		protected function labscontroller_addHandler(event:FlexEvent):void
		{	
			this.stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, orientationChanged);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			filterBtnText="Filter Data";
			patient = data as Patient;
			patientName.text = patient.lastName + ", " + patient.firstName;
			currentState = "ContainsData";
			loadLabList();
			
			VitalSigns.registerSwipeListener(viewChange);
		}
		
		private function viewChange(slide:SlideViewTransition = null, direction:String = null):void{
			//If valid direction remove listener and move to that view
			if(direction!=null&&direction!="LEFT"){
				VitalSigns.removeSwipeListener();
				if(direction == "UP")
					navigator.pushView(ConversationView);
				else if (direction == "DOWN")
					navigator.popView(slide);
				else if (direction == "RIGHT")
					navigator.replaceView(NotesView, patient, null, slide);	
			}
		}			
		
		protected function loadLabList():void{
			var cmd:Command = new GetLabListCommand( this, patient );
			cmd.execute();
			this.cursorManager.setBusyCursor();
			this.addElement(busyIndicator);
		}

		public function faultHandler( message:String ):void{
			this.cursorManager.removeBusyCursor();
			VitalSigns.showErrorMessage();
		}
		
		public function resultHandler( DO:Object ):void{
			LabListArray = DO as ArrayCollection;
			if(LabListArray == null || LabListArray.length <= 0)
				currentState = "NoData";
			else{
				gridCreation(LabListArray);
				currentState = "ContainsData";
			}
			
			this.removeElement(busyIndicator);			
			this.cursorManager.removeBusyCursor();

		}
		
		protected function orientationChanged(portraitMode:Boolean):void
		{
			if (portraitMode)
				mainRect.percentHeight = 100;
			else
				mainRect.height = 450;
		}
	
		//pops back to patient list view
		protected function listViewButton_clickHandler(event:MouseEvent):void
		{
			navigator.popView();
		}
		
		//takes any arraycollection for parsing into grid and formats the date
		protected function gridCreation(thisArray:ArrayCollection):void{	
			arrangeList = arrangeItems(thisArray, 
				function(lab:LabList):String{ var dateFormatter:DateFormatter = new DateFormatter();
				dateFormatter.formatString = "MMM DD, YYYY";
				return dateFormatter.format(lab.resultDate); 
			});			
		}
		
		//parsing and separating of the arraycollection to the list to be used for the grid
		protected function arrangeItems(array:ArrayCollection, delimiter:Function): ArrayCollection
		{
			var bucket:Dictionary = new Dictionary();
			var keys:ArrayCollection = new ArrayCollection();
			var arrangeItem:ArrayCollection = new ArrayCollection();
			
			for(var i:int = 0; i < array.length; i++){
				var labData:LabList = array.getItemAt(i) as LabList;
				
				var separator:String = delimiter(labData);
				if(!bucket[separator]){
					bucket[separator] = new ArrayCollection();
					keys.addItem(separator);
				}
				(bucket[separator] as ArrayCollection).addItem(labData);
			}
			
			for(var index:int = 0; index < keys.length; index++){
				var key:String = keys.getItemAt(index) as String;
				arrangeItem.addItem({"separator":key, "currentList":bucket[key]});
				delete bucket[key];
			}
			return arrangeItem;
		}
		
		public function listClickHandler(event:MouseEvent):void{
			
			var target:ListBox = event.currentTarget as ListBox;
			var acrr:String = (target.getChildByName("lblAcronym")  as Label ).text;
			getLabDescr_clickHandler(acrr);
			
		}

		//formats the date for the grid
		public function getTime(lab:Object):String{
			var time:DateFormatter = new DateFormatter();
			time.formatString = "JJ:NN:SS";
			return time.format(lab.resultDate);
		}
		
		//formats result value for the grid
		public function getResult(lab:Object):String{
			var result:String = lab.result;
			var unit:String =  lab.resultUnit;
			
			if(lab.result == null || lab.resultUnit == null){
				return "N/A";
			}
		
			return result +" "+ unit; 
		}

		//handles the refresh of the labs view to show all data
		protected function getAllLabs_clickHandler(event:MouseEvent):void
		{
			filterArray.removeAll();
			filterBtnText="Filter Data";
			gridCreation(LabListArray);	
		}

		//brings up the popup for entering filter text
		protected function getFilteredLabs_clickHandler(event:MouseEvent):void
		{
			popUpF = new PopupLabsFilter;
			popUpF.availWidth = stage.width;
			popUpF.availHeight = stage.height;
			filterPopup = popUpF;
			popUpF.open(this, true);
			popUpF.addEventListener(PopUpEvent.CLOSE,onPopUpClose);	
		}
		
		
		//handles the request for a filtered set of data and rebuilds the grid with the data
		public function onPopUpClose(event:PopUpEvent):void
		{
			if( event.commit ){
				var acr:String = event.data as String;
				var found:int=filterArray_initializer(acr.toUpperCase());
				if(found!=0){
					filterBtnText="Add filter";
					gridCreation(filterArray);
				}
			}
		}
		
		//creates the filter array to be parsed for grid creation
		protected function filterArray_initializer(acr:String):int
		{
			var countA:int=0;
			for(var count:int = 0; count < LabListArray.length; count++)
			{
				var tmpObj:Object=LabListArray.getItemAt(count);
				if(acr==tmpObj.servTypeChildAcro){
					filterArray.addItem(tmpObj);
					countA++;
				}
			}
			return countA;
		}
		
		//handles clicking of a row to popup extra information on that acronym
		public function getLabDescr_clickHandler(acrr:String):void
		{
			popUp = new PopupLabs;
			popUp.availWidth = stage.width * 0.8;
			popUp.availHeight = stage.height * 0.8;
			getInfo(acrr);
			popUp.acronym = acrr;
			popUp.definition = definitionStr;
			popUp.reference = referenceStr;
			popUp.indicator = indicatorStr;
			currentPopup = popUp;
			popUp.open(this, true);
		}
		
		protected function getInfo( acrr:String ):void{
			for(var count:int = 0; count < LabListArray.length; count++)
			{
				var tmpObj:Object=LabListArray.getItemAt(count);
				if(acrr==tmpObj.servTypeChildAcro){
					definitionStr=tmpObj.servTypeChildLongDesc;
					if(tmpObj.rangeReference==null){
						referenceStr="N/A"
					}else{
						referenceStr=tmpObj.rangeReference;
					}
					if(tmpObj.rangeIndicator==null){	
						indicatorStr="N/A"
					}else{
						indicatorStr=tmpObj.rangeIndicator;
					}
					break;
				}
			}
		}
		
		public function onKeyPress(event:KeyboardEvent):void{
			if(event.keyCode == Keyboard.BACK && 
				(popUp.isOpen || popUpF.isOpen)){
				event.preventDefault();
				this.popUpF.close();
				this.popUp.close();
			}
		}
	}
}
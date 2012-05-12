package application.controller
{
	import application.component.ListBox;
	import application.component.PopupAction;
	import application.controller.messaging.NotificationController;
	import application.view.DataEntry;
	import application.view.ResourcesView;
	import application.view.notes.NotesView;
	
	import domain.IObservable;
	import domain.command.Command;
	import domain.command.GetPatientsCommand;
	import domain.patient.Patient;
	import domain.user.User;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import model.StopWatch;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.controls.List;
	import mx.events.FlexEvent;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	import spark.components.BusyIndicator;
	import spark.components.View;
	import spark.events.PopUpEvent;	
	
	public class PatientListController extends NotificationController implements IObservable
	{
		
		private var currentHBox:HBox = null;
		private var currentPopup:PopupAction = null;
		
		private var selectedPatient:Patient = null;
		
		public function PatientListController( defaultBehaviour:Boolean = true ){
			super( defaultBehaviour );
		}
		
		[Bindable]
		public var sortedList:ArrayCollection = new ArrayCollection();
		
		private var PatientArray:ArrayCollection = new ArrayCollection();
		private var sortedByName:Boolean = false;
		private var sortedByRoom:Boolean = false;
		
		public var busyIndicator:BusyIndicator = new BusyIndicator();
		public var stopwatch:StopWatch = new StopWatch();
		
		protected function patientListView_addHandler( event:FlexEvent ):void{
			loadPatients();
			stopwatch.start();
		}
		
		protected function sortbyname_clickHandler( event:MouseEvent ):void{
			sortByLastName();	
		}
		
		protected function sortbyroom_clickHandler( event:MouseEvent ):void{
			sortByRoom();
		}
		
		protected function resources_clickHandler( event:MouseEvent ):void{
			navigator.pushView( ResourcesView );
		}
		
		public function listClickHandler(event:MouseEvent):void
		{
			var target:ListBox = event.currentTarget as ListBox;
			var id:int = parseInt( target.label );
			selectedPatient = findById( id );
			
			navigator.pushView(DataEntry, selectedPatient);
			
			/*		---Old Pop-up Code---
			var popUp:PopupAction = new PopupAction;
			popUp.availWidth = stage.width * 0.8;
			popUp.availHeight = stage.height * 0.8;
			popUp.patientId = id;
			currentPopup = popUp;
			
			popUp.open(this, true);
			
			popUp.addEventListener(PopUpEvent.CLOSE,onPopUpClose);	
			*/
		}
		
		public function relocate( x:int, y:int ):void
		{
			currentPopup.availHeight = height * 0.8;
			currentPopup.move( ( width - currentPopup.width ) / 2, ( height - currentPopup.height ) / 2 );
		}
		
		//Remove?
		public function onPopUpClose(event:PopUpEvent):void
		{
			if( event.commit ){
				var nextView:Class = event.data as Class;
				navigator.pushView( nextView, selectedPatient );
			}
		}
		//----
		
		public function listMouseDownHandler(event:MouseEvent):void
		{
			var target:HBox = event.currentTarget as HBox;
			currentHBox = target;
			target.styleName = "listBoxSelecting";
		}
		
		public function listMouseUpHandler(event:MouseEvent):void
		{
			listMouseOutHandler( event );
			var selectedHBox:HBox = event.currentTarget as HBox;
		}
		
		public function listMouseOutHandler(event:MouseEvent):void
		{
			if( currentHBox ){
				currentHBox.styleName = "";
				currentHBox = null;
			}	
		}
		
		private function sortByRoom():void{
			
			if( !sortedByRoom ){
				var patients:ArrayCollection = new ArrayCollection();
				for( var i:int = 0; i < PatientArray.length; i++ )
					patients.addItem( PatientArray.getItemAt( i ) );
				
				doSort( new ArrayCollection( [ "room", "bed" ] ), patients );
				
				sortedByRoom = true;
				sortedByName = false;
				
				sortedList = arrangeItems( patients, function( p:Patient ):String{
					return p.room;
				} );
			}
		}
		
		private function sortByLastName():void{
			
			if( !sortedByName ){
				var patients:ArrayCollection = new ArrayCollection();
				for( var i:int = 0; i < PatientArray.length; i++ )
					patients.addItem( PatientArray.getItemAt( i ) );
				
				doSort( new ArrayCollection( [ "lastName" ] ), patients );
				
				sortedByName = true;
				sortedByRoom = false;
				sortedList = arrangeItems( patients, function( p:Patient ):String{
					return p.lastName.charAt( 0 );
				} );
			}
		}
		
		private function doSort( sortFields:ArrayCollection, array:ArrayCollection ):void{
			
			var sort:Sort = new Sort();
			array.sort = sort;
			var arrSortFields:Array = new Array();
			
			for( var i:int = 0; i < sortFields.length; i++ )
				arrSortFields.push( new SortField( sortFields.getItemAt( i ) as String ) );
			sort.fields = arrSortFields;
			array.refresh();
		}
		
		private function arrangeItems( sortedArray:ArrayCollection, delimiter:Function ):ArrayCollection{
			
			var buckets:Dictionary = new Dictionary();
			var keys:ArrayCollection = new ArrayCollection();
			
			for( var i:int = 0; i < sortedArray.length; i++ ){
				var patient:Patient = sortedArray.getItemAt( i ) as Patient;
				var separator:String = delimiter( patient );
				if( !buckets[ separator ] ){
					buckets[ separator ] = new ArrayCollection;
					keys.addItem( separator );
				}
				
				( buckets[ separator ] as ArrayCollection ).addItem( patient );
			}
			
			var sorted:ArrayCollection = new ArrayCollection();
			
			for( var index:int = 0; index < keys.length; index++ ){
				var key:String = keys.getItemAt( index ) as String;
				sorted.addItem( { "separator": key, "list": buckets[ key ] } );
				delete buckets[ key ];
			}
			
			return sorted;
		}
		
		public function getRoomInfo( patient:Object ):String{
			if( sortedByRoom )
				return patient.bed;
			else if( sortedByName )
				return patient.room + "-" + patient.bed;
			return "";
		}
		
		private function loadPatients():void{			
			var cmd:Command = new GetPatientsCommand( this, VitalSigns.currentUser );
			cmd.execute();
			this.cursorManager.setBusyCursor();
			this.addElement(busyIndicator);
		}
		
		public function faultHandler( message:String ):void{
			this.cursorManager.removeBusyCursor();
			VitalSigns.showErrorMessage();
		}
		
		public function resultHandler( DO:Object ):void{
			stopwatch.stop();
			trace("Patient list web service return: " + stopwatch.getTimeInMilliSeconds());
			stopwatch.reset();
			stopwatch.start();
			PatientArray = DO as ArrayCollection;
			sortByLastName();
			this.removeElement( busyIndicator );
			stopwatch.stop();
			trace("Patient list sorting complete: " + stopwatch.getTimeInMilliSeconds());
			this.cursorManager.removeBusyCursor();
		}
		
		private function findById( id:int ):Patient{
			for each( var p:Patient in PatientArray )
			if( p.patientId == id )
				return p;
			return null;
		}
		
		public function onLogoutClick(event:MouseEvent):void{
			navigator.popView();
		}
	}
}
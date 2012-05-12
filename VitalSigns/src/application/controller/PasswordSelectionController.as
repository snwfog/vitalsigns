package application.controller
{
	import application.view.PatientListView;
	
	import domain.IObservable;
	import domain.command.Command;
	import domain.command.GetImagesCommand;
	import domain.command.VerifyUserCommand;
	import domain.image.Image;
	import domain.user.User;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.List;
	import spark.components.VGroup;
	import spark.components.View;
	import spark.layouts.TileLayout;
	
	import testing.Timer;
	
	
	public class PasswordSelectionController extends View implements IObservable
	{
		
		protected var iWidth:int = VitalSigns.iImageWidth;
		
		public var lstImages:List = new List();
		public var layoutImages:TileLayout = new TileLayout();
		public var grpWrapper:VGroup = new VGroup();
		
		private var passFunctions:ImagePasswordFunctions = new ImagePasswordFunctions();
		
		private var user:User = null;
		
		private var resultFunction:Function;
		private var faultString:String;
		
		[Bindable]
		protected var arrImages:ArrayCollection = new ArrayCollection();
		private var arrSelectedIndices:ArrayCollection = new ArrayCollection();
		
		public function PasswordSelectionController()
		{
			super();
		}
		
		override public function createReturnObject():Object
		{
			return user;
		}
		
		protected function orientationChanged( x:int, y:int ):void
		{
			passFunctions.calculateOrientationVars( x, y, grpWrapper.paddingLeft, grpWrapper.paddingRight );
			layoutImages.requestedColumnCount = passFunctions.iColumns; // set # of columns in layout
			layoutImages.horizontalGap = ( passFunctions.iRemainingPixels / ( passFunctions.iColumns - 1 ) ); //distribute empty pixels evenly between columns (except for last - touches the right border)
		}
		
		protected function LoginPasswordView_addHandler(event:FlexEvent = null):void
		{			
			initializeList();
			VitalSigns.registerOrientationChangeListener( orientationChanged );
		}
		
		private function initializeList():void{
			user = data as User;
			var cmd:Command = new GetImagesCommand( this, user );
			resultFunction = getImagesHandler;
			cmd.execute();
			this.cursorManager.setBusyCursor();
		}
		
		protected function btnReset_clickHandler( event:MouseEvent ):void{
			resetImages();
		}
		
		private function resetImages():void{
			var arrSelectedImages:ArrayCollection = user.passwords;
			for( var i:int = arrSelectedIndices.length - 1; i >= 0; i-- ){
				arrImages.addItemAt( arrSelectedImages.getItemAt( i ), arrSelectedIndices.getItemAt( i ) as int );
			}
			arrSelectedImages.removeAll();
			arrSelectedIndices.removeAll();
		}
		
		private function getImagesHandler( images:ArrayCollection ):void{
			arrImages = images;
			
			resultFunction = verifyUserHandler;
		}
		
		private function verifyUserHandler( result:Object ):void{
			Timer.benchmark("Password Entered");
			navigator.popView();
			if( result != null ){
				VitalSigns.currentUser = user;
				VitalSigns.doViewPush( PatientListView, user );
			}
		}
		
		public function resultHandler( DO:Object ):void{
			this.cursorManager.removeBusyCursor();
			resultFunction( DO );
		}
		
		public function faultHandler( message:String ):void{
			this.cursorManager.removeBusyCursor();
			VitalSigns.showErrorMessage();
			resetImages();
		}
		
		
		
		protected function lstImages_clickHandler(event:MouseEvent):void
		{
			// lstImages.selectedIndex == -1 when user clicks within the list, but not on an image
			if( lstImages.selectedIndex != -1 ){
				arrSelectedIndices.addItem( lstImages.selectedIndex );
				var selected:Image = arrImages.removeItemAt( lstImages.selectedIndex ) as Image;
				user.addPassword( selected );
				if ( user.passwords.length == VitalSigns.iPasswordLength ){
					var cmd:Command = new VerifyUserCommand( this, user );
					cmd.execute();					
				}
			}
		}
	}
}
package application.controller.AccountRegistration
{	
	import application.component.AlertWindow;
	import application.controller.ImagePasswordFunctions;
	
	import domain.IObservable;
	import domain.command.GetImageCategoriesCommand;
	import domain.command.GetImagesByCategoryCommand;
	import domain.image.Image;
	import domain.user.User;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Form;
	import mx.core.Repeater;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.WebService;
	
	import spark.components.List;
	import spark.components.Scroller;
	import spark.components.VGroup;
	import spark.components.View;
	import spark.layouts.TileLayout;
	
	import valueObjects.ImageDTO;
	import valueObjects.UserDTO;

	public class ImageCategoriesController extends View implements IObservable
	{
		
		[Bindable]public var lstCategories:ArrayCollection = new ArrayCollection();
		[Bindable]public var iColumnCount:int = 4;
		[Bindable]public var iGap:int = 5;
		
		public var accordion:ImageCategoriesAccordionController = new ImageCategoriesAccordionController();
		//public var getImagesService:WebService = new WebService();
		//public var getImageCategories:WebService = new WebService();
		public var rptCategories:Repeater = new Repeater;
		public var scroller:Scroller = new Scroller;
		
		//public var userDto:UserDTO;
		private var user:User;
		
		private var resultFunction:Function;
		
		private var passFunctions:ImagePasswordFunctions = new ImagePasswordFunctions();
		
		public function ImageCategoriesController()
		{
			super();
		}
		
		override public function createReturnObject():Object{
			return user;
		}
		
		protected function ImageCategoriesView_addHandler(event:FlexEvent):void
		{	
			if( data )
				user = data as User;
		
			var cmd:GetImageCategoriesCommand = new GetImageCategoriesCommand( this );
			resultFunction = getImageCategoriesHandler;
			cmd.execute();
			
			VitalSigns.registerOrientationChangeListener( orientationChangeHandler );
		}
		
		public function orientationChangeHandler( x:int, y:int ):void{			
			passFunctions.calculateOrientationVars( x, y, 10, 10 );
			for( var index:int = 0; index < lstCategories.length; index++ ){
				var item:Object = lstCategories.getItemAt( index );
				var frm:Form = accordion.getChildByName( item.categoryName ) as Form;
				var lst:List = frm.getChildByName( "lstImages" ) as List;
				var tileLayout:TileLayout = new TileLayout();
				tileLayout.requestedColumnCount = passFunctions.iColumns;
				tileLayout.horizontalGap = ( passFunctions.iRemainingPixels / ( passFunctions.iColumns - 1 ) );
				lst.layout = tileLayout;
			}
		}
		
		protected function accordion_changeHandler(event:IndexChangedEvent):void{
			accordion.changed( event );
			loadImages();
		}
		
		protected function loadImages():void{
			var index:int = accordion.currentIndex;
			if( lstCategories.getItemAt( index ).list.length == 0 ){
				var cmd:GetImagesByCategoryCommand = new GetImagesByCategoryCommand( this, lstCategories.getItemAt( index ).categoryName );
				this.cursorManager.setBusyCursor();
				resultFunction = getImagesHandler;
				cmd.execute();
				setupListListener( lstCategories.getItemAt( index ) ); 
			}
		}
		
		
		public function resultHandler( DO:Object ):void{
			this.cursorManager.removeBusyCursor();
			resultFunction( DO );
		}
		
		public function faultHandler( message:String ):void{
			this.cursorManager.removeBusyCursor();
			VitalSigns.showErrorMessage();
		}
		
		protected function getImagesHandler( DO:Object ):void
		{
			var index:int = accordion.currentIndex;
			var theArray:ArrayCollection = lstCategories.getItemAt( index ).list as ArrayCollection;
			var tmpArray:ArrayCollection = DO as ArrayCollection;
			
			for each( var image:Image in tmpArray )
				theArray.addItem( image );
		}
		
		protected function getImageCategoriesHandler( DO:Object ):void
		{
			var tmpArray:ArrayCollection = DO as ArrayCollection;
			
			for each( var cat:String in tmpArray )
				lstCategories.addItem( { "categoryName": cat, "list": new ArrayCollection() } );
			
			accordion.setIcons( 0 );
			loadImages();
			orientationChangeHandler( parentApplication.stage.width, parentApplication.stage.height );
		}
		
		protected function setupListListener( category:Object ):void{
			var frm:Form = accordion.getChildByName( category.categoryName ) as Form;
			var lst:List = frm.getChildByName( "lstImages" ) as List;
			lst.addEventListener( MouseEvent.CLICK, function( event:MouseEvent ):void{
				if( lst.selectedIndex != -1 ){
					var selected:Image = lst.selectedItem as Image;
					user.addPassword( selected );
					category.list.removeItemAt( lst.selectedIndex );
					if( user.passwords.length == VitalSigns.iPasswordLength )
						navigator.popView();
				}
			} );
		}
	}
}
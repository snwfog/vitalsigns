package application.controller
{
	import application.TestResults;
	import application.component.Confirm;
	import application.component.DropDownEntry;
	import application.component.VSButtonBar;
	import application.view.AccountRegistration.AccountRegistrationView;
	import application.view.ConversationView;
	import application.view.PasswordSelectionView;
	
	import domain.IObservable;
	import domain.command.Command;
	import domain.command.GetUserCommand;
	import domain.model.IDomainObject;
	import domain.user.User;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.View;
	import spark.transitions.ViewTransitionDirection;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	import testing.ITimer;
	import testing.Timer;
	



	
	public class LoginController extends View implements IObservable
	{	
		private const strErrorMessage:String = "Invalid username or password!";
		
		public var btnSite:VSButtonBar = new VSButtonBar();
		public var userName:TextInput = new TextInput();
		public var btnConfirm:Button = new Button();
		public var ddlUnit:DropDownEntry = new DropDownEntry();
		
		public var slideDown:SlideViewTransition = new SlideViewTransition();
		public var slideUp:SlideViewTransition = new SlideViewTransition();
		
		[Bindable]
		public var defaultUnit:String = "";
		
		[Bindable]
		public var arrSites:ArrayCollection = new ArrayCollection( [ "RVH", "MGH" ] );
		
		private var arrUnits:ArrayCollection = null;
		
		public function LoginController(){
			super();
		}
		
		
		protected function LoginController_addHandler( event:FlexEvent ):void
		{
			arrUnits = new ArrayCollection( getUnits( btnSite.selectedItem as String ) );
			defaultUnit = arrUnits.getItemAt( 0 ).toString();
			if( navigator.poppedViewReturnedObject && navigator.poppedViewReturnedObject.object )
				initializeUI();
			this.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		protected function initializeUI():void{
			var user:User = navigator.poppedViewReturnedObject.object as User;
			ddlUnit.value = user.unit;
			btnSite.selectedItem = user.site;
			
			if( user.passwords.length > 0 )
				userName.text = strErrorMessage;
		}
		
		protected function userNameChange(event:FocusEvent):void
		{
			var tmpName:String = userName.text.replace( /\s/g, "" );
			if( tmpName.length > 0 ){
				this.btnConfirm.enabled = true;
				if( tmpName != null && tmpName.length != 0 )
					this.userName.text = tmpName;
			}
		}
		
		protected function userName_focusInHandler(event:FocusEvent):void
		{
			if( userName.text == strErrorMessage )
				userName.text = "";
		}
		
		protected function ddlUnit_clickHandler(event:MouseEvent):void
		{		
			ddlUnit.open( arrUnits );
		}
		
		protected function btnLogin_clickHandler( event:MouseEvent ):void{
			this.cursorManager.setBusyCursor();
			var cmd:Command = new GetUserCommand( this, userName.text );
			cmd.execute();
		}
		
		
		public function resultHandler( DO:Object ):void{
			this.cursorManager.removeBusyCursor();
			if( DO ){
				var user:User = DO as User;
				user.site = btnSite.selectedItem as String;
				user.unit = ddlUnit.value;		
				//============================================================	
				//Default Transitions
				slideDown.direction = ViewTransitionDirection.DOWN;
				slideDown.mode = SlideViewTransitionMode.PUSH;
				slideDown.duration = 500;
				
				slideUp.direction = ViewTransitionDirection.UP;
				slideUp.mode = SlideViewTransitionMode.PUSH;
				slideUp.duration = 500;
				
				navigator.defaultPushTransition = slideUp;
				navigator.defaultPopTransition = slideDown;
				//============================================================
				if( user.nullPassword )
					navigator.pushView( AccountRegistrationView, user);
				else
					navigator.pushView( PasswordSelectionView, user);	
			} else
				userName.text = strErrorMessage;
		}
		
		public function faultHandler( message:String ):void{
			this.cursorManager.removeBusyCursor();
			VitalSigns.showErrorMessage( "Unable to log in" );
		}
		
		private function getUnits( site:String ):Array{
			var array:Array = new Array();
			array.push( "10E" );
			array.push( "11E" );
			array.push( "R03" );
			
			return array;
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
			{
				event.preventDefault();
				var confirm:Confirm = new Confirm();
				confirm.commitFunction = function():void{
					VitalSigns.exitApplication();
				}
				confirm.open( this, true );
			}
		}
	}
}
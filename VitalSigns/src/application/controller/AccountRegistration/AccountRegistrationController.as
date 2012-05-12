package application.controller.AccountRegistration
{
	import application.component.AlertWindow;
	import application.view.AccountRegistration.ImageCategoriesView;
	import application.view.PatientListView;
	
	import domain.IObservable;
	import domain.command.RegisterUserCommand;
	import domain.user.User;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.WebService;
	
	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.VGroup;
	import spark.components.View;
	
	import testing.Timer;
	
	import valueObjects.UserDTO;
	
	public class AccountRegistrationController extends View implements IObservable
	{
		
		[Bindable]public var images:ArrayCollection = new ArrayCollection();
		
		//public var user:UserDTO;
		public var user:User;
		
		public var grpStartActivation:VGroup = new VGroup();
		public var grpConfirmActivation:VGroup = new VGroup();
		public var grpResetActivation:VGroup = new VGroup();
		//public var registerService:WebService = new WebService();
		public var btnActivate:Button = new Button();
		
		public var userName:TextInput = new TextInput();		
		public function AccountRegistrationController()
		{
		}
		
		protected function AccountRegistrationView_addHandler(event:FlexEvent):void
		{
			if( navigator.poppedViewReturnedObject && navigator.poppedViewReturnedObject.object ){
				updateUI();
			}
			
			userName.text = ( data as User ).username;
		}
		
		protected function btnPasswordSelect_clickHandler(event:MouseEvent):void
		{
			navigator.pushView( ImageCategoriesView, data );
		}
		
		protected function updateUI():void{
			user = data as User;
			var passwords:ArrayCollection = user.passwords;
			
			if( passwords.length == VitalSigns.iPasswordLength ){
				images = passwords;
				grpStartActivation.visible = false;
				grpConfirmActivation.visible = true;
				grpResetActivation.visible = true;
				btnActivate.enabled = true;
			} else
				passwords.removeAll();
		}
		
		protected function btnReset_clickHandler( event:MouseEvent ):void
		{
			user.passwords.removeAll();
			images.removeAll();
			
			grpStartActivation.visible = true;
			grpConfirmActivation.visible = false;
			grpResetActivation.visible = false;
		}
		
		protected function btnActivate_clickHandler( event:MouseEvent ):void
		{
			Timer.benchmark("Account Activated");
			this.cursorManager.setBusyCursor();
			btnActivate.enabled = false;
			var cmd:RegisterUserCommand = new RegisterUserCommand( this, user );
			cmd.execute();
		}
		
		public function faultHandler( message:String ):void{
			this.cursorManager.removeBusyCursor();
			VitalSigns.showErrorMessage();
		}
		
		public function resultHandler( DO:Object ):void{
			this.cursorManager.removeBusyCursor();
			if( DO ){
				navigator.popView();
				navigator.pushView( PatientListView, user );
			}else
				VitalSigns.showMessage( "Registration failed. Please try again later." );
		}
		
		
	}
}
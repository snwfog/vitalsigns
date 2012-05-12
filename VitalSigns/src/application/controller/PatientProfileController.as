package application.controller
{
	import application.controller.messaging.NotificationController;
	import application.view.LabsView;
	import application.view.PatientSummaryView;
	import application.view.ConversationView;
	
	import domain.IObservable;
	import domain.patient.Patient;
	
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.View;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionDirection;
	
	public class PatientProfileController extends NotificationController
	{
		
		private const arrMonths:Array = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
		
		[Bindable]protected var patient:Patient;
		
		[Bindable]
		protected var age_Month : Number;
		[Bindable]
		protected var age_Year : Number;
		
		[Bindable]
		protected var bmi:String;
		[Bindable]
		protected var bsa:String;
		
		[Bindable]
		protected var strBirthday:String;
		
		[Bindable]
		protected var patientName:String;
		
		public function PatientProfileController(defaultBehaviour:Boolean = true )
		{
			super(defaultBehaviour);
		}
		
		protected function listBtn_clickHandler(event:MouseEvent):void
		{
			navigator.popView();
		}
		
		protected function patientProfile_addHandler(event:FlexEvent):void
		{
			VitalSigns.registerSwipeListener(viewChange);
			patient = data as Patient;
			creatingProfile(patient);
		}
		
		private function viewChange(slide:SlideViewTransition = null, direction:String = null):void{
			//If valid direction remove listener and move to that view
			if(direction!=null&&direction!="RIGHT"){
				VitalSigns.removeSwipeListener();
				if(direction == "UP")
					navigator.pushView(ConversationView);
				else if (direction == "DOWN")
					navigator.popView(slide);
				else if (direction == "LEFT")
					navigator.replaceView(PatientSummaryView, patient, null, slide);	
			}
		}	
		
		protected function creatingProfile(patient:Patient):void{
			
			patientName = patient.lastName + ", " + patient.firstName;
			var date : Date = new Date();
			age_Month = ((date.month)- patient.birthDate.month);
			if(age_Month==11)
				age_Year+=1;
			age_Year = (date.fullYear - patient.birthDate.fullYear);
			
			strBirthday = patient.birthDate.date + " " + arrMonths[ patient.birthDate.month ] + " " + patient.birthDate.fullYear;
			
			if ( patient.height && patient.weight ){
				var calculatedHeight:Number = patient.height;
				if( patient.heightUnit == "cm" )
					calculatedHeight = calculatedHeight / 100.0;
				
				bmi = Number( patient.weight / Math.pow( calculatedHeight, 2 ) ).toFixed(2);
				bsa = Number(0.007184 * Math.pow(patient.height,0.725) * Math.pow(patient.weight,0.425)).toFixed(2);
			}else{
				bmi = "";
				bsa = "";	
			}
		}
	}
}
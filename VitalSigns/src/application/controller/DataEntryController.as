package application.controller
{
	import application.component.BloodPopUp;
	import application.component.DataEntryControl;
	import application.component.HeartPopup;
	import application.component.HeightPopup;
	import application.component.O2SatPopup;
	import application.component.OxygenPopup;
	import application.component.PopupAction;
	import application.component.PopupBraden;
	import application.component.PopupNoData;
	import application.component.RespPopup;
	import application.component.TempPopup;
	import application.component.WeightPopup;
	import application.controller.messaging.NotificationController;
	import application.events.KeypadReturnEvent;
	import application.view.DataConfirmation;
	import application.view.DataEntry;
	import application.view.PatientSummaryView;
	import application.view.notes.NotesView;
	import application.view.ConversationView;
	import application.view.ResourcesView;
	import application.view.Template;
	
	import domain.patient.Patient;
	import domain.user.User;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.utils.Timer;
	
	import model.BradenScaleEntryModel;
	import model.Data;
	import model.DataEntryData;
	import model.DataTypeEnum;
	import model.HeightWeightEntryModel;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.TabNavigator;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.effects.MaskEffect;
	import mx.effects.WipeLeft;
	import mx.effects.WipeRight;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.StateChangeEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.mxml.WebService;
	
	import spark.components.ButtonBar;
	import spark.components.Group;
	import spark.components.HSlider;
	import spark.components.Label;
	import spark.components.Scroller;
	import spark.components.View;
	import spark.effects.WipeDirection;
	import spark.events.IndexChangeEvent;
	import spark.events.PopUpEvent;
	import spark.primitives.Rect;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionDirection;

	
	import testing.Timer;
	
	import valueObjects.BradenScaleDTO;
	import valueObjects.VitalSignDTO;
	
	public class DataEntryController extends NotificationController
	{	
		private var currentPopup:PopupAction = null;

		private static var _BradenState:Boolean=false;//if all braden scale fields are set
		private static var _BradenSensory:String=null;//sensory number as string
		private static var _BradenMobility:String=null;//mobility number as string
		private static var _BradenMoisture:String=null;//moisture number as string
		private static var _BradenActivity:String=null;//activity number as string
		private static var _BradenNutrition:String=null;//nutrition number as string
		private static var _BradenFriction:String=null;//friction number as string
		private static var bradenScaleModel : BradenScaleEntryModel = new BradenScaleEntryModel();//model to pack braden data
		private static var _BradenTotal:int=0;//total of all braden numbers
		
		protected var patient : Patient;//patient object
		private var loginUser:User;//nurse
		private static var dataEntryData : DataEntryData  = new DataEntryData();//data object to pack data to db
		
		private var vitalSigns:ArrayCollection = new ArrayCollection();//necessary for db submission
		public var vitalSignService:WebService = new WebService();//necessar
		public var alertWindow:Alert=new Alert();
		
		public var tabs:TabNavigator = new TabNavigator();
		public var wipe_left:WipeLeft = new WipeLeft();
		public var wipe_right:WipeRight = new WipeRight();
		[Bindable]public var wipe:MaskEffect = wipe_right;
		
		[Bindable]public var tab_width:int = 160;
		
		[Bindable]public var arrEntries:ArrayCollection = new ArrayCollection( [ "Temperature", "Heart Rate", "Blood Pressure", "Respiration", "Oxygen", "O2 Saturation", "Height","Weight" ] );
		
		public var popTemp:TempPopup=new TempPopup();
		public var popHeart:HeartPopup=new HeartPopup();
		public var popBloodP:BloodPopUp=new BloodPopUp();
		public var popOxy:OxygenPopup=new OxygenPopup();
		public var popO2Sat:O2SatPopup=new O2SatPopup();
		public var popResp:RespPopup=new RespPopup();
		public var popH:HeightPopup=new HeightPopup();
		public var popW:WeightPopup=new WeightPopup();

		public var mainRect:Rect = new Rect();
		[Bindable]public var painSlider:HSlider = new HSlider();
		
		public var sensoryLbl:Label = new Label();
		public var mobilityLbl:Label = new Label();
		public var moistureLbl:Label = new Label();
		public var activityLbl:Label = new Label();
		public var nutritionLbl:Label = new Label();
		public var frictionLbl:Label = new Label();
		
		public var sensoryBB:ButtonBar = new ButtonBar();
		public var mobilityBB:ButtonBar = new ButtonBar();
		public var moistureBB:ButtonBar = new ButtonBar();
		public var activityBB:ButtonBar = new ButtonBar();
		public var nutritionBB:ButtonBar = new ButtonBar();
		public var frictionBB:ButtonBar = new ButtonBar();
		
		private var sensMobArray:Array = new Array("Completely Limited", "Very Limited", "Slightly Limited", "No Impairment");
		private var moistureArray:Array = new Array("Constantly Moist", "Very Moist", "Occasionally Moist", "Rarely Moist");
		private var activityArray:Array = new Array("Bedfast", "Chairfast", "Walks Occasionally", "Walks Frequently");
		private var nutritionArray:Array = new Array("Very Poor", "Probably Inadequate", "Adequate", "Excellent");
		private var frictionArray:Array = new Array("Problem", "Potential Problem", "No Apparent Problem");
		
		public var sliding:Boolean = false;
		
		private static var pPoint:int;
		private static var sensText:String;
		private static var mobilText:String;
		private static var moistText:String;
		private static var activText:String;
		private static var nutriText:String;
		private static var frictText:String;
		
		private var bradenPopup:PopupBraden = null;
		private var noDataPopup:PopupNoData = null;
		
		[Bindable]public static var control:DataEntryControl=new DataEntryControl();
		//[Bindable]public var controlTemp:DataEntryControl=new DataEntryControl();
		
		public function DataEntryController(){ super(); }
		
		public function listClickHandler(event:MouseEvent):void
		{		
			control = event.currentTarget as DataEntryControl;
			if(control.title=="Temperature"){
				
				var keypadTemp : TempPopup = new TempPopup();
				keypadTemp.currentVitalSign = DataTypeEnum.TEMPERATURE;
				keypadTemp.allowInput = ".";
				keypadTemp.maxLength = 4;
				keypadTemp.rangeLowerLimit = "20";
				keypadTemp.rangeUpperLimit = "45";
				keypadTemp.open(this,true);
				popTemp = keypadTemp;
				PopUpManager.centerPopUp(keypadTemp);
				
				keypadTemp.addEventListener("returnKey",onTempReturnKeyPress);	
			}
			else if(control.title=="Heart Rate"){
				
				var keypadHeart : HeartPopup = new HeartPopup();
				keypadHeart.currentVitalSign = DataTypeEnum.HEARTRATE;
				keypadHeart.allowInput = "";
				keypadHeart.maxLength = 3;
				keypadHeart.rangeLowerLimit = "0";
				keypadHeart.rangeUpperLimit = "250";
				keypadHeart.open(this,true);
				popHeart = keypadHeart;
				PopUpManager.centerPopUp(keypadHeart);
				
				keypadHeart.addEventListener("returnKey",onHeartReturnKeyPress);
			}
			else if(control.title=="Blood Pressure"){
				
				var keypadBlood : BloodPopUp = new BloodPopUp();
				keypadBlood.currentVitalSign = DataTypeEnum.BLOODPRESSURE;
				keypadBlood.allowInput = "/";
				keypadBlood.maxLength = 7;
				keypadBlood.rangeLowerLimit = "0";
				keypadBlood.rangeUpperLimit = "300";
				keypadBlood.open(this,true);
				popBloodP = keypadBlood;
				PopUpManager.centerPopUp(keypadBlood);
				
				keypadBlood.addEventListener("returnKey",onBpReturnKeyPress);
			}
			else if(control.title=="Respiration"){
				
				var keypadResp : RespPopup = new RespPopup();
				keypadResp.currentVitalSign = DataTypeEnum.RESPIRATION;
				keypadResp.allowInput = "";
				keypadResp.maxLength = 3;
				keypadResp.rangeLowerLimit = "0";
				keypadResp.rangeUpperLimit = "120";
				keypadResp.open(this,true);
				popResp = keypadResp;
				PopUpManager.centerPopUp(keypadResp);
				
				keypadResp.addEventListener("returnKey",onRespirationReturnKeyPress);
			
			}
			else if(control.title=="Oxygen"){
				
				var keypadOD : OxygenPopup = new OxygenPopup();
				keypadOD.currentVitalSign = DataTypeEnum.OXYGEN;
				keypadOD.allowInput = ".";
				keypadOD.maxLength = 5;		
				//for %
				keypadOD.rangeLowerLimit = "21";
				keypadOD.rangeUpperLimit = "100";
				DataConfirmationController.setIntakeUnit("%");
				setIntakeUnit("%");
				keypadOD.open(this,true);
				popOxy = keypadOD;
				PopUpManager.centerPopUp(keypadOD);
				
				keypadOD.addEventListener("returnKey",onOxygenReturnKeyPress);
				
			}
			else if(control.title=="O2 Saturation"){
				
				var keypadSat : O2SatPopup = new O2SatPopup();
				keypadSat.currentVitalSign = DataTypeEnum.O2SATURATION;
				keypadSat.allowInput = "";
				keypadSat.maxLength = 3;
				keypadSat.rangeLowerLimit = "0";
				keypadSat.rangeUpperLimit = "100";
				keypadSat.open(this,true);
				popO2Sat = keypadSat;
				PopUpManager.centerPopUp(keypadSat);
				
				keypadSat.addEventListener("returnKey",onO2SaturationReturnKeyPress);
				
			}
			else if(control.title=="Height"){
				
				var keypadHt : HeightPopup = new HeightPopup();
				keypadHt.currentVitalSign = DataTypeEnum.HEIGHT;
				keypadHt.allowInput = ".";
				keypadHt.maxLength = 5;
				keypadHt.rangeLowerLimit = "0";
				keypadHt.rangeUpperLimit = "243";
				keypadHt.open(this,true);
				popH = keypadHt;
				PopUpManager.centerPopUp(keypadHt);
				
				keypadHt.addEventListener("returnKey",onHeightReturnKeyPress);
			}
			else if(control.title=="Weight"){
				
				var keypadWt : WeightPopup = new WeightPopup();
				keypadWt.currentVitalSign = DataTypeEnum.WEIGHT;
				keypadWt.allowInput = ".";
				keypadWt.maxLength = 5;
				keypadWt.rangeLowerLimit = "0";
				keypadWt.rangeUpperLimit = "909";
				keypadWt.open(this,true);
				popW = keypadWt;
				PopUpManager.centerPopUp(keypadWt);
				
				keypadWt.addEventListener("returnKey",onWeightReturnKeyPress);
			} 
		}
		
		public static function clearControl():void
		{
			control.entry = "No value entered";
		}
		
		protected function onTempReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue!="")
			{
				popTemp = null;
				var tempVal:String = event.totalvalue.toString();
				DataConfirmationController.setTemperatureValue(tempVal);
				setTemperatureValue(tempVal);
				
				if(DataConfirmationController.TemperatureSite=="No value entered"&&DataConfirmationController.TemperatureValue!="No value entered")
				{
					DataConfirmationController.setTemperatureSite("Oral");
					setTemperatureSite("Oral");
				}
				if(DataConfirmationController.TemperatureValue!="No value entered")
				{control.entry = DataConfirmationController.TemperatureValue + " °Celcius";}
				else{control.entry = DataConfirmationController.TemperatureValue;}
			}
		}
		
		protected function onHeartReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue!="")
			{
				popHeart = null;
				var heartVal:String = event.totalvalue.toString();
				DataConfirmationController.setHeartRateValue(heartVal);
				setHeartRateValue(heartVal);
				
				if(DataConfirmationController.HeartRateSite=="No value entered"&&DataConfirmationController.HeartRateValue!="No value entered")
				{
					DataConfirmationController.setHeartRateSite("Apical");
					setHeartRateSite("Apical");
				}
				if(DataConfirmationController.HeartRateValue!="No value entered")
				{control.entry = DataConfirmationController.HeartRateValue + " /min";}
				else{control.entry = DataConfirmationController.HeartRateValue;}
			}
		}
		
		protected function onBpReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue!="")
			{
				popBloodP = null;
				var bpVal:String = event.totalvalue.toString();
				DataConfirmationController.setBloodPressureValue(bpVal);
				setBloodPressureValue(bpVal);
				
				if(DataConfirmationController.BloodPressureSite=="No value entered"&&DataConfirmationController.BloodPressureValue!="No value entered")
				{
					DataConfirmationController.setBloodPressureSite("Left Arm");
					setBloodPressureSite("Left Arm");
				}
				
				if(DataConfirmationController.BloodPressurePosition=="No value entered"&&DataConfirmationController.BloodPressureValue!="No value entered")
				{
					DataConfirmationController.setBloodPressurePosition("Supine");
					setBloodPressurePosition("Supine");
				}		
				
				if(DataConfirmationController.BloodPressureCuff=="No value entered"&&DataConfirmationController.BloodPressureValue!="No value entered")
				{
					DataConfirmationController.setBloodPressureCuff("Automatic Cuff");
					setBloodPressureCuff("Automatic Cuff");
				}
				if(DataConfirmationController.BloodPressureValue!="No value entered")
				{control.entry = DataConfirmationController.BloodPressureValue + " mmHg";
				}else{control.entry = DataConfirmationController.BloodPressureValue;}				
			}
		}
	
		
		protected function onRespirationReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue!="")
			{
				popResp = null;
				var respVal:String = event.totalvalue.toString();
				DataConfirmationController.setRespirationRate(respVal);
				setRespirationRate(respVal);
			}
			if(DataConfirmationController.RespirationRate!="No value entered")
			{control.entry = DataConfirmationController.RespirationRate + " /min";}
			else{control.entry = DataConfirmationController.RespirationRate;}
		}
		
		protected function onOxygenReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue!="")
			{
				popOxy = null;
				var o2Val:String = event.totalvalue.toString();
				DataConfirmationController.setOxygenValue(o2Val);
				setOxygenValue(o2Val);
				if(DataConfirmationController.OxygenDevice=="No value entered"&&DataConfirmationController.OxygenValue!="No value entered")
				{
					DataConfirmationController.setOxygenDevice("Room Air");
					setOxygenDevice("Room Air");
				}
				if(DataConfirmationController.OxygenValue!="No value entered"){
				control.entry = DataConfirmationController.OxygenValue+" "+DataConfirmationController.IntakeUnit;
				}else{control.entry = DataConfirmationController.OxygenValue;}
			}
		}
		
		protected function onO2SaturationReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue != "")
			{
				popO2Sat = null;
				var o2satVal:String = event.totalvalue.toString();
				DataConfirmationController.setOxygenSaturationValue(o2satVal);
				setOxygenSaturationValue(o2satVal);
				if(DataConfirmationController.OxygenSaturationSite=="No value entered"&&DataConfirmationController.OxygenSaturationValue!="No value entered")
				{
					DataConfirmationController.setOxygenSaturationSite("Earlobe");
					setOxygenSaturationSite("Earlobe");
				}
				control.entry = DataConfirmationController.OxygenSaturationValue;
			}
			
		}
		
		protected function onHeightReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue!="")
			{
				popH = null;
				var heightVal:String = event.totalvalue.toString();
				DataConfirmationController.setHeightCms(heightVal);
				setHeightCms(heightVal);
				if(DataConfirmationController.HeightMeasurementMethod=="No value entered"&&DataConfirmationController.HeightCms!="No value entered")
				{
					DataConfirmationController.setHeightMeasurementMethod("Estimated");
					setHeightMeasurementMethod("Estimated");
				}
				if(DataConfirmationController.HeightCms!="No value entered"){
				control.entry = DataConfirmationController.HeightCms+" Cms";}
				else{control.entry = DataConfirmationController.HeightCms;}
			}
		}
		
		protected function onWeightReturnKeyPress(event:KeypadReturnEvent):void
		{
			if(event.totalvalue!="")
			{
				popW = null;		
				var weightVal:String = event.totalvalue.toString();
				DataConfirmationController.setWeightKgs(weightVal);
				setWeightKgs(weightVal);
				if(DataConfirmationController.WeightMeasurementMethod=="No value entered"&&DataConfirmationController.WeightKgs!="No value entered")
				{
					DataConfirmationController.setWeightMeasurementMethod("Standing Scale - Mechanical");
					setWeightMeasurementMethod("Standing Scale - Mechanical");
				}
				if(DataConfirmationController.HeightCms!="No value entered"){
				control.entry = DataConfirmationController.WeightKgs+" Kgs";}
				else{control.entry = DataConfirmationController.WeightKgs;}
			}			
		}
		
		protected function dataentrycontroller_addHandler(event:FlexEvent):void
		{
			VitalSigns.registerSwipeListener(viewChange);
			mainTab.selectedIndex = 2;
			
			dataEntryData = new DataEntryData(); //initialize data
			loginUser = VitalSigns.currentUser; //initialize nurse
			dataEntryData.loginUser = loginUser;
			patient = data as Patient; //initialise patient
			dataEntryData.patient = patient;
			vitalSignService.wsdl = VitalSigns.endPoint;
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
				navigator.replaceView(NotesView, patient, null, slide);
			else if (direction == "RIGHT")
				navigator.replaceView(PatientSummaryView, patient, null, slide);		
			}
		}		
		
		
		protected function submitBtn_clickHandler(event:MouseEvent):void
		{
			testing.Timer.benchmark("Submit clicked");
			
			if((dataEntryData.temperatureData.value==null)&&(dataEntryData.heartBpData.heartValue==null)&&(dataEntryData.heartBpData.bpValue==null)&&
				(dataEntryData.o2RespirationData.respirationValue==null)&&(dataEntryData.o2RespirationData.o2Value==null)&&				
				(dataEntryData.o2RespirationData.o2SaturationValue==null)&&(dataEntryData.painScaleData.painScaleData==null)&&
				(dataEntryData.weightData.heightValue==null)&&(dataEntryData.weightData.weightValue==null)&&
				(_BradenState==false)&&(_BradenSensory==null)&&(_BradenMobility==null)&&(_BradenMoisture==null)&&
				(_BradenActivity==null)&&(_BradenNutrition==null)&&(_BradenFriction==null))
			{
				var popUpN:PopupNoData = new PopupNoData;
				popUpN.availWidth = stage.width * 0.8;
				popUpN.availHeight = stage.height * 0.8;
				noDataPopup = popUpN;
				popUpN.open(this, true);
				popUpN.addEventListener(PopUpEvent.CLOSE,onNoDataPopUpClose);	
			}else{
				
				//check if all braden exist. If not produce dialog asking if they want to complete.
				if(_BradenState==true||((_BradenSensory==null)&&(_BradenMobility==null)&&(_BradenMoisture==null)&&
					(_BradenActivity==null)&&(_BradenNutrition==null)&&(_BradenFriction==null)))
				{
					DataConfirmationController.setPatientName(patient.firstName+" "+patient.lastName);//send name to confirmation view
					
					//check if braden scale values all exist 
					if(dataEntryData.bradenScaleData.TOTAL)
					{
//-----------------send braden disabled till further notice----------------------------------------------------------------
//				this.vitalSignService.insertBradenScale(dataEntryData.patient,dataEntryData.bradenScaleData.bradenScaleDTO,dataEntryData.loginUser.username);
//-------------------------------------------------------------------------------------------------------------------------
					}
					
					sendToDatabase();//db submission in the background

					dataEntryData = new DataEntryData();//reset data object
					dataEntryData.patient = patient;//reset patient
					dataEntryData.loginUser = loginUser;//reset user
					data = dataEntryData;//reset data
					navigator.popView();
					navigator.pushView(DataConfirmation, data);//to data confirmation page		
					resetAllFields();//reset all fields in this class
				}
				else
				{
					var popUpB:PopupBraden = new PopupBraden;
					popUpB.availWidth = stage.width * 0.8;
					popUpB.availHeight = stage.height * 0.8;
					bradenPopup = popUpB;
					popUpB.open(this, true);
					popUpB.addEventListener(PopUpEvent.CLOSE,onBradenPopUpClose);	
				}
			}
		}
		
		public function onNoDataPopUpClose(event:PopUpEvent):void
		{
			if( event.commit ){
				var reply:String = event.data as String;
				alertNoData(reply);
			}
		}
		
		// Event handler function for displaying the selected Alert button.
		private function alertNoData(str:String):void {
			if (str == "No") {
				// do nothing
			}else{
				dataEntryData = new DataEntryData();
				dataEntryData.patient = patient;
				dataEntryData.loginUser = loginUser;
				data = dataEntryData;
				navigator.popView();
			}
		}
		
		public function onBradenPopUpClose(event:PopUpEvent):void
		{
			if( event.commit ){
				var reply:String = event.data as String;
				alertBraden(reply);
			}
		}
		
		// Event handler function for displaying the selected Alert button.
		private function alertBraden(str:String):void {
			if (str == "No") {
				
				if((dataEntryData.temperatureData.value==null)&&(dataEntryData.heartBpData.heartValue==null)&&(dataEntryData.heartBpData.bpValue==null)&&
					(dataEntryData.o2RespirationData.respirationValue==null)&&(dataEntryData.o2RespirationData.o2Value==null)&&				
					(dataEntryData.o2RespirationData.o2SaturationValue==null)&&(dataEntryData.painScaleData.painScaleData==null)&&
					(dataEntryData.weightData.heightValue==null)&&(dataEntryData.weightData.weightValue==null))
				{
					var popUpN:PopupNoData = new PopupNoData;
					popUpN.availWidth = stage.width * 0.8;
					popUpN.availHeight = stage.height * 0.8;
					noDataPopup = popUpN;
					popUpN.open(this, true);
					popUpN.addEventListener(PopUpEvent.CLOSE,onNoDataPopUpClose);	
				}else{
					
					DataConfirmationController.setPatientName(patient.firstName+" "+patient.lastName);//send name to confirmation view
					sendToDatabase();//db submission in the background
					dataEntryData = new DataEntryData();//reset data object
					dataEntryData.patient = patient;//reset patient
					dataEntryData.loginUser = loginUser;//reset user
					data = dataEntryData;//reset data
					navigator.pushView(DataConfirmation, data);//to data confirmation page
					resetAllFields();//reset all fields in this class
				}
				
			} else {
				//do nothing assuming here the nurse will go back to braden page to enter the incomplete values
			}
		}
		
		
		public function sendToDatabase():void
		{				
			//get all data to be saved and add to array collection
			addToVitalSignsArray();			
			
			//initiate database services and push array collection in
			if (vitalSigns.length != 0){
				this.vitalSignService.insertVitalSignsMySQL(patient,vitalSigns,dataEntryData.loginUser.username);
			}
		}
		
		
		private function addToVitalSignsArray():void
		{	
			//check if temperature inputs are set and add them to array
				if(dataEntryData.temperatureData.value!=null)
				{
					vitalSigns.addItem(dataEntryData.temperatureData.vitalSignDTO);
				}
		
			
			//check if heart inputs are set and add them to array
				if(dataEntryData.heartBpData.heartValue!=null)
				{
					vitalSigns.addItem(dataEntryData.heartBpData.pulseVitalSignDTO);
				}
				
				if(dataEntryData.heartBpData.bpValue!=null)
				{
					vitalSigns.addItem(dataEntryData.heartBpData.systolicVitalSignDTO);
					vitalSigns.addItem(dataEntryData.heartBpData.diastolicVitalSignDTO);
				}
					
			//check if respiration inputs are set and add them to array
				if(dataEntryData.o2RespirationData.respirationValue!=null)
				{
					vitalSigns.addItem(dataEntryData.o2RespirationData.respVitalSignDTO);
				}
				
				if(dataEntryData.o2RespirationData.o2Value!=null)
				{
					vitalSigns.addItem(dataEntryData.o2RespirationData.oxygenVitalSignDTO);
				}
				
				if(dataEntryData.o2RespirationData.o2SaturationValue!=null)
				{
					vitalSigns.addItem(dataEntryData.o2RespirationData.o2SatVitalSignDTO);
				}
				
			//check if painscale inputs are set and add them to array
				if(dataEntryData.painScaleData!=null)
				{
					vitalSigns.addItem(dataEntryData.painScaleData.painVitalSignDTO);
				}
			
			//check if weight and temperature inputs are set and add them to array
				if(dataEntryData.weightData.heightValue!=null)
				{
					vitalSigns.addItem(dataEntryData.weightData.heightVitalSignDTO);						
				}
				
				if(dataEntryData.weightData.weightValue!=null)
				{
					vitalSigns.addItem(dataEntryData.weightData.weightVitalSignDTO);
				}
				
			//reset all states
			_BradenState=false;
			
		}
		
		//reset all entered fields and pop to view before(patient list) 
		protected function cancelBtn_clickHandler(event:MouseEvent):void
		{
			resetAllFields();	
			dataEntryData = new DataEntryData();
			dataEntryData.patient = patient;
			dataEntryData.loginUser = loginUser;
			data = dataEntryData;
			navigator.popView();
		}
		
		//reset all fields
		public static function resetAllFields():void
		{
			_BradenState=false;
			_BradenSensory=null;
			_BradenMobility=null;
			_BradenMoisture=null;
			_BradenActivity=null;
			_BradenNutrition=null;
			_BradenFriction=null;
			bradenScaleModel = null;
			_BradenTotal=0;
		}
		
		
		//temperature
		public static function setTemperatureSite(value:String):void
		{
			dataEntryData.temperatureData.site=value;
		}
		
		public static function setTemperatureValue(value:String):void
		{	
			dataEntryData.temperatureData.value=value;
		}
		
		//heart		
		public static function setHeartRateSite(value:String):void
		{
			dataEntryData.heartBpData.heartSite=value;
		}
		
		public static function setPulseRate(value:String):void
		{
			dataEntryData.heartBpData.heartPulse=value;
		}
		
		public static function setHeartRateValue(value:String):void
		{
			dataEntryData.heartBpData.heartValue=value;
		}
		
		public static function setBloodPressureSite(value:String):void
		{
			dataEntryData.heartBpData.bpSite=value;
		}
		
		public static function setBloodPressurePosition(value:String):void
		{
			dataEntryData.heartBpData.bpPosition=value;
		}
		
		public static function setBloodPressureCuff(value:String):void
		{
			dataEntryData.heartBpData.bpCuff=value;
		}
		
		public static function setBloodPressureValue(value:String):void
		{
			dataEntryData.heartBpData.bpValue=value;
		}
		
		//oxygen
		public static function setRespirationRate(value:String):void
		{
			dataEntryData.o2RespirationData.respirationValue=value;
		}
		
		
		public static function setOxygenDevice(value:String):void
		{
			dataEntryData.o2RespirationData.o2Device=value;
		}
		
		
		public static function setIntakeUnit(value:String):void
		{
			dataEntryData.o2RespirationData.o2Unit=value;
		}
		
		
		public static function setOxygenValue(value:String):void
		{
			dataEntryData.o2RespirationData.o2Value=value;
		}
		
		
		public static function setOxygenSaturationSite(value:String):void
		{
			dataEntryData.o2RespirationData.o2SaturationSite=value;
		}
		
		
		public static function setOxygenSaturationValue(value:String):void
		{
			dataEntryData.o2RespirationData.o2SaturationValue=value;
		}
		
		//painscale
		public static function setPainscale(value:String):void
		{
			dataEntryData.painScaleData.painScaleData=value;
		}
		
		//braden
		public static function setBradenSensory(value:String):void
		{
			_BradenSensory=value;
			bradenStateCheck();
		}
		
		public static function setBradenMobility(value:String):void
		{
			_BradenMobility=value;
			bradenStateCheck();
		}
		
		public static function setBradenMoisture(value:String):void
		{
			_BradenMoisture=value;
			bradenStateCheck();
		}
		
		public static function setBradenActivity(value:String):void
		{
			_BradenActivity=value;
			bradenStateCheck();
		}
		
		public static function setBradenNutrition(value:String):void
		{
			_BradenNutrition=value;
			bradenStateCheck();
		}
		
		public static function setBradenFriction(value:String):void
		{
			_BradenFriction=value;
			bradenStateCheck();
		}
		
		
		public static function bradenStateCheck():void
		{
			if((_BradenSensory!=null)&&(_BradenMobility!=null)&&(_BradenMoisture!=null)&&
				(_BradenActivity!=null)&&(_BradenNutrition!=null)&&(_BradenFriction!=null))
			{
				_BradenState=true;
				setBradenValue(bradenScaleModel);
			}else{
				_BradenState=false;
				bradenScaleModel=new BradenScaleEntryModel();
			}
		}
		
		public static function setBradenValue(bradenScaleModel:BradenScaleEntryModel):void
		{
			bradenScaleModel.b1SENSRY = int(_BradenSensory);
			bradenScaleModel.b2MOBLTY = int(_BradenMobility);
			bradenScaleModel.b3MSTURE = int(_BradenMoisture);
			bradenScaleModel.b4ACTVTY = int(_BradenActivity);
			bradenScaleModel.b5NUTRTN = int(_BradenNutrition);
			bradenScaleModel.b6FRCTSH  =int(_BradenFriction);
			
			_BradenTotal = bradenScaleModel.b1SENSRY + bradenScaleModel.b2MOBLTY + bradenScaleModel.b3MSTURE + bradenScaleModel.b4ACTVTY + bradenScaleModel.b5NUTRTN + bradenScaleModel.b6FRCTSH;
			bradenScaleModel.TOTAL=_BradenTotal;
			dataEntryData.bradenScaleData=bradenScaleModel;
		}
		
		public  function get BradenState():Boolean
		{
			return _BradenState;
		}
		
		
		//heightweight
		public static function setHeightMeasurementMethod(value:String):void
		{
			dataEntryData.weightData.heightMethod=value;
		}
		
		
		public static function setHeightCms(value:String):void
		{
			dataEntryData.weightData.heightValue=value;
		}
		
		
		public static function setWeightMeasurementMethod(value:String):void
		{
			dataEntryData.weightData.weightMethod=value;
		}
		
		public static function setWeightKgs(value:String):void
		{
			dataEntryData.weightData.weightValue=value;
		}
		
		protected function resources_clickHandler(event:MouseEvent):void
		{
			navigator.pushView(ResourcesView);
		}
		
		protected function vitalSignService_resultHandler( event:ResultEvent ):void{
			
		}
		
		protected function vitalSignService_faultHandler( event:FaultEvent ):void{
			var theMessage:String = event.message.toString();	
			var i:int = 0;
		}
		
		//////////////////////////////////////pain/braden controller logic///////////////////////////////////////////
		
		public static function get painPoint():int
		{
			return pPoint;
		}
		
		public static function get sensoryText():String
		{
			return sensText;
		}
		
		public static function get mobilityText():String
		{
			return mobilText;
		}
		
		public static function get moistureText():String
		{
			return moistText;
		}
		
		public static function get activityText():String
		{
			return activText;
		}
		
		public static function get nutritionText():String
		{
			return nutriText;
		}
		
		
		public static function get frictionText():String
		{
			return frictText;
		}
		
		protected function orientationChanged(width:int, height:int):void
		{
			mainRect.height = this.stage.height;
		}
		
		protected function braden_addHandler(event:FlexEvent):void
		{
			VitalSigns.registerOrientationChangeListener( orientationChanged );	
		}
		
		protected function slider_changeEndHandler(event:FlexEvent):void
		{
			VitalSigns.isSliderActive = false;
			pPoint=painSlider.value;
			var painValStr:String=painPoint.toString();
			DataConfirmationController.setPainscale(painValStr);
			setPainscale(painValStr);
			
		}
		protected function slider_changeStartHandler(event:FlexEvent):void
		{
			VitalSigns.isSliderActive = true;
		}
		
		protected function sensoryBB_changeHandler(event:IndexChangeEvent):void
		{	
			if(event.newIndex!=-1){
				var selectedStr:String=sensMobArray[sensoryBB.selectedItem - 1];
				sensoryLbl.text=selectedStr;
				DataConfirmationController.setBradenSensory(selectedStr);
				setBradenSensory(sensoryBB.selectedItem);
				sensText = selectedStr;
			}else{
				sensoryLbl.text=null;
				DataConfirmationController.setBradenSensory(null);
				setBradenSensory(null);
				sensText=null;
			}
		}
		
		protected function mobilityBB_changeHandler(event:IndexChangeEvent):void
		{
			//event.newIndex returns the index of the currently clicked button
			//event.newIndex if is equal to current mobility index would mean the button has been deselected
			//hence we would also reset the mobility index.
			if(event.newIndex!=-1){
				var selectedStr:String=sensMobArray[mobilityBB.selectedItem - 1];
				mobilityLbl.text=selectedStr;
				DataConfirmationController.setBradenMobility(selectedStr);
				setBradenMobility(mobilityBB.selectedItem);
				mobilText = selectedStr;
			}else{
				mobilityLbl.text=null;
				DataConfirmationController.setBradenMobility(null);
				setBradenMobility(null);
				mobilText=null;
			}	
		}
		
		protected function frictionBB_changeHandler(event:IndexChangeEvent):void
		{
			if(event.newIndex!=-1){
				var selectedStr:String= frictionArray[frictionBB.selectedItem - 1];
				frictionLbl.text=selectedStr;
				DataConfirmationController.setBradenFriction(selectedStr);
				setBradenFriction(frictionBB.selectedItem);
				frictText = selectedStr;
			}else{
				frictionLbl.text=null;
				DataConfirmationController.setBradenFriction(null);
				setBradenFriction(null);
				frictText=null;
			}
		}
		
		protected function nutritionBB_changeHandler(event:IndexChangeEvent):void
		{
			if(event.newIndex!=-1){
				var selectedStr:String= nutritionArray[nutritionBB.selectedItem - 1];
				nutritionLbl.text=selectedStr;
				DataConfirmationController.setBradenNutrition(selectedStr);
				setBradenNutrition(nutritionBB.selectedItem);
				nutriText = selectedStr;
			}else{
				nutritionLbl.text=null;
				DataConfirmationController.setBradenNutrition(null);
				setBradenNutrition(null);
				nutriText=null;
			}
		}
		
		protected function activityBB_changeHandler(event:IndexChangeEvent):void
		{
			if(event.newIndex!=-1){
				var selectedStr:String= activityArray[activityBB.selectedItem - 1];
				activityLbl.text=selectedStr;	
				DataConfirmationController.setBradenActivity(selectedStr);
				setBradenActivity(activityBB.selectedItem);
				activText = selectedStr;
			}else{
				activityLbl.text=null;
				DataConfirmationController.setBradenActivity(null);
				setBradenActivity(null);
				activText=null;
			}
		}
		
		protected function moistureBB_changeHandler(event:IndexChangeEvent):void
		{
			if(event.newIndex!=-1){
				var selectedStr:String= moistureArray[moistureBB.selectedItem - 1];
				moistureLbl.text=selectedStr;		
				DataConfirmationController.setBradenMoisture(selectedStr);
				setBradenMoisture(moistureBB.selectedItem);
				moistText = selectedStr;
			}else{
				moistureLbl.text=null;
				DataConfirmationController.setBradenMoisture(null);
				setBradenMoisture(null);
				moistText=null;
			}
		}
	}
}
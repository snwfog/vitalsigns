package model
{
	import mx.collections.ArrayCollection;
	
	public class Data
	{
		private var tempSitesArray:Array = new Array("Oral", "Rectal", "Axillary", "Topical", "Core");
		private var heartSitesArray:Array = new Array("Apical", "Left Axillary", "Left Brachial", "Left Carotid", 
			"Left Femoral", "Left Pedal", "Left Posterior Tibialis", "Left Radial", "Right Axillary",
			"Right Brachial", "Right Carotid", "Right Femoral", "Right Pedal", "Right Radial", 
			"Right Posterior Tibialis", "Electronic Device");
		private var bpSitesArray:Array = new Array("Left Arm", "Left Thigh", "Right Arm", "Right Thigh", "Right Calf", "Left Calf");
		private var bpPostitionsArray:Array = new Array("Supine", "Sitting", "Standing");
		private var bpCuffsArray:Array = new Array("Automatic Cuff", "Manual Cuff", "Manual/Palpation");
		private var o2DevicesArray:Array = new Array("Room Air", "Nasal Prongs / Cannula", "Nasal CPAP", "Full Facce CPAP", 
			"Full Face BIPAP", "Nasal BIPAP", "Mask (Partial Rebreather)", "Mask (Non-Rebreather)", 
			"High Humidity / Aerosol Mask", "Mask Venturi (Multi-Concentration)", "Mid Oxygen Concentration Mask", 
			"Trach Collar", "Other");
		private var o2SatArray:Array = new Array("Earlobe", "Finger", "Toe/Foot", "Other");
		private var heightMethodsArray:Array = new Array("Estimated", "Measured", "Stated", "Transfer Records");
		private var weightMethodsArray:Array = new Array("Standing Scale - Mechanical", "Standing Scale - Electronic", 
			"Bed Scale", "Patient Lift with Electronic Scale", 
			"Electronic Stretcher Scale", "Wheelchair Scale", "Infant Scale", 
			"Estimated", "Stated", "Transfer Records", "Other");
		
		[Bindable]public var temperatureSite : ArrayCollection = new ArrayCollection(tempSitesArray);
		[Bindable]public var heartSite : ArrayCollection = new ArrayCollection (heartSitesArray);
		[Bindable]public var bpSite : ArrayCollection = new ArrayCollection(bpSitesArray);		
		[Bindable]public var bpPosition : ArrayCollection = new ArrayCollection(bpPostitionsArray);
		[Bindable]public var bpCuff : ArrayCollection = new ArrayCollection(bpCuffsArray);
		[Bindable]public var o2Device : ArrayCollection = new ArrayCollection(o2DevicesArray);
		[Bindable]public var o2SaturationSite : ArrayCollection = new ArrayCollection(o2SatArray);
		[Bindable]public var heightMethod : ArrayCollection = new ArrayCollection (heightMethodsArray);
		[Bindable]public var weightMethod : ArrayCollection = new ArrayCollection (weightMethodsArray);
		
		public static var instance : Data ; 
		
		public function Data() {}
		
		public static function getInstance():Data
		{
			if(!instance)
				instance = new Data();

			return instance;
		}
		
		public static function getIndex(array:ArrayCollection, find:String):int
		{
			var returnValue : int;
			for(var i : int = 0 ; i < array.length ; i++)
			{
				if(array.getItemAt(i).value as String == find)
					returnValue = i;
				else if (i==array.length)
					returnValue = -1;
				else 
					continue;
				
			}
			return returnValue;
		}
		
		public static function getRangeError (vitalSign:String, value:String, low:Number, high:Number):String
		{
			var returnValue : String = "";
			if (vitalSign == DataTypeEnum.BLOODPRESSURE)
			{
				var systolic : String = value.substring(0, value.indexOf("/", 0)); 
				var diastolic : String = value.substring(value.indexOf("/", 0) + 1, value.length + 1);

				if ((Number(systolic) < low || Number(systolic) > high) || (Number(diastolic) < low || Number(diastolic) > high)){
					returnValue = vitalSign + " out of range! Only numeric values between " + low + " and " + high + " are valid";
				}
			}
			else if(value==""){
				returnValue = "No value entered. Kindly enter a value or click Cancel to exit.";
			}
			else{
				if (Number(value) < low || Number(value) > high)
					returnValue = vitalSign + " out of range! Only numeric values between " + low + " and " + high + " are valid";
			}
			return returnValue;
		}
	}
}
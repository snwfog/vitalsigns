package domain.vitalsign
{
	import flash.utils.Dictionary;

	public class VitalSignType
	{
		public static const TEMPERATURE:String = "TEMPOb";
		public static const HEARTRATE:String = "PULSE";
		public static const SYSTOLIC:String = "SYSTOLIC";
		public static const DIASTOLIC:String = "DIASTOLIC";
		public static const RESPIRATION:String = "RESPOb";
		public static const OXYGEN:String = "OXYGEN";
		public static const O2SATURATION:String = "SAO2";
		public static const PAINSCALE:String = "PAINSCORE";
		public static const HEIGHT:String = "HGHT";
		public static const WEIGHT:String = "WEIGHT";
		
		public static var NormalName:Dictionary = new Dictionary();
		NormalName[ TEMPERATURE ] = "Temperature";
		NormalName[ HEARTRATE ] = "Heart Beat";
		NormalName[ SYSTOLIC ] = "Blood Pressure";
		NormalName[ RESPIRATION ] = "Respiration";
		NormalName[ OXYGEN ] = "Oxygen";
		NormalName[ O2SATURATION ] = "O2 Saturation";
		NormalName[ PAINSCALE ] = "Pain Scale";
		NormalName[ HEIGHT ] = "Height";
		NormalName[ WEIGHT ] = "Weight";
	}
}
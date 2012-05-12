package domain.vitalsign
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	
	import valueObjects.VitalSignDTO;

	public class VitalSignFactory
	{
		private static var internalTypesToClass:Dictionary = new Dictionary();
		
		// static block...
		internalTypesToClass[ VitalSignType.SYSTOLIC ] = BloodPressureVitalSign;
		internalTypesToClass[ VitalSignType.DIASTOLIC ] = BloodPressureVitalSign;
		internalTypesToClass[ VitalSignType.RESPIRATION ] = RespirationVitalSign;
		internalTypesToClass[ VitalSignType.PAINSCALE ] = PainVitalSign;
		internalTypesToClass[ VitalSignType.O2SATURATION ] = SaturationVitalSign;
		internalTypesToClass[ VitalSignType.TEMPERATURE ] = TemperatureVitalSign;
		internalTypesToClass[ VitalSignType.OXYGEN ] = OxygenVitalSign;
		internalTypesToClass[ VitalSignType.HEARTRATE ] = HeartVitalSign;
		internalTypesToClass[ VitalSignType.HEIGHT ] = HeightVitalSign;
		internalTypesToClass[ VitalSignType.WEIGHT ] = WeightVitalSign;
		// end static block
		
		public function VitalSignFactory(){
			throw new Error( "Static class" );
		}
		
		
		public static function createVitalSign( type:String ):VitalSign{
			try{
				var vitalSignClassFactory:ClassFactory = new ClassFactory( internalTypesToClass[ type ] as Class );
				var newVS:VitalSign = vitalSignClassFactory.newInstance() as VitalSign; 
				return newVS;
			} catch( e:Error ){
				
			}
			return new VitalSign();
		}
	}
}
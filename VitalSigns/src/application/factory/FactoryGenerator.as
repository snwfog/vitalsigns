package application.factory
{
	import flash.utils.getDefinitionByName;

	public class FactoryGenerator
	{
		public function FactoryGenerator(){
			throw new Error( "Static class" );
		}
		
		public static function getFactory():IPlatformFactory{
			try{
				var myClass:Class = getDefinitionByName( "com.adobe.ep.notifications.Notification" ) as Class;
			} catch( e:* ){
				return new DesktopFactory();
			}
			return new DeviceFactory();
		}
	}
}
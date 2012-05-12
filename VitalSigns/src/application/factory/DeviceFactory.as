package application.factory
{
	import application.controller.messaging.factory.DeviceNotifier;
	import application.controller.notes.factory.AndroidSpeech;

	public class DeviceFactory implements IPlatformFactory
	{
		public function DeviceFactory(){}
		
		public function createNotificationCenter():INotifier{
			return new DeviceNotifier();
		}
		
		public function createSpeechCenter():ISpeech{
			return new AndroidSpeech();
		}
	}
}
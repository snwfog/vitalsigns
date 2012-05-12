package application.factory
{
	import application.controller.messaging.factory.DesktopNotifier;
	import application.controller.notes.factory.DesktopSpeech;

	public class DesktopFactory implements IPlatformFactory
	{
		public function DesktopFactory(){}
		
		public function createNotificationCenter():INotifier{
			return new DesktopNotifier();
		}
		
		public function createSpeechCenter():ISpeech{
			return new DesktopSpeech();
		}
	}
}
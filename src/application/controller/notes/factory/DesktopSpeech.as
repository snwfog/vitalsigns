package application.controller.notes.factory
{
	import application.factory.ISpeech;

	public class DesktopSpeech implements ISpeech
	{		
		
		public function DesktopSpeech(){}
		
		public function startSpeech(receiveSpeech:Function):void{
			VitalSigns.showMessage( "Speech not supported on this platform" );
		}
	}
}
package application.controller.notes.factory
{
	import application.factory.ISpeech;
	
	import com.inoel.ane.speech.Speech;
	import com.inoel.ane.speech.speechToTextEvent;
	
	
	public class AndroidSpeech implements ISpeech
	{
		
		private var _forwardFunction:Function;
		private var speech:Speech = new Speech( "Please speak your note!" );
		
		public function AndroidSpeech(){
			_forwardFunction = function( message:String ):void{};
		}
		
		public function startSpeech( receiveSpeech:Function ):void{
			if( speech.isSupported ){
				_forwardFunction = receiveSpeech;
				speech.addEventListener( speechToTextEvent.VOICE_RECOGNIZED, dataRecievedHandler );
				speech.addEventListener( speechToTextEvent.VOICE_NOT_RECOGNIZED, dataNotReceivedHandler );
				speech.listen();
			}
		}
		
		protected function dataRecievedHandler( event:speechToTextEvent ):void{
			var text:String = event.data as String;
			_forwardFunction( text );
		}
		
		protected function dataNotReceivedHandler( event:speechToTextEvent ):void{
			// maybe do something for this case?
			//_forwardFunction();
		}
	}
}
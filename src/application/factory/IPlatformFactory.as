package application.factory
{
	public interface IPlatformFactory
	{
		function createNotificationCenter():INotifier;
		function createSpeechCenter():ISpeech;
	}
}
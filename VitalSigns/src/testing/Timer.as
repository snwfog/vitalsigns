package testing
{
	import flash.utils.getTimer;
	
	public class Timer
	{
		public static var startTime:int;
		public static var previousBench:int;
		public static var runID:int;
		public static var running:Boolean = false;
		
		public static function startTimer():void
		{
			if (!running) {
				DBConnection.init();
				startTime = getTimer();
				runID = DBConnection.getMaxRunID();
				running = true;
				previousBench = startTime;
			}
		}
		
		public static function benchmark(task:String):void
		{
			var benchTime:int = getTimer();
			if (running) {
				benchTime = benchTime - previousBench;
				DBConnection.insert(runID, task, benchTime);
			}
			else if (startTime != 0) {
				benchTime = benchTime - startTime;
				startTime = 0;
				DBConnection.insert(runID, task, benchTime);
			}
		}
		
		public static function stopTimer():void
		{
			running = false;
			benchmark("Run Completed");
		}
	}
}
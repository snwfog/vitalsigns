package application.controller.chart.strategy
{
	import application.controller.chart.ChartController;
	
	import mx.core.ClassFactory;

	public interface IChartDisplay
	{
		function prepareData( chartController:ChartController ):void;
		
		function getRawDataRenderer():ClassFactory;
		function getState( isPortrait:Boolean ):String;
		function getDisplayName():String;
		function getInterval():int;
	}
}
package application.component
{
	import mx.charts.series.items.PlotSeriesItem;
	import mx.core.IDataRenderer;
	import mx.skins.ProgrammaticSkin;
	
	public class TriangleRenderer extends mx.skins.ProgrammaticSkin 
		implements IDataRenderer {
		
		private var _plotItem:PlotSeriesItem;
		public function TriangleRenderer() {
			
		}
		
		public function get data():Object {
			return _plotItem;
		}
		
		public function set data(value:Object):void {
			_plotItem = value as PlotSeriesItem;
			invalidateDisplayList();
		}
		
		override protected function	updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			graphics.clear();
			graphics.beginFill(0x0000FF);
			graphics.moveTo(5.5, 4.5);
			graphics.lineTo(1.5, -2.5);
			graphics.lineTo(9.5, -2.5);
			graphics.lineTo(5.5, 4.5);
			graphics.endFill();
		}
	}
}
package application.controller.notes
{
	import application.controller.messaging.NotificationController;
	import application.view.notes.PhotosView;
	
	import domain.IObservable;
	import domain.image.Image;
	import domain.image.ImageFactory;
	
	import flash.display.BitmapData;
	import flash.display.StageOrientation;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.ByteArray;
	
	import mx.events.FlexEvent;
	import mx.graphics.codec.JPEGEncoder;
	
	import spark.components.mediaClasses.DynamicStreamingVideoSource;
	import spark.core.SpriteVisualElement;
	import spark.events.ViewNavigatorEvent;

	public class CameraViewController extends NotificationController {
		private var _dynVideoSource:DynamicStreamingVideoSource;
		private var _cam:Camera;
		
		public var matrix:Matrix;
		public var bmpData:BitmapData;
		public var videoDisplay:Video;
		public var video:SpriteVisualElement = new SpriteVisualElement();
		
		public function CameraViewController() { super(); }
		
		protected function cameraView_creationCompleteHandler(event:FlexEvent):void { }
		
		protected function cameraView_activateHandler(event:ViewNavigatorEvent):void {
			_cam = Camera.getCamera();
			relocate(stage.width, stage.height);
			video.addChild(videoDisplay);
			videoDisplay.attachCamera(_cam);
			stage.autoOrients = false;
		}
		
		protected function cameraView_deactivateHandler(event:ViewNavigatorEvent):void {
			videoDisplay.attachCamera(null);
			stage.autoOrients = true;
		}
		
		protected function captureBtn_clickHandler(event:MouseEvent):void {
			matrix = new Matrix();
			bmpData = new BitmapData(videoDisplay.width, videoDisplay.height);
			
			if (stage.orientation == StageOrientation.DEFAULT ||
				stage.orientation == StageOrientation.UPSIDE_DOWN) {
				matrix.rotate(Math.PI/2);
				matrix.tx = bmpData.width;
			}
			bmpData.draw(videoDisplay, matrix);
			var encoder:JPEGEncoder = new JPEGEncoder(90);
			var byteArray:ByteArray = encoder.encode(bmpData);
			var image:Image = ImageFactory.createImageFromByteArray(byteArray);
			navigator.pushView(PhotosView, image);
		}
		
		private function relocate(x:int, y:int):void {
			if (stage.orientation == StageOrientation.DEFAULT ||
				stage.orientation == StageOrientation.UPSIDE_DOWN) {
				videoDisplay = new Video(y, x);
				_cam.setMode(y, x, _cam.fps);
				videoDisplay.x = stage.width;
				videoDisplay.rotation = 90;
			} else {
				videoDisplay = new Video(y, x);
				_cam.setMode(y, x, _cam.fps);
			}
		}
		
		override public function createReturnObject():Object {
			return data;
		}
	}
}
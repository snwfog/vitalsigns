package application.controller.notes
{
	import application.component.ImageView;
	import application.controller.messaging.NotificationController;
	
	import domain.image.Image;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.effects.MaskEffect;
	import mx.effects.WipeLeft;
	import mx.effects.WipeRight;
	
	import spark.components.Button;
	import spark.components.List;
	import spark.events.IndexChangeEvent;

	public class PhotosViewController extends NotificationController
	{
		[Bindable]
		public var image:ImageView = new ImageView();
		public var cancelBtn:Button;
		public var acceptBtn:Button;
		public var ui:UIComponent;
		public var wipe_left:WipeLeft = new WipeLeft();
		public var wipe_right:WipeRight = new WipeRight();
		[Bindable]
		public var wipe:MaskEffect;
		
		private var selectedImageIndex:int = 0;
		private var bitmapData:BitmapData;
		
		public function PhotosViewController() { super(); }
		
		protected function photosView_creationCompleteHandler(event:Event):void {
			VitalSigns.registerOrientationChangeListener(resize);
			
			image.setSize(stage.width, stage.height);
			image.x = 0;
			image.y = 0;
			ui.addChild(image);
			if (data) {
				var loader:Loader = new Loader();
				var byteArray:ByteArray;
				if (data is Image) {
					this.currentState = "photo";
					byteArray = (data as Image).image;
				}
				if (data is ArrayCollection) {
					var arrPhotos:ArrayCollection = data as ArrayCollection;
					if (navigator.context is int && navigator.context != -1) { 
						this.currentState = "newAttachments";
						selectedImageIndex = navigator.context as int;
					} else {
						this.currentState = "previousAttachments";
					}
					byteArray = (arrPhotos.getItemAt(selectedImageIndex) as Image).image;
				}
				loader.loadBytes(byteArray);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
				this.cursorManager.setBusyCursor();
			}
		}
		
		private function loaderComplete(event:Event):void {
			var loaderInfo:LoaderInfo = LoaderInfo(event.target);
			bitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, false, 0xFFFFFF);
			bitmapData.draw(loaderInfo.loader);
			image.setImage(bitmapData);
			this.cursorManager.removeBusyCursor();
		}
		
		private function resize(x:int, y:int):void {
			ui.width = x;
			ui.height = y;
			image.setSize(ui.width, ui.height);
		}
		
		protected function cancelBtn_clickHandler(event:MouseEvent):void {
			if (currentState == "photo") {
				data = null;
				navigator.popView();
			} else {
				var arrPhotos:ArrayCollection = data as ArrayCollection;
				arrPhotos.removeItemAt(selectedImageIndex);
				if (selectedImageIndex == arrPhotos.length) {
					selectedImageIndex--;
					if (selectedImageIndex < 0) {
						navigator.popView();
						data = new ArrayCollection();
						return;
					}
				}
				var byteArray:ByteArray = ((data as ArrayCollection).getItemAt(selectedImageIndex) as Image).image;
				var loader:Loader = new Loader();
				loader.loadBytes(byteArray);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
				this.cursorManager.setBusyCursor();
			}
		}
		
		protected function acceptBtn_clickHandler(event:MouseEvent):void {
			if (currentState == "newAttachments" || currentState == "previousAttachments") {
				navigator.popView();
				return;
			}
			navigator.popView();
			navigator.popView();
		}
		
		protected function photosList_changeHandler(event:IndexChangeEvent):void {
			var images:ArrayCollection = data as ArrayCollection;
			var currentImageIndex:int = event.newIndex;
			var byteArray:ByteArray = (images.getItemAt(currentImageIndex) as Image).image;
			var loader:Loader = new Loader();
			loader.loadBytes(byteArray);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		}
		
		protected function swipe_gestureHandler(event:TransformGestureEvent):void {
			if (currentState == "photo")
				return;
			if (!VitalSigns.isSliderActive) {
				var arrPhotos:ArrayCollection = data as ArrayCollection;
				var byteArray:ByteArray;
				var loader:Loader = new Loader();
				if (arrPhotos.length == 1)
					return;
				if (event.offsetX == -1) {
					wipe = wipe_left;
					if (selectedImageIndex < arrPhotos.length) {
						selectedImageIndex++;
						byteArray = (arrPhotos.getItemAt(selectedImageIndex) as Image).image;
						loader.loadBytes(byteArray);
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
						this.cursorManager.setBusyCursor();
					}
				}
				if (event.offsetX == 1) {
					wipe = wipe_right;
					if (selectedImageIndex != 0) {
						selectedImageIndex--;
						byteArray = (arrPhotos.getItemAt(selectedImageIndex) as Image).image;
						loader.loadBytes(byteArray);
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
						this.cursorManager.setBusyCursor();
					}
				}
			}
		}
		
		override public function createReturnObject():Object {
			if (currentState == "photo" || currentState == "newAttachments")
				return data;
			return null;
		}
	}
}
package application.component
{
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Matrix;
	
	import spark.components.HGroup;
	
	public class ImageView extends Sprite
	{
		private var mData:BitmapData = null;
		private var mDefaultMatrix:Matrix;
		private var mCanvasWidth:int = 0;
		private var mCanvasHeight:int = 0;
		private var mCanvas:Sprite;
		private var mTouchX:Number = -1;
		private var mTouchY:Number = -1;
		
		public function ImageView()
		{
			super();
			mData = null;
			
			this.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			mCanvas = new Sprite();
			addChild(mCanvas);
		}
		
		public function setSize(width:int, height:int):void
		{
			mCanvasWidth = width;
			mCanvasHeight = height;

			if(mData != null)
			{
				mDefaultMatrix = new Matrix();
				if (mData.width > mData.height)
				{
					mDefaultMatrix.a = mCanvasWidth / mData.width;
					mDefaultMatrix.d = mDefaultMatrix.a;
				}
				else
				{
					mDefaultMatrix.d = mCanvasHeight / mData.height;
					mDefaultMatrix.a = mDefaultMatrix.d;
				}
				mCanvas.scaleX = mDefaultMatrix.a;
				mCanvas.scaleY = mDefaultMatrix.d;
				mCanvas.x = mDefaultMatrix.tx;
				mCanvas.y = mDefaultMatrix.ty;
			}
		}
		
		public function setImage(bd:BitmapData):void
		{
			if(bd != null)
			{
				mCanvas.graphics.beginBitmapFill(bd,null,false,true);
				mCanvas.graphics.drawRect(0,0,bd.width, bd.height);
				mCanvas.graphics.endFill();
				
				mDefaultMatrix = new Matrix();
				// scale image while maintaining aspect ratio
				if (bd.width > bd.height)
				{
					mDefaultMatrix.a = mCanvasWidth / bd.width;
					mDefaultMatrix.d = mDefaultMatrix.a;
				}
				else
				{
					mDefaultMatrix.d = mCanvasHeight / bd.height;
					mDefaultMatrix.a = mDefaultMatrix.d;
				}
				mCanvas.scaleX = mDefaultMatrix.a;
				mCanvas.scaleY = mDefaultMatrix.d;
				mCanvas.x = mDefaultMatrix.tx;
				mCanvas.y = mDefaultMatrix.ty;
				
				if(mData != null)
				{
					mData.dispose();
				}
				mData = bd;
			}
			else
			{
				mCanvas.graphics.clear();
				if(mData != null)
				{
					mData.dispose();
					mData = null;
				}
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			Tweener.removeAllTweens();
			mTouchX = e.stageX;
			mTouchY = e.stageY;
		}
		
		private function onMouseUp(e:MouseEvent):void
		{					
			mTouchX = -1;
			mTouchY = -1;
			
			var imageWidth:int = mCanvas.scaleX * mData.width;
			var imageHeight:int = mCanvas.scaleY * mData.height;
						
			// keep the top of the image stuck to the top of the view if it is dragged too low
			if(mCanvas.y > 0)
			{
				Tweener.addTween(mCanvas, {y:0, time:0.5, transition:"easeOutQuart"});
			}
			// when image height is less than view height, keep the image aligned to the top
			else if(imageHeight <= mCanvasHeight && mCanvas.y < 0)
			{
				Tweener.addTween(mCanvas, {y:0, time:0.5, transition:"easeOutQuart"});
			}
			// keep the bottom of the image stuck to the bottom of the view if it is dragged too high
			else if(imageHeight > mCanvasHeight && mCanvas.y + imageHeight < mCanvasHeight)
			{
				Tweener.addTween(mCanvas, {y:mCanvasHeight - imageHeight, time:0.5, transition:"easeOutQuart"});
			}
			
			// prevent left of image from going further right than the left of the view
			if(mCanvas.x > 0)
			{
				Tweener.addTween(mCanvas, {x:0, time:0.5, transition:"easeOutQuart"});
			}
			else if(mCanvas.x + imageWidth < mCanvasWidth)
			{
				Tweener.addTween(mCanvas, {x:mCanvasWidth - imageWidth, time:0.5, transition:"easeOutQuart"});
			}
			
			if(mCanvas.scaleX < mDefaultMatrix.a)
			{
				Tweener.addTween(mCanvas, {scaleX:mDefaultMatrix.a, time:0.5, transition:"easeOutQuart"});
			}
			
			if(mCanvas.scaleY < mDefaultMatrix.d)
			{
				Tweener.addTween(mCanvas, {scaleY:mDefaultMatrix.d, time:0.5, transition:"easeOutQuart"});
			}
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			if(mTouchX != -1 && mTouchY != -1) 
			{
				var dx:Number = e.stageX - mTouchX;
				var dy:Number =  e.stageY - mTouchY;
				mTouchX = e.stageX;
				mTouchY = e.stageY;
				
				var affineTransform:Matrix = mCanvas.transform.matrix;
				
				// move the object to (0/0) relative to the origin
				affineTransform.translate( dx, dy );
				
				// apply the new transformation to the object
				mCanvas.transform.matrix = affineTransform;
			}
		}
		
		private function onZoom(e:TransformGestureEvent):void
		{
			e.stopImmediatePropagation();
			
			var affineTransform:Matrix = mCanvas.transform.matrix;
			
			// move the object to (0/0) relative to the origin
			affineTransform.translate( -e.stageX, -e.stageY );
			
			// scale, maintaining aspect ratio
			if (e.scaleX == 1)
				affineTransform.scale(e.scaleY, e.scaleY );
			else if (e.scaleY == 1)
				affineTransform.scale(e.scaleX, e.scaleX );
			else if (e.scaleX > e.scaleY)
				affineTransform.scale(e.scaleX, e.scaleX );
			else
				affineTransform.scale(e.scaleY, e.scaleY );
			
			// move the object back to its original position
			affineTransform.translate( e.stageX, e.stageY );
			
			// apply the new transformation to the object
			mCanvas.transform.matrix = affineTransform;
		}
	}
}
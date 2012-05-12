package domain.image
{
	import domain.model.IDomainObject;
	
	import flash.utils.ByteArray;
	
	[Bindable]
	public class Image implements IDomainObject
	{
		private var _category:String;
		private var _image:ByteArray;
		private var _imageId:int;
		private var _originalName:String;
		
		public function Image( imageId:int = 0, image:ByteArray = null, category:String = "", originalName:String = "" ){
			_imageId = imageId;
			_image = image;
			_category = category;
			_originalName = originalName;
		}
		
		public function get imageId():int{
			return _imageId;
		}
		
		public function get image():ByteArray{
			return _image;
		}
		
		public function set image( value:ByteArray ):void{
			_image = value;
		}
		
		public function get category():String{
			return _category;
		}
		
		public function get originalName():String{
			return _originalName;
		}
		
	}
}
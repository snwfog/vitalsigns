package domain.note
{
	import domain.image.Image;
	import domain.model.IDomainObject;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;

	public class Note implements IDomainObject
	{
		private var _text:String;
		private var _author:int;
		private var _patient:int;
		private var _images:ArrayCollection;
		private var _date:Date;
		
		public function Note(text:String = "", author:int = 0, patient:int = 0, 
							 images:ArrayCollection = null, date:Date = null) {
			_text = text;
			_author = author;
			_patient = patient;
			if (images == null)
				images = new ArrayCollection();
			_images = images;
			if (date == null)
				date = new Date();
			_date = date;
		}
		
		public function getText():String {
			return _text;
		}
		
		public function getAuthor():int {
			return _author;
		}
		
		public function getPatient():int {
			return _patient;
		}
		
		public function getImages():ArrayCollection {
			return _images;
		}
		
		public function getDate():Date {
			return _date;
		}
		
		public function setText(text:String):void {
			_text = text;
		}
		
		public function setAuthor(author:int):void {
			_author = author;
		}
		
		public function setPatient(subject:int):void {
			_patient = subject;
		}
		
		public function setDate(date:Date):void {
			_date = date;
		}
		
		public function setImages(images:ArrayCollection):void {
			_images = images;
		}
		
		public function hasImages():Boolean {
			if (_images == null || _images.length == 0)
				return false;
			return true;
		}
		
		public function getImageAt(index:int):Image {
			return _images.getItemAt(index) as Image;
		}
		
		public function getNumberOfImages():int {
			return _images.length;
		}
		
		public function addImage(image:Image):void {
			_images.addItem(image);
		}
		
		public function removeImageAt(index:int):void {
			_images.removeItemAt(index);
		}
	}
}
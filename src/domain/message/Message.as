package domain.message
{
	import domain.model.IDomainObject;
	import domain.user.User;
	
	import valueObjects.MessageDTO;
	
	public class Message implements IDomainObject
	{
		
		private var _messageid:int;
		private var _authorid:int;
		private var _recipientid:int;
		private var _body:String;
		private var _created:Date;
		private var _isNew:Boolean;
		
		public function Message( messageid:int = 0, authorid:int = 0, recipientid:int = 0,
								 body:String = "", created:Date = null, isNew:Boolean = false ){
			_messageid = messageid;
			_authorid = authorid;
			_recipientid = recipientid;
			_body = body;
			_created = created;
			_isNew = isNew;
		}
		
		public function get messageid():int{
			return _messageid;
		}
		
		public function get authorid():int{
			return _authorid;
		}
		
		public function set authorid( value:int ):void{
			_authorid = value;
		}
		
		public function get recipientid():int{
			return _recipientid;
		}
		
		public function set recipientid( value:int ):void{
			_recipientid = value;
		}
		
		public function get body():String{
			return _body;
		}
		
		public function set body( value:String ):void{
			_body = body;
		}
		
		public function get created():Date{
			return _created;
		}
		
		public function set created( value:Date ):void{
			_created = value;
		}
		
		public function get isNew():Boolean{
			return _isNew;
		}
		
		public function set isNew( value:Boolean ):void{
			_isNew = value;
		}
		
	}
}
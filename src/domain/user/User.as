package domain.user
{
	import domain.image.Image;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	
	public class User implements IDomainObject
	{
		
		private var _userId:int;
		private var _username:String;
		private var _nullPassword:Boolean;
		private var _memo:String;
		private var _site:String;
		private var _unit:String;
		private var _passwords:ArrayCollection;
		
		private var _firstName:String;
		private var _lastName:String;
		
		public function User( username:String, userId:int = 0, nullPassword:Boolean = true, memo:String = "", firstName:String = "", lastName:String = "" ){
			_username = username;
			_userId = userId;
			_nullPassword = nullPassword;
			_memo = memo;
			_site = "";
			_unit = "";
			_passwords = new ArrayCollection();
			
			_firstName = firstName;
			_lastName = lastName;
		}
		
		public function get userId():int{
			return _userId;
		}
		
		public function get username():String{
			return _username;
		}
		
		public function get nullPassword():Boolean{
			return _nullPassword;
		}
		
		public function get memo():String{
			return _memo;
		}
		
		public function set site( s:String ):void{
			_site = s;
		}
		
		public function get site():String{
			return _site;
		}
		
		public function set unit( u:String ):void{
			_unit = u;
		}
		
		public function get unit():String{
			return _unit;
		}
		
		public function set passwords( arr:ArrayCollection ):void{
			_passwords = arr;
		}
		
		public function addPassword( image:Image ):void{
			_passwords.addItem( image );
		}
		
		public function get passwords():ArrayCollection{
			return _passwords;
		}
		
		public function set firstName( value:String ):void{
			_firstName = value;
		}
		
		public function get firstName():String{
			return _firstName;
		}
		
		public function set lastName( value:String ):void{
			_lastName = value;
		}
		
		public function get lastName():String{
			return _lastName;
		}
		
		public function get fullName():String{
			return _firstName + " " + _lastName;
		}
	}
}
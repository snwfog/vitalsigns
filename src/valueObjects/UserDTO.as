/**
 * This is a generated sub-class of _UserDTO.as and is intended for behavior
 * customization.  This class is only generated when there is no file already present
 * at its target location.  Thus custom behavior that you add here will survive regeneration
 * of the super-class. 
 *
 * NOTE: Do not manually modify the RemoteClass mapping unless
 * your server representation of this class has changed and you've 
 * updated your ActionScriptGeneration,RemoteClass annotation on the
 * corresponding entity 
 **/ 

package valueObjects
{
	import com.adobe.fiber.core.model_internal;
	
	import domain.DTO.IDataTransferObject;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.ImageDTO;
	
	public class UserDTO extends _Super_UserDTO implements IDataTransferObject
	{
		private var _passwords:ArrayCollection = new ArrayCollection();
		private var _imageCategory:String = "";
		private var _site:String;
		private var _unit:String;
		
		public function get unit():String
		{
			return _unit;
		}

		public function set unit(value:String):void
		{
			_unit = value;
		}
		
		public function get site():String{
			return _site;
		}
		
		public function set site( value:String ):void{
			_site = value;
		}

		public function get imageCategory():String
		{
			return _imageCategory;
		}
		
		public function set imageCategory(value:String):void
		{
			_imageCategory = value;
		}
		
		public function set passwords(value:ArrayCollection):void
		{
			_passwords = value;
		}
		
		public function get passwords():ArrayCollection
		{
			return _passwords;
		}
		
		public function putPassword(pass:ImageDTO):Boolean{
			if(_passwords.length<=1){
				this._passwords.addItem(pass);
				return true;
			}else{
				return false;
			}
		}
		
		public function getPassword(index:int=-1):ImageDTO{
			if(_passwords.length==0){
				return null;
			}else{
				if(index==-1){
					return _passwords.getItemAt(_passwords.length-1) as ImageDTO;
				}else{
					if(_passwords.length < index+1){
						return null;
					}else{
						return _passwords.getItemAt(index) as ImageDTO;
					}
				}
			}
		}
		
		public function removePassword(pass:ImageDTO):void{
			if( _passwords.length>0 && _passwords.getItemAt(_passwords.length-1).imageId == pass.imageId){
				_passwords.removeItemAt(_passwords.length-1);
			}
		}
		
		/** 
		 * DO NOT MODIFY THIS STATIC INITIALIZER - IT IS NECESSARY
		 * FOR PROPERLY SETTING UP THE REMOTE CLASS ALIAS FOR THIS CLASS
		 *
		 **/
		
		/**
		 * Calling this static function will initialize RemoteClass aliases
		 * for this value object as well as all of the value objects corresponding
		 * to entities associated to this value object's entity.  
		 */     
		public static function _initRemoteClassAlias() : void
		{
			_Super_UserDTO.model_internal::initRemoteClassAliasSingle(valueObjects.UserDTO);
			_Super_UserDTO.model_internal::initRemoteClassAliasAllRelated();
		}
		
		model_internal static function initRemoteClassAliasSingleChild() : void
		{
			_Super_UserDTO.model_internal::initRemoteClassAliasSingle(valueObjects.UserDTO);
		}
		
		{
			_Super_UserDTO.model_internal::initRemoteClassAliasSingle(valueObjects.UserDTO);
		}
		/** 
		 * END OF DO NOT MODIFY SECTION
		 *
		 **/    
	}
	
}
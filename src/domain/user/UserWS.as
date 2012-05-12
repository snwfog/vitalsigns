package domain.user
{
	import domain.wrapper.WrapperWS;
	
	import mx.collections.ArrayCollection;
	
	import services.VitalSignService;
	
	import valueObjects.ImageDTO;
	import valueObjects.UserDTO;
	
	public class UserWS extends WrapperWS
	{
		public function UserWS( resultCallback:Function, faultCallback:Function ){
			super( resultCallback, faultCallback );
		}
		
		public function GetUserByUsername( username:String ):void{
			addCallback( VitalSignService.instance.GetUserByUsername( username ) );
		}
		
		public function getUserVerifyPassword( user:UserDTO ):void{
			
			var images:ArrayCollection = user.passwords;
			var imageId1:int = ( images.getItemAt( 0 ) as ImageDTO ).imageId;
			var imageId2:int = ( images.getItemAt( 1 ) as ImageDTO ).imageId;
			
			addCallback( VitalSignService.instance.getUserVerifyPassword( user.username, imageId2, imageId1 ) );
		}
		
		public function registerUser( user:UserDTO ):void{
			
			var username:String = user.username;
			var images:ArrayCollection = user.passwords;
			var imageId1:int = ( images.getItemAt( 0 ) as ImageDTO ).imageId;
			var imageId2:int = ( images.getItemAt( 1 ) as ImageDTO ).imageId;
			
			VitalSignService.instance.RegisterUser( username, imageId2, imageId1 );
		}
		
		public function getOtherUsersInUnit( user:UserDTO ):void{
			addCallback( VitalSignService.instance.getUsersInUnit( user.username, user.site, user.unit ) );
		}
	}
}
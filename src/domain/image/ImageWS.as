package domain.image
{
	import domain.wrapper.WrapperWS;
	
	import services.VitalSignService;
	
	public class ImageWS extends WrapperWS
	{
		public function ImageWS( resultCallback:Function, faultCallback:Function ){
			super( resultCallback, faultCallback );
		}
		
		public function GetUserImageChallenge( username:String ):void{
			addCallback( VitalSignService.instance.getUserImageChallenge( username ) );
		}
		
		public function getImagesByCategory( category:String ):void{
			addCallback( VitalSignService.instance.getImagesByCategory( category ) );
		}
		
		public function getImageCategories():void{
			addCallback( VitalSignService.instance.getImagesCategories() );
		}
	}
}
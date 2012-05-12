package domain.image
{
	import flash.utils.ByteArray;

	public class ImageFactory
	{
		public static function createImageFromByteArray(rawImage:ByteArray):Image {
			var image:Image = new Image();
			image.image = rawImage;
			return image;
		}
	}
}
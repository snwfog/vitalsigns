package application.controller
{
	public class ImagePasswordFunctions
	{
		private var _iColumns:int;
		private var _iRemainingPixels:int;
		
		private var iWidth:int = VitalSigns.iImageWidth;
		
		public function get iColumns():int{
			return _iColumns;
		}
		
		public function get iRemainingPixels():int{
			return _iRemainingPixels;
		}
		
		public function ImagePasswordFunctions(){}
		
		public function calculateOrientationVars( x:int, y:int, paddingLeft:int, paddingRight:int ):void{
			x = x - paddingLeft - paddingRight; // available width (minus padding)
			_iColumns = Math.floor( x / iWidth ); // get # of full columns for images
			_iColumns = _iColumns > VitalSigns.iMaxColumns ? VitalSigns.iMaxColumns : _iColumns; // retstrict to iMaxColumns if over
			_iRemainingPixels = x - ( _iColumns * iWidth ); // get remaining pixels not used by the columns
		}
		
	}
}
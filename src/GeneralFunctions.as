package
{
	import mx.collections.ArrayCollection;

	public class GeneralFunctions
	{
		public function GeneralFunctions(){}
		
		public static function flattenList( array:ArrayCollection, delimiter:String = "," ):String{			
			if( array.length == 0 )
				return "";
			
			var joined:String = "";
			var lastIndex:Number = array.length - 1;
			
			for( var i:int = 0; i < lastIndex; i++ )
				joined += array.getItemAt( i ) + delimiter;
			
			return joined + array.getItemAt( lastIndex );
		}
	}
}
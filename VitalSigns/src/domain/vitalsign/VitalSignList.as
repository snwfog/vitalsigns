package domain.vitalsign
{
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class VitalSignList implements IDomainObject
	{
		
		private var _type:String;
		private var _list:ArrayCollection;
		
		public function VitalSignList( type:String ){
			_type = type;
			_list = new ArrayCollection();
		}
		
		public function set type( value:String ):void{
			_type = type;
		}
		
		public function get type():String{
			return _type;
		}
		
		public function set list( value:ArrayCollection ):void{
			_list = list;
		}
		
		public function get list():ArrayCollection{
			return _list;
		}
	}
}
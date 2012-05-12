package domain.lab
{
	import domain.model.IDomainObject;
	[Bindable]
	public class LabList implements IDomainObject
	{
		private var _collectedDate : Date;
		private var _encounterID : Number;
		private var _fillerNumber : String;
		private var _genLabType : String;
		private var _pid : Number;
		private var _rangeIndicator : String;
		private var _rangeReference : String;
		private var _result : String;
		private var _resultDate : Date;
		private var _resultUnit : String;
		private var _servTypeChildAcro : String;
		private var _servTypeChildLongDesc : String;
		private var _servTypeRootAcro : String;
		private var _sid : Number;
		private var _sortChildSeq : String;
		private var _state : String;
		
		public function LabList()
		{
		}
		
		public function get collectedDate():Date{
			return _collectedDate;
		}
		
		public function set collectedDate( value:Date ):void{
			_collectedDate = value;
		}
		
		public function get encounterID():Number{
			return _encounterID;
		}
		
		public function set encounterID( value:Number ):void{
			_encounterID = value;
		}
		
		public function get fillerNumber():String{
			return _fillerNumber;
		}
		
		public function set fillerNumber( value:String ):void{
			_fillerNumber = value; 
		}
		
		public function get genLabType():String{
			return _genLabType;
		}
		
		public function set genLabType( value:String ):void{
			_genLabType = value;
		}
		
		public function get rangeIndicator():String{
			return _rangeIndicator;
		}
		
		public function set rangeIndicator( value:String ):void{
			_rangeIndicator = value;
		}
		
		public function get rangeReference():String{
			return _rangeReference;
		}
		
		public function set rangeReference( value:String ):void{
			_rangeReference = value;
		}
		
		public function get result():String{
			return _result;
		}
		
		public function set result( value:String ):void{
			_result = value;
		}
		
		public function get resultDate():Date{
			return _resultDate;
		}
		
		public function set resultDate( value:Date ):void{
			_resultDate = value;
		}
		
		public function get resultUnit():String{
			return _resultUnit;
		}
		
		public function set resultUnit( value:String ):void{
			_resultUnit = value;
		}
		
		public function get pid():Number{
			return _pid;
		}
		
		public function set pid( value:Number ):void{
			_pid = value;
		}
		
		public function get servTypeChildAcro():String{
			return _servTypeChildAcro;
		}
		
		public function set servTypeChildAcro( value:String ):void{
			_servTypeChildAcro = value;
		}
		
		public function get servTypeChildLongDesc():String{
			return _servTypeChildLongDesc;
		}
		
		public function set servTypeChildLongDesc( value:String ):void{
			_servTypeChildLongDesc = value; 
		}
		
		public function get servTypeRootAcro():String{
			return _servTypeRootAcro;
		}
		
		public function set servTypeRootAcro( value:String ):void{
			_servTypeRootAcro = value;
		}
		
		public function get sid():Number{
			return _sid;
		}
		
		public function set sid( value:Number ):void{
			_sid = value;
		}
		
		public function get sortChildSeq():String{
			return _sortChildSeq;
		}
		
		public function set sortChildSeq( value:String ):void{
			_sortChildSeq = value;
		}
		
		public function get state():String{
			return _state;
		}
		
		public function set state( value:String ):void{
			_state = value;
		}
	}
}
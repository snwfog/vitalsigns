package domain.patient
{
	import domain.model.IDomainObject;
	
	[Bindable]
	public class Patient implements IDomainObject
	{
		private var _address:String;
		private var _bed:String;
		private var _birthDate:Date;
		private var _city:String;
		private var _doctor:String;
		private var _doctorTel:String;
		private var _enFillerNum:String;
		private var _encounterId:Number;
		private var _extAppId:String;
		private var _firstName:String;
		private var _height:Number;
		private var _heightUnit:String;
		private var _lastName:String;
		private var _mrn:String;
		private var _nursingUnit:String;
		private var _patientId:Number;
		private var _postalCode:String;
		private var _province:String;
		private var _readOnly:Boolean;
		private var _sexCd:String;
		private var _weight:Number;
		private var _weightUnit:String;
		private var _room:String;
		
		
		public function Patient(){}
		/*public function Patient( address:String, bed:String, birthDate:Date, city:String,
								 doctor:String, doctorTel:String, enFillerNum:String, encounterId:Number,
								 extAppId:String, firstName:String, height:Number, heightUnit:String, lastName:String,
								 mrn:String, nursingUnit:String, patientId:Number, postalCode:String, province:String,
								 readOnly:Boolean, sexCd:String, weight:Number, weightUnit:String, room:String ){
			
			var roomBed:Array = bed.split( "-" );

			_address = address;
			_bed = roomBed[ 1 ];
			_birthDate = birthDate;
			_city = city;
			_doctor = doctor;
			_doctorTel = doctorTel;
			_encounterId = encounterId;
			_enFillerNum = enFillerNum;
			_extAppId = extAppId;
			_firstName = firstName;
			_height = height;;
			_heightUnit = heightUnit;
			_lastName = lastName;
			_mrn = mrn;
			_nursingUnit = nursingUnit;
			_patientId = patientId;
			_postalCode = postalCode;
			_province = province;
			_readOnly = readOnly;
			_sexCd = sexCd;
			_weight = weight;
			_weightUnit = weightUnit;
			_room = roomBed[ 0 ];
		}*/
		
		public function get address():String{
			return _address;
		}

		public function set address( value:String ):void{
			_address = value;
		}

		public function get bed():String{
			return _bed;
		}

		public function set bed( value:String ):void{
			_bed = value;
		}

		public function get birthDate():Date{
			return _birthDate;
		}

		public function set birthDate( value:Date ):void{
			_birthDate = value;
		}

		public function get city():String{
			return _city;
		}

		public function set city( value:String ):void{
			_city = value;
		}

		public function get doctor():String{
			return _doctor;
		}

		public function set doctor( value:String ):void{
			_doctor = value;
		}

		public function get doctorTel():String{
			return _doctorTel;
		}

		public function set doctorTel( value:String ):void{
			_doctorTel = value;
		}

		public function get enFillerNum():String{
			return _enFillerNum;
		}

		public function set enFillerNum( value:String ):void{
			_enFillerNum = value;
		}

		public function get encounterId():Number{
			return _encounterId;
		}

		public function set encounterId( value:Number ):void{
			_encounterId = value;
		}

		public function get extAppId():String{
			return _extAppId;
		}

		public function set extAppId( value:String ):void{
			_extAppId = value;
		}

		public function get firstName():String{
			return _firstName;
		}

		public function set firstName( value:String ):void{
			_firstName = value;
		}

		public function get height():Number{
			return _height;
		}

		public function set height( value:Number ):void{
			_height = value;
		}

		public function get heightUnit():String{
			return _heightUnit;
		}

		public function set heightUnit( value:String ):void{
			_heightUnit = value;
		}

		public function get lastName():String{
			return _lastName;
		}

		public function set lastName( value:String ):void{
			_lastName = value;
		}

		public function get mrn():String{
			return _mrn;
		}

		public function set mrn( value:String ):void{
			_mrn = value;
		}

		public function get nursingUnit():String{
			return _nursingUnit;
		}

		public function set nursingUnit( value:String ):void{
			_nursingUnit = value;
		}

		public function get patientId():Number{
			return _patientId;
		}

		public function set patientId( value:Number ):void{
			_patientId = value;
		}

		public function get postalCode():String{
			return _postalCode;
		}

		public function set postalCode( value:String ):void{
			_postalCode = value;
		}

		public function get province():String{
			return _province;
		}

		public function set province( value:String ):void{
			_province = value;
		}

		public function get readOnly():Boolean{
			return _readOnly;
		}

		public function set readOnly( value:Boolean ):void{
			_readOnly = value;
		}

		public function get sexCd():String{
			return _sexCd;
		}

		public function set sexCd( value:String ):void{
			_sexCd = value;
		}

		public function get weight():Number{
			return _weight;
		}

		public function set weight( value:Number ):void{
			_weight = value;
		}

		public function get weightUnit():String{
			return _weightUnit;
		}

		public function set weightUnit( value:String ):void{
			_weightUnit = value;
		}

		public function get room():String{
			return _room;
		}

		public function set room( value:String ):void{
			_room = value;
		}


	}
}
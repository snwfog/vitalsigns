package model
{
	import mx.collections.ArrayCollection;
	
	import valueObjects.UserDTO;

	public class PatientListTransferModel
	{
		private var _patients:ArrayCollection;
		private var _loginUser:UserDTO;
		public function PatientListTransferModel()
		{	
		}

		public function get loginUser():UserDTO
		{
			return _loginUser;
		}

		public function set loginUser(value:UserDTO):void
		{
			_loginUser = value;
		}

		public function get patients():ArrayCollection
		{
			return _patients;
		}

		public function set patients(value:ArrayCollection):void
		{
			_patients = value;
		}


	}
}
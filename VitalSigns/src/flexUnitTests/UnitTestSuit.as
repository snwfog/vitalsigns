package flexUnitTests
{
	import flexUnitTests.tests.*;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class UnitTestSuit
	{
		public var test1:ConversationAssemblerUnitTest;
		public var test2:LabListAssemblerUnitTest;
		public var test3:MessageAssemblerUnitTest;
		public var test4:NoteAssemblerUnitTest;
		public var test5:PatientAssemblerUnitTest;
		public var test6:UserAssemblerUnitTest;
		public var test7:ImageAssemblerUnitTest;
		public var test8:ImageFactoryUnitTest;
		
	}
}
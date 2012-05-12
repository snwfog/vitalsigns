package flexUnitTests.tests
{
	import domain.DTO.IDataTransferObject;
	import domain.lab.LabList;
	import domain.lab.LabListAssembler;
	import domain.model.IDomainObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import org.flexunit.Assert;
	import org.hamcrest.mxml.object.InstanceOf;
	
	import valueObjects.LabListDTO;
	
	public class LabListAssemblerUnitTest
	{
		
		private var lab:LabListDTO;
		private var labListAssembler:LabListAssembler;
		private var labArrayCollection : ArrayCollection;
		
		[Before]	
		public function setUp():void{
			labArrayCollection = new ArrayCollection;
			labListAssembler = new LabListAssembler;
			
			this.lab = new LabListDTO();
			
			this.lab.pid = 1;
			this.lab.encounterID = 1;
			this.lab.collectedDate = new Date(2012,1,1,2,3,45);
			this.lab.fillerNumber = "32";
			this.lab.genLabType = "blood";
			this.lab.rangeIndicator = "21-30";
			this.lab.rangeReference = "L";
			this.lab.result = "160";
			this.lab.resultDate = new Date();
			this.lab.resultUnit = "mmg";
			this.lab.servTypeChildAcro = "GLU";
			this.lab.servTypeChildLongDesc = "GLU";
			this.lab.servTypeRootAcro = "GLU";
			this.lab.sid = 3;
			this.lab.sortChildSeq = "2";
			this.lab.state = "stable";
			
			for(var i:int = 0; i <= 3; i++){
				labArrayCollection.addItem(lab);
			}
			
			
		}
		
		[After]
		public function tearDown():void{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function createDomainObjectTest():void{
			var object:LabList = new LabList(); 
			
			object = labListAssembler.createDomainObject(this.lab) as LabList;
			Assert.assertEquals( object.collectedDate.toString(), this.lab.collectedDate.toString() );
			Assert.assertEquals( object.encounterID, this.lab.encounterID );
			Assert.assertEquals( object.fillerNumber, this.lab.fillerNumber );
			Assert.assertEquals( object.genLabType, this.lab.genLabType );
			Assert.assertEquals( object.pid, this.lab.pid );
			Assert.assertEquals( object.rangeIndicator, this.lab.rangeIndicator );
			Assert.assertEquals( object.rangeReference, this.lab.rangeReference );
			Assert.assertEquals( object.result, this.lab.result );
			Assert.assertEquals( object.resultDate.toString(), this.lab.resultDate.toString() );
			Assert.assertEquals( object.resultUnit, this.lab.resultUnit );
			Assert.assertEquals( object.servTypeChildAcro, this.lab.servTypeChildAcro );
			Assert.assertEquals( object.servTypeChildLongDesc, this.lab.servTypeChildLongDesc );
			Assert.assertEquals( object.servTypeRootAcro, this.lab.servTypeRootAcro );
			Assert.assertEquals( object.sid, this.lab.sid );
			Assert.assertEquals( object.sortChildSeq, this.lab.sortChildSeq );
			Assert.assertEquals( object.state, this.lab.state );
		}
		
		[Test]
		public function buildDTOFromObjectProxyTest():void{
			var objProxy : ObjectProxy = new ObjectProxy(this.lab);
			var object:LabListDTO = new LabListDTO();
			object = labListAssembler.buildDTOFromObjectProxy(objProxy) as LabListDTO;
			
			Assert.assertEquals( object.collectedDate.toString(), this.lab.collectedDate.toString() );
			Assert.assertEquals( object.encounterID, this.lab.encounterID );
			Assert.assertEquals( object.fillerNumber, this.lab.fillerNumber );
			Assert.assertEquals( object.genLabType, this.lab.genLabType );
			Assert.assertEquals( object.pid, this.lab.pid );
			Assert.assertEquals( object.rangeIndicator, this.lab.rangeIndicator );
			Assert.assertEquals( object.rangeReference, this.lab.rangeReference );
			Assert.assertEquals( object.result, this.lab.result );
			Assert.assertEquals( object.resultDate.toString(), this.lab.resultDate.toString() );
			Assert.assertEquals( object.resultUnit, this.lab.resultUnit );
			Assert.assertEquals( object.servTypeChildAcro, this.lab.servTypeChildAcro );
			Assert.assertEquals( object.servTypeChildLongDesc, this.lab.servTypeChildLongDesc );
			Assert.assertEquals( object.servTypeRootAcro, this.lab.servTypeRootAcro );
			Assert.assertEquals( object.sid, this.lab.sid );
			Assert.assertEquals( object.sortChildSeq, this.lab.sortChildSeq );
			Assert.assertEquals( object.state, this.lab.state );
			
		}
		
		[Test]
		public function createDOArrayTest():void{
			var object:ArrayCollection = labListAssembler.createDOArray(labArrayCollection);
			Assert.assertNotNull(object);
			Assert.assertEquals(object.length, labArrayCollection.length);
			for(var i:int = 0; i < object.length; i++){
				Assert.assertTrue( object[i] is LabList );
			}
		}
		
	}
}
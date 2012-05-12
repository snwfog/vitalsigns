package application.controller
{
	import application.component.ImageView;
	
	import flash.display.Loader;
	import flash.display.StageOrientation;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.events.TransformGestureEvent;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.HGroup;
	import spark.components.Image;
	import spark.components.List;
	import spark.components.VGroup;
	import spark.components.View;
	import spark.events.IndexChangeEvent;
	import spark.primitives.BitmapImage;
	
	public class ResourcesController extends View
	{
		public function ResourcesController(){super();}
		
		[Bindable]
		protected var imageCollection : ArrayCollection = new ArrayCollection([
			{name:"Translation",short:"Translation",url:"application/asset/resources/0.jpg"},
			{name:"Protocol-Treatment Hypoglycemia I",short:"Protocol-I",url:"application/asset/resources/1.jpg"},
			{name:"Protocol-Treatment Hypoglycemia II", short:"Protocol-II" , url:"application/asset/resources/2.jpg"},
			{name:"Central Venous Access Device I",  short:"CVAD-I" ,url:"application/asset/resources/3.jpg"},
			{name:"Central Venous Access Device II",  short:"CVAD-II" ,url:"application/asset/resources/4.jpg"},
			{name:"Epidural Pump",  short:"Epidural Pump", url:"application/asset/resources/5.jpg"},
			{name:"Wound Bed I",  short:"Wound Bed I", url:"application/asset/resources/6.jpg"},
			{name:"Wound Bed II",  short:"Wound Bed II" ,url:"application/asset/resources/7.jpg"},
			{name:"Pressure Ulcer Staging (Level 1 & Level 2)",  short:"Ulcer Staging I & II" ,url:"application/asset/resources/8.jpg"},
			{name:"Pressure Ulcer Staging (Level 3 & Level 4)",  short:"Ulcer Staging III & IV", url:"application/asset/resources/9.jpg"},
			{name:"Peri Wound",  short:"Peri Wound" ,url:"application/asset/resources/10.jpg"}]);
		[Bindable]
		protected var imageViewer : ImageView = new ImageView();
		
		public var ui:UIComponent = new UIComponent();
		public var vgroup:VGroup = new VGroup();
		public var hgroup:HGroup = new HGroup();
		[Bindable]public var list:List = new List()
		
		protected var loader : Loader = new Loader();
		
		protected function view1_creationCompleteHandler(event:FlexEvent):void
		{
			VitalSigns.registerOrientationChangeListener( resize );
			var url : URLRequest = new URLRequest("application/asset/resources/0.jpg");
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(url);
			
			imageViewer.setSize(stage.width, stage.height);
			
			ui.addChild(imageViewer);
			
			resize(stage.width, stage.height);
		}
		
		protected function resize(x:int, y:int):void
		{
			if (x > y)
			{
				if (vgroup == list.owner)
					vgroup.removeElement(list);
				list.width = x*0.3;
				list.height = y;
				ui.width = x*0.7;
				ui.height = y;
				hgroup.addElement(list);
			}
			else 
			{
				if (hgroup == list.owner)
					hgroup.removeElement(list);
				list.width = x;
				list.height = y*0.3;
				ui.width = x;
				ui.height = y*0.7;
				vgroup.addElement(list);
			}
			imageViewer.setSize(ui.width, ui.height);
		}
		
		protected function onComplete(event:Event):void
		{
			imageViewer.setImage(event.target.content.bitmapData);
		}
		
		protected function list1_changeHandler(event:IndexChangeEvent):void
		{
			loader.load(new URLRequest(imageCollection.getItemAt(event.newIndex).url));
			imageViewer.setSize(ui.width, ui.height);
		}
		
		protected function backButton_clickHandler(event:MouseEvent):void
		{
			navigator.popView();
		}
	}
}
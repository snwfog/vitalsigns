package application.controller.AccountRegistration
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Accordion;
	import mx.core.Container;
	
	import spark.components.View;
	
	public class ImageCategoriesAccordionController extends Accordion
	{
		public function ImageCategoriesAccordionController()
		{
			super();
		}
		
		/**
		 * Property that holds the icon Class that will show when 
		 * the Accordion pane is above the selected pane
		 * 
		 * formats: gif,png,jpg 
		 * 
		 * @default upIcon.gif
		 */	
		public var upIcon:Class;
		public var downIcon:Class;
		public var selectedIcon:Class;
		
		private var defaultWidth:int = 400;
		private var defaultHeight:int = 300;
		private var index:int = 0;
		
		public function get currentIndex():int{
			return index;
		}
		
		
		//The childrenCreated method is overridden to initialize the icons and add the CHANGE EventListener.
		override protected function childrenCreated():void
		{
			//this.addEventListener(Event.CHANGE,changed);
		}
		
		// The changed function is called when the Accordion changes state
		public function changed(event:Event):void
		{			
			setIcons(event.target.selectedIndex);
		}
		
		//Assigns each pane the with either the upIcon, downIcon, or selectedIcon
		public function setIcons( selectedIndex:int ):void
		{
			index = selectedIndex;
			var currentIndex:int = 0;
			for( ; currentIndex < selectedIndex; currentIndex++ )
				Container( this.getChildAt( currentIndex ) ).icon = downIcon;
			
			Container( this.getChildAt( currentIndex ) ).icon = selectedIcon;
			
			for( currentIndex = selectedIndex + 1; currentIndex < this.numChildren; currentIndex++ )
				Container( this.getChildAt( currentIndex ) ).icon = upIcon;
			
		}
	}
}
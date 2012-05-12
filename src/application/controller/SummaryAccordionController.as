package application.controller
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Accordion;
	import mx.core.Container;
	
	import spark.components.View;
	
	/**
	 *  <p>The AccordionIcons component extends Accordion and 
	 *  allows for icons to be assigned to each pane</p>
	 *
	 *  <p>The icons will be automatically assigned to the appropriate pane each time
	 *  the state of the Accordion changes.</p>
	 */
	public class SummaryAccordionController extends Accordion
	{
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
				
		public function SummaryAccordionController(){
			super();
		} 
		
		
		//The childrenCreated method is overridden to initialize the icons and add the CHANGE EventListener.
		override protected function childrenCreated():void
		{
			setIcons(this.selectedIndex);
			this.addEventListener(Event.CHANGE,changed);
		}
		
		// The changed function is called when the Accordion changes state
		private function changed(event:Event):void
		{			
			setIcons(event.target.selectedIndex);
		}
		
		//Assigns each pane the with either the upIcon, downIcon, or selectedIcon
		private function setIcons(selectedIndex:int):void
		{			
			for(var i:int=0; i<this.numChildren; i++)
			{
				if(i>=selectedIndex){
					// if pane is above selectedIndex, set with upIcon
					Container(this.getChildAt(i)).icon = upIcon;
				} else {
					// if pane is above selectedIndex, set with downIcon
					Container(this.getChildAt(i)).icon = downIcon;
				}
			}
			// set the selectedIcon to the selected pane
			Container(this.getChildAt(selectedIndex)).icon = selectedIcon;
		}
	}
}
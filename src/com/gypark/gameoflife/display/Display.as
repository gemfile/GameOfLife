package com.gypark.gameoflife.display 
{
	import com.gypark.gameoflife.display.layer.CellLayer;
	import com.gypark.gameoflife.display.layer.GUILayer;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author gypark
	 */
	public final class Display extends Sprite
	{
		public static const INSTANCE:Display = new Display();
		public const cellLayer:CellLayer = CellLayer.INSTANCE;
		public const guiLayer:GUILayer = GUILayer.INSTANCE;
		
		public function Display() 
		{
			if(INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			init();
		}
		
		private function init():void 
		{
			addChild(cellLayer);
			addChild(guiLayer);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			cellLayer.x = (stage.stageWidth - width) / 2;
			cellLayer.y = (stage.stageHeight - height) / 2;
			guiLayer.x = 80;
			guiLayer.y = 20;
		}
	}
}
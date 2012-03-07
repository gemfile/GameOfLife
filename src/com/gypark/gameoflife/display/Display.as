package com.gypark.gameoflife.display 
{
	import com.gypark.gameoflife.display.layer.DataDisplayLayer;
	import com.gypark.gameoflife.display.layer.InteractionLayer;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author gypark
	 */
	public final class Display extends Sprite
	{
		public static const INSTANCE:Display = new Display();
		public const interactionLayer:InteractionLayer = InteractionLayer.INSTANCE;
		public const dataDisplayLayer:DataDisplayLayer = DataDisplayLayer.INSTANCE;
		
		public function Display() 
		{
			if(INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			init();
			
		}
		
		private function init():void 
		{
			addChild(interactionLayer);
			addChild(dataDisplayLayer);
		}
	}
}
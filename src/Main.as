package 
{
	import com.gypark.gameoflife.display.Display;
	import com.gypark.gameoflife.game.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author gypark
	 */
	[SWF(width='400', height='400')]
	public class Main extends Sprite 
	{
		private var game:Game = Game.INSTANCE;
		private var display:Display = Display.INSTANCE;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			setDisplay();
			setGame();
			setInitialState();
		}
		
		private function setInitialState():void
		{
			display.interactionLayer.onCellDataUpdate(
				game.makeCellList( [[0, 1, 0, 0, 0, 0, 0, 0, 0, 0], 
								    [0, 0, 1, 0, 0, 0, 0, 0, 0, 0], 
								    [1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
								    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
								    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
								    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
								    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
								    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
								    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
								    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]] 
				)
			);
		}
		
		private function setDisplay():void 
		{
			addChild(display);
			setCenter();
			display.interactionLayer.started.add(game.onStartButton);
			display.interactionLayer.started.add(display.dataDisplayLayer.onStartButton);
			
			function setCenter():void
			{
				display.x = (stage.stageWidth - display.width) / 2;
				display.y = (stage.stageHeight - display.height) / 2;
			}
		}
		
		private function setGame():void 
		{
			game.dataChanged.add(display.interactionLayer.onCellDataUpdate);
			game.dataChanged.add(display.dataDisplayLayer.onCellDataUpdate);
		}
	}
	
}
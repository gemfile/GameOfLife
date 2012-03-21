package
{
	import com.gypark.gameoflife.data.DataManager;
	import com.gypark.gameoflife.display.Display;
	import com.gypark.gameoflife.game.Game;
	import com.gypark.gameoflife.util.URL;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author gypark
	 */
	[SWF(width='760',height='760')]
	
	public class Main extends Sprite
	{
		private var game:Game = Game.INSTANCE;
		private var display:Display = Display.INSTANCE;
		private var data:DataManager = DataManager.INSTANCE;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			data.loaded.addOnce(onMapLoaded);
			data.loadMap();
			
			function onMapLoaded():void
			{
				setDisplay();
				setGame();
				setInitialState();
			}
		}
		
		private function setDisplay():void
		{
			addChild(display);
			setCenter();
			display.gui.started.add(game.onStartButton);
			 
			function setCenter():void
			{
				display.x = (stage.stageWidth - display.width) / 2;
				display.y = (stage.stageHeight - display.height) / 2;
			}
		}
		
		private function setInitialState():void
		{
			display.interactionLayer.onCellDataUpdate(data.mapDataMap[URL.URL_MAP_GLIDER]);
		}
		
		private function setGame():void
		{
			game.dataChanged.add(display.interactionLayer.onCellDataUpdate);
		}
	}

}
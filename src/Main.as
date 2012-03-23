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
			display.guiLayer.started.add(game.onStartButton);
			display.guiLayer.selected.add(display.cellLayer.onCellDataUpdate);
		}
		
		private function setInitialState():void
		{
			display.cellLayer.onCellDataUpdate(data.mapDataMap[URL.URL_MAP_GLIDER]);
		}
		
		private function setGame():void
		{
			game.dataChanged.add(display.cellLayer.onCellDataUpdate);
		}
	}

}
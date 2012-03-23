package com.gypark.gameoflife.data 
{
	import com.gypark.gameoflife.game.Game;
	import com.gypark.gameoflife.util.URL;
	import com.gypark.gameoflife.util.XMLLoader;
	import flash.events.Event;
	import mx.utils.StringUtil;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author gypark
	 */
	public class DataManager
	{
		public static const INSTANCE:DataManager = new DataManager();
		public var loaded:Signal = new Signal();
		public var mapDataMap:Array; // [][]
		
		private var mapURLList:Array;
		
		public function DataManager() 
		{
			if (INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			init();
		}
		
		public function loadMap():void
		{
			var mapURL:String = mapURLList.shift();
			XMLLoader.INSTANCE.loaded.addOnce(onLoadMap);
			XMLLoader.INSTANCE.load(mapURL);
			
			function onLoadMap(e:Event):void
			{
				var loadedData:XML = XML(e.target.data);
				var loadedDataList:XMLList = loadedData.children();
				var mapData:Array = String(loadedDataList[0]).split("\n");
				for (var index:String in mapData)
				{
					mapData[index] = String(mapData[index]).split("");
				}
				mapDataMap[mapURL] = Game.INSTANCE.makeCellList(mapData);
				
				if (mapURLList.length > 0) {
					loadMap();
				}
				else {
					loaded.dispatch();
				}
			}
		}
		
		private function init():void 
		{
			mapDataMap = [];
			mapURLList = [
				URL.URL_MAP_CLEAR, 
				URL.URL_MAP_GLIDER, 
				URL.URL_MAP_SMALL_EXPLODER,
				URL.URL_MAP_EXPLODER,
				URL.URL_MAP_TEN_CELL_ROW,
				URL.URL_MAP_LIGHTWEIGHT_SPACESHIP,
				URL.URL_MAP_TUMBLER,
				URL.URL_MAP_GOSPER_GLIDER_GUN
			];
		}
	}

}
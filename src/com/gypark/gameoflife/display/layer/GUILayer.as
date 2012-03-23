package com.gypark.gameoflife.display.layer 
{
	import com.bit101.components.ComboBox;
	import com.bit101.components.Component;
	import com.bit101.components.PushButton;
	import com.gypark.gameoflife.data.DataManager;
	import com.gypark.gameoflife.util.URL;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author gypark
	 */
	public class GUILayer extends Sprite 
	{
		public static const INSTANCE:GUILayer = new GUILayer();
		public const started:Signal = new Signal(Boolean);
		public const selected:Signal = new Signal(Array);
		
		public function GUILayer() 
		{
			if (INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			init();
		}
		
		public function onLoopBoxSelect(event:Event):void
		{
			var loopBox:ComboBox = event.target as ComboBox;
			//onCellDataUpdate(loopBox.selectedItem.mapData);
			selected.dispatch(loopBox.selectedItem.mapData);
		}
		
		public function onStartButtonClick(event:MouseEvent):void
		{
			var startButton:PushButton = event.target as PushButton;
			startButton.selected = startButton.toggle = !startButton.toggle;
			
			if(startButton.toggle) {
				startButton.label = "Stop";
			}
			else {
				startButton.label = "Start";
			}
			
			started.dispatch(startButton.toggle);
		}
		
		private function init():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			function onAddedToStage(e:Event):void 
			{
				removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				
				arrangeComponent();
			}
		}
		
		private function arrangeComponent():void
		{
			Component.initStage(stage);
			var startButton:PushButton = new PushButton(this, 0, 0, "Start", onStartButtonClick);
			var data:DataManager = DataManager.INSTANCE;
			var loopBox:ComboBox = new ComboBox(this, 120, 0, "Glider");
			loopBox.addEventListener(Event.SELECT, onLoopBoxSelect);
			loopBox.addItem({label:"Clear"					,mapData:data.mapDataMap[URL.URL_MAP_CLEAR]});
			loopBox.addItem({label:"Glider"					,mapData:data.mapDataMap[URL.URL_MAP_GLIDER]});
			loopBox.addItem({label:"Small Expoder"			,mapData:data.mapDataMap[URL.URL_MAP_SMALL_EXPLODER]});
			loopBox.addItem({label:"Expolder"				,mapData:data.mapDataMap[URL.URL_MAP_EXPLODER]});
			loopBox.addItem({label:"10 Cell Row"			,mapData:data.mapDataMap[URL.URL_MAP_TEN_CELL_ROW]});
			loopBox.addItem({label:"Lightweight spaceship"	,mapData:data.mapDataMap[URL.URL_MAP_LIGHTWEIGHT_SPACESHIP]});
			loopBox.addItem({label:"Tumbler"				,mapData:data.mapDataMap[URL.URL_MAP_TUMBLER]});
			loopBox.addItem({label:"Gosper Glider Gun"		,mapData:data.mapDataMap[URL.URL_MAP_GOSPER_GLIDER_GUN]});
			
			addChild(startButton);
			addChild(loopBox);
		}
	}

}
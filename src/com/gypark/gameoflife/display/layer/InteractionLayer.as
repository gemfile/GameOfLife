package com.gypark.gameoflife.display.layer 
{
	import com.bit101.components.Component;
	import com.bit101.components.PushButton;
	import com.bit101.utils.MinimalConfigurator;
	import com.gypark.gameoflife.display.cell.CellSprite;
	import com.gypark.gameoflife.game.Game;
	import com.gypark.gameoflife.game.state.CellState;
	import com.gypark.gameoflife.game.unit.cell.ACell;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author gypark
	 */
	public final class InteractionLayer extends Sprite implements ICellDataReceiver
	{
		public static const INSTANCE:InteractionLayer = new InteractionLayer();
		public const started:Signal = new Signal();
		public var startButton:PushButton;
		private const cellSpriteLayer:Sprite = new Sprite();
		private var cellSpriteList:Array/*CellSprite*/;
		private var isTogglePossible:Boolean;
		
		public function InteractionLayer()
		{
			if(INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			init();
		}
			
		public function onStartButtonClick(event:MouseEvent):void
		{
			startButton.toggle = !startButton.toggle;
			startButton.selected = startButton.toggle;
			
			if(startButton.toggle) {
				startButton.label = "Stop";
				cellSpriteLayer.visible = false;
				started.dispatch(startButton.toggle, makingCellMap());
			}
			else {
				startButton.label = "Start";
				cellSpriteLayer.visible = true;
				started.dispatch(startButton.toggle, null);
			}
			
			function makingCellMap():Array
			{
				var cellMap:Array = [];
				var cellSprite:CellSprite;
				var game:Game = Game.INSTANCE;
				for(var j:int=0; j<game.HEIGHT; j++)
				{
					cellMap[j] = [];
					for(var i:int=0; i<game.WIDTH; i++)
					{
						cellSprite = cellSpriteList[j][i];
						cellMap[j][i] = (cellSprite.isToggleON) ? 1 : 0;
					}
				}
				return cellMap;
			}
		}
		
		public function onCellDataUpdate(cellList:Array/*ACell*/):void
		{
			var cell:ACell;
			var cellSprite:CellSprite;
			var game:Game = Game.INSTANCE;
			for(var i:int=0; i<game.WIDTH; i++)
			{
				for(var j:int=0; j<game.HEIGHT; j++)
				{
					cell = cellList[j][i];
					cellSprite = cellSpriteList[j][i];
					cellSprite.setState(cell.state);
				}
			}
		}
		
		private function init():void 
		{
			addChild(cellSpriteLayer);
			addEventListener(Event.ADDED_TO_STAGE, onStageInteractionLayer)
			cellSpriteLayer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			cellSpriteLayer.addEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
			cellSpriteLayer.addEventListener(MouseEvent.ROLL_OUT,  onMouseUp);
			
			arrangeCellSprite();
			
			function onStageInteractionLayer(e:Event):void {
				e.target.removeEventListener(e.type, arguments.callee);
				arrangeComponent();
			}
			
			function onMouseDown(e:MouseEvent):void
			{
				trace("onMouseDown");
				isTogglePossible = true;
			}
			
			function onMouseUp(e:MouseEvent):void
			{
				trace("onMouseUp");
				isTogglePossible = false;
			}
		}
		
		private function arrangeCellSprite():void 
		{
			cellSpriteList = [];
			var game:Game = Game.INSTANCE;
			var cellSprite:CellSprite;
			for(var j:int=0; j<game.HEIGHT; j++)
			{
				cellSpriteList[j] = [];
				for(var i:int=0; i<game.WIDTH; i++)
				{
					cellSprite = new CellSprite(CellState.SIZE_WIDTH, CellState.SIZE_HEIGHT);
					cellSpriteList[j][i] = cellSprite;
					cellSprite.x = i*CellState.SIZE_WIDTH  + i*CellState.SIZE_GAP;
					cellSprite.y = j*CellState.SIZE_HEIGHT + j*CellState.SIZE_GAP;
					cellSprite.downed.add(onClickCellSprite);
					cellSprite.overed.add(onOverCellSprite);
					cellSpriteLayer.addChild(cellSprite);
				}
			}
			
			var bgSprite:Sprite = new Sprite();
			bgSprite.graphics.beginFill
			bgSprite.graphics.beginFill(0x00ffffff);
			bgSprite.graphics.drawRect(0, 0, width, height);
			bgSprite.graphics.endFill();
			cellSpriteLayer.addChildAt(bgSprite, 0);
			
			function onClickCellSprite(e:MouseEvent):void 
			{
				var clickedCellSprite:CellSprite = e.target as CellSprite;
				clickedCellSprite.toggle();
			}
			
			function onOverCellSprite(e:MouseEvent):void
			{
				trace("overed : " + isTogglePossible);
				if(!isTogglePossible) {
					return;
				}
				
				var clickedCellSprite:CellSprite = e.target as CellSprite;
				clickedCellSprite.toggle();
			}
		}
		
		private function arrangeComponent():void
		{
			Component.initStage(stage);
 
			var xml:XML = <comps>
							<PushButton id="startButton" x="70" y="250" label="Start" event="click:onStartButtonClick"/>
						  </comps>;
 
			var config:MinimalConfigurator = new MinimalConfigurator(this);
			config.parseXML(xml);
		}
	}

}
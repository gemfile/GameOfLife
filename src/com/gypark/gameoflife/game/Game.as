package com.gypark.gameoflife.game 
{
	import com.gypark.gameoflife.display.layer.CellLayer;
	import com.gypark.gameoflife.game.rule.LiveRule;
	import com.gypark.gameoflife.game.rule.NeighborRule;
	import com.gypark.gameoflife.game.state.CellState;
	import com.gypark.gameoflife.game.unit.cell.ACell;
	import com.gypark.gameoflife.game.unit.cell.CellFactory;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author gypark
	 */
	public final class Game 
	{
		static public const INSTANCE:Game = new Game();
		public const WIDTH:int  = 50;
		public const HEIGHT:int = 50;
		public const dataChanged:Signal = new Signal();
		private var cellList:Array/*ACell*/;
		private var timer:Timer;
		
		public function Game()
		{
			if(INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			init();
		}
		
		public function init():void
		{
			addTimer();
			
			function addTimer():void 
			{
				timer = new Timer(500);
				timer.addEventListener(TimerEvent.TIMER, onTime);
			}
		}
		public function makeCellList(cellMap:Array/*Array*/):Array 
		{
			cellList = [];
			for(var j:int=0; j<HEIGHT; j++)
			{
				cellList[j] = [];
				for(var i:int=0; i<WIDTH; i++) {
					cellList[j][i] = CellFactory.INSTANCE.makeCell(cellMap[j][i]);
				}
			}
			
			return cellList;
		}
		
		public function onStartButton(isStarted:Boolean):void 
		{
			if(isStarted) {
				makeCellList(CellLayer.INSTANCE.makingCellMap());
				startTimer();
			}
			else {
				stopTimer();
			}
			
			function startTimer():void 
			{
				timer.start();
				dataChanged.dispatch(cellList);
			}
			
			function stopTimer():void
			{
				timer.stop();
				dataChanged.dispatch(cellList);
			}
		}
		
		/**
		 * GAME LOOP
		 */
		private function onTime(e:TimerEvent):void 
		{
			makeNeighborList_toEachCell();
			judgeLiveOrDie_toEachCell();
			updateNextGeneration_toEachCell();
			dataChanged.dispatch(cellList);
		}
		
		private function updateNextGeneration_toEachCell():void 
		{
			var cell:ACell;
			var nextCellState:int;
			for(var i:int=0; i<WIDTH; i++)
			{
				for(var j:int = 0; j < HEIGHT; j++) {
					cell = cellList[j][i];
					nextCellState = (cell.hasNextGeneration) ? CellState.STATE_LIVE : CellState.STATE_DEAD;
					if(cell.state != nextCellState) {
						cellList[j][i] = CellFactory.INSTANCE.makeCell(nextCellState);
					}
				}
			}
		}
		private function judgeLiveOrDie_toEachCell():void 
		{
			var liveRule:LiveRule = LiveRule.INSTANCE;
			for(var i:int=0; i<WIDTH; i++)
			{
				for(var j:int=0; j<HEIGHT; j++) {
					liveRule.judgeLiveOrDie(cellList[j][i]);
				}
			}
		}
		private function makeNeighborList_toEachCell():void 
		{
			var cell:ACell;
			for(var i:int=0; i<WIDTH; i++)
			{
				for(var j:int=0; j<HEIGHT; j++)
				{
					cell = cellList[j][i];
					cell.setNeighborList(makeNeighborList(j, i));
				}
			}
			
			function makeNeighborList(x:int, y:int):Array
			{
				var neighborRule:NeighborRule = NeighborRule.INSTANCE;
				neighborRule.setCellPoint(x, y, WIDTH, HEIGHT, cellList);
				return [neighborRule.getNeighborOn(NeighborRule.LEFT_TOP), 	  neighborRule.getNeighborOn(NeighborRule.CENTER_TOP), 	  neighborRule.getNeighborOn(NeighborRule.RIGHT_TOP),
						neighborRule.getNeighborOn(NeighborRule.LEFT_MIDDLE), 														  neighborRule.getNeighborOn(NeighborRule.RIGHT_MIDDLE),
						neighborRule.getNeighborOn(NeighborRule.LEFT_BOTTOM), neighborRule.getNeighborOn(NeighborRule.CENTER_BOTTOM), neighborRule.getNeighborOn(NeighborRule.RIGHT_BOTTOM)];
							
			}
		}
	}

}
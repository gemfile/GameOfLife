package com.gypark.gameoflife.display.layer 
{
	import com.gypark.gameoflife.game.Game;
	import com.gypark.gameoflife.game.state.CellState;
	import com.gypark.gameoflife.game.unit.cell.ACell;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gypark
	 */
	public final class DataDisplayLayer extends Sprite implements ICellDataReceiver
	{
		public static const INSTANCE:DataDisplayLayer = new DataDisplayLayer();
		
		public function DataDisplayLayer() 
		{
			if(INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
		}
		
		public function onCellDataUpdate(cellList:Array/*ACell*/):void
		{
			var cell:ACell;
			var game:Game = Game.INSTANCE;
			graphics.clear();
			for(var i:int=0; i<game.WIDTH; i++)
			{
				for(var j:int=0; j<game.HEIGHT; j++)
				{
					cell = cellList[j][i];
					graphics.lineStyle(1, 0xff000000);
					graphics.beginFill(cell.color);
					graphics.drawRect(i*CellState.SIZE_WIDTH+ i*CellState.SIZE_GAP, j*CellState.SIZE_HEIGHT + j*CellState.SIZE_GAP, CellState.SIZE_WIDTH, CellState.SIZE_HEIGHT);
					graphics.endFill();
				}
			}
		}
		
		public function onStartButton(isStarted:Boolean):void 
		{
			visible = isStarted;
		}
		
	}

}
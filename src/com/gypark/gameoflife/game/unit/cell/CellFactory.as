package com.gypark.gameoflife.game.unit.cell 
{
	import com.gypark.gameoflife.game.state.CellState;
	/**
	 * ...
	 * @author gypark
	 */
	public final class CellFactory 
	{
		public static const INSTANCE:CellFactory = new CellFactory();
		private var cellClassMap:Array/*Class*/;
		
		public function CellFactory()
		{
			if(INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			prepareCellClassMap();
		}
		
		private function prepareCellClassMap():void 
		{
			cellClassMap = [];
			cellClassMap[CellState.STATE_DEAD] = DeadCell;
			cellClassMap[CellState.STATE_LIVE] = LiveCell;
		}
		
		public function makeCell(cellState:int/*CellState*/):ACell
		{
			var CellClass:Class = cellClassMap[cellState];
			return new CellClass();
		}
	}

}
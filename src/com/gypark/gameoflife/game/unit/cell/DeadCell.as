package com.gypark.gameoflife.game.unit.cell 
{
	import com.gypark.gameoflife.game.state.CellState;
	/**
	 * ...
	 * @author gypark
	 */
	public final class DeadCell extends ACell
	{
		public function DeadCell() 
		{
			super(CellState.COLOR_DEAD, CellState.STATE_DEAD);
		}
		
	}

}
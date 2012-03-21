package com.gypark.gameoflife.game.unit.cell 
{
	import com.gypark.gameoflife.game.state.CellState;
	/**
	 * ...
	 * @author gypark
	 */
	public final class LiveCell extends ACell
	{
		public function LiveCell() 
		{
			super(CellState.COLOR_LIVE, CellState.STATE_LIVE);
		}
		
	}

}
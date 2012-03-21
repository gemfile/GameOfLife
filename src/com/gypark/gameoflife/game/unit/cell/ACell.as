package com.gypark.gameoflife.game.unit.cell 
{
	import com.gypark.gameoflife.game.state.CellState;
	/**
	 * ...
	 * @author gypark
	 */
	public class ACell implements ICell 
	{
		public var color:uint;
		public var state:int;
		public var hasNextGeneration:Boolean;
		protected var neighborList:Array/*ACell*/;
		
		public function ACell(color:uint, state:int)
		{ 
			this.state = state;
			this.color = color;
		}
		
		public function setNeighborList(neighborList:Array):void 
		{
			this.neighborList = neighborList;
		}
		
		public function isLive():Boolean
		{
			return (state == CellState.STATE_LIVE);
		}
		
		public function howManyNeighborsLive():int 
		{
			var liveNeighborCounting:int = 0;
			for each(var neighbor:ACell in neighborList)
			{
				if(neighbor!= null && neighbor.isLive()) {
					liveNeighborCounting++;
				}
			}
			
			return liveNeighborCounting;
		}
	}

}
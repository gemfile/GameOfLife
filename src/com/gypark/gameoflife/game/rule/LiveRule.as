package com.gypark.gameoflife.game.rule 
{
	import com.gypark.gameoflife.game.unit.cell.ACell;
	/**
	 * ...
	 * @author gypark
	 */
	public final class LiveRule 
	{
		public static const INSTANCE:LiveRule = new LiveRule();
		private static const NEIGHBOR_COUNTING_LIST_FOR_LIVE:Array/*Array*/ = [[3], [2, 3]];
		
		public function LiveRule() 
		{
			if(INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
		}
		
		public function judgeLiveOrDie(cell:ACell):void 
		{
			var numOfLiveNeighbor:int = cell.howManyNeighborsLive();
			var neighborCountingList:Array/*int*/ = NEIGHBOR_COUNTING_LIST_FOR_LIVE[cell.state];
			for each(var neighborCounting:int in neighborCountingList)
			{
				if(numOfLiveNeighbor == neighborCounting) {
					cell.hasNextGeneration = true;
					return;
				}
			}
			cell.hasNextGeneration = false;
		}
		
	}

}
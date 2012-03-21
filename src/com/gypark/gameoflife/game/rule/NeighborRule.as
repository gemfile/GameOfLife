package com.gypark.gameoflife.game.rule 
{
	import com.gypark.gameoflife.game.unit.cell.ACell;
	import flash.geom.Point;
	/**
	 * ...
	 * @author gypark
	 */
	public final class NeighborRule 
	{
		public static const INSTANCE:NeighborRule = new NeighborRule();
		
		public static const LEFT_TOP	 :int = 0;		public static const CENTER_TOP	 :int = 1;		public static const RIGHT_TOP	 :int = 2;
		public static const LEFT_MIDDLE	 :int = 3;														public static const RIGHT_MIDDLE :int = 4;
		public static const LEFT_BOTTOM	 :int = 5;		public static const CENTER_BOTTOM:int = 6;		public static const RIGHT_BOTTOM :int = 7;
		
		private static const POINT_LIST_OF_NEIGHBOR:Array/*Point*/ = [	new Point(-1, -1), new Point(0, -1), new Point(1, -1),
																		new Point(-1, 0), 					 new Point(1, 0), 
																		new Point(-1, 1),  new Point(0, 1),  new Point(1, 1)	];
		
		private var cellPoint:Point;
		private var gameWidth:int;
		private var gameHeight:int;
		private var cellList:Array/*ICell*/;
		
		public function NeighborRule()
		{
			if (INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
		}
		
		public function setCellPoint(x:int, y:int, gameWidth:int, gameHeight:int, cellList:Array):void 
		{
			this.cellList = cellList;
			this.cellPoint = new Point(x, y);
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
		}
		
		public function getNeighborOn(positionOfCell:int):ACell
		{
			var fixedCellPoint:Point = cellPoint.add(POINT_LIST_OF_NEIGHBOR[positionOfCell]);
			if(fixedCellPoint.x < 0 || fixedCellPoint.x > gameWidth-1 || fixedCellPoint.y < 0 || fixedCellPoint.y > gameHeight-1) {
				return null;
			}
			
			return cellList[fixedCellPoint.x][fixedCellPoint.y];
		}
	}

}
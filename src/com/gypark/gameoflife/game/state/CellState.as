package com.gypark.gameoflife.game.state 
{
	/**
	 * ...
	 * @author gypark
	 */
	public final class CellState 
	{
		public static const STATE_DEAD:int = 0;
		public static const STATE_LIVE:int = 1;
		
		public static const COLOR_DEAD:uint = 0xffffffff;
		public static const COLOR_LIVE:uint = 0xff000000;
		
		public static const SIZE_GAP   :int = 5;
		public static const SIZE_WIDTH :int = 20;
		public static const SIZE_HEIGHT:int = 20;
	}

}
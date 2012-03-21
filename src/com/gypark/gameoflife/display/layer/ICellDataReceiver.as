package com.gypark.gameoflife.display.layer 
{
	
	/**
	 * ...
	 * @author gypark
	 */
	public interface ICellDataReceiver 
	{
		function onCellDataUpdate(cellList:Array/*ACell*/):void;
	}
	
}
package com.gypark.gameoflife.display.cell 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.osflash.signals.natives.NativeSignal;
	import com.gypark.gameoflife.game.state.CellState;
	
	/**
	 * ...
	 * @author gypark
	 */
	public final class CellSprite extends Sprite 
	{
		public var downed:NativeSignal;
		public var overed:NativeSignal;
		public var isToggleON:Boolean;
		private var cellWidth:int;
		private var cellHeight:int;
		
		public function CellSprite(cellWidth:int, cellHeight:int) 
		{
			this.cellHeight = cellHeight;
			this.cellWidth = cellWidth;
			init();
		}
		
		public function setState(cellState:int/*CellState*/):void
		{
			isToggleON = (cellState == CellState.STATE_LIVE) ? true : false;
			draw();
		}
		
		public function toggle():void 
		{
			isToggleON = !isToggleON;
			draw();
		}
		
		private function init():void 
		{
			draw();
			setNativeSignal();
		}
		
		private function setNativeSignal():void
		{
			downed = new NativeSignal(this, MouseEvent.MOUSE_DOWN, MouseEvent);
			overed  = new NativeSignal(this, MouseEvent.MOUSE_OVER, MouseEvent);
		}
 
		private function draw():void 
		{
			buttonMode = true;
			graphics.clear();
			graphics.lineStyle(1, 0xff000000);
			if(isToggleON) {
				graphics.beginFill(0x00000000);
			}
			else {
				graphics.beginFill(0x00ffffff);
			}
			
			graphics.drawRect(0, 0, cellWidth, cellHeight);
			graphics.endFill();
		}
		
	}

}
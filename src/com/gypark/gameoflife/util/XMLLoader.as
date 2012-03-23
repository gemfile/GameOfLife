package com.gypark.gameoflife.util 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.osflash.signals.natives.NativeSignal;
	/**
	 * ...
	 * @author gypark
	 */
	public class XMLLoader 
	{
		public static const INSTANCE:XMLLoader = new XMLLoader();
		public var loaded:NativeSignal;
		private var urlLoader:URLLoader;
		
		public function XMLLoader() 
		{
			if (INSTANCE) {
				throw new Error("인스턴스를 임의로 생성할 수 없습니다.");
			}
			
			init();
		}
		
		private function init():void
		{
			urlLoader = new URLLoader();
			loaded = new NativeSignal(urlLoader, Event.COMPLETE, Event);
		}
	
		public function load(url:String):void
		{
			urlLoader.load(new URLRequest(url));
		}
	}

}
package
{
	import org.flixel.FlxSprite;

	public class Spectator extends FlxSprite
	{
		[Embed(source="../lib/spectator.png")]
		private var SpectatorImg:Class;
		
		private var _type:String;
		
		public function Spectator(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(SpectatorImg, true, true, 16, 32);
			
			addAnimation("manIdle", [0,1,2], 2);
			addAnimation("womanIdle", [3,4], 2);
			addAnimation("childIdle", [6,7,8], 2);
			addAnimation("punkIdle", [10,11], 5);
			
			velocity.y = -16;
		}
		
		public function set type(str:String):void{
			_type = str;
			play(_type+"Idle");
		}
		
		public function get type():String{
			return _type;
		}
	}
}
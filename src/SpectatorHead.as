package
{
	import org.flixel.FlxSprite;

	public class SpectatorHead extends FlxSprite
	{
		[Embed(source="../lib/spectator-head.png")]
		private var SpectatorImg:Class;
		
		private var _type:String;
		
		public function SpectatorHead(X:int, Y:int)
		{
			super(X,Y);
			
			loadGraphic(SpectatorImg, true, true, 100, 132);
			
			addAnimation("man", [0]);
			addAnimation("woman", [1]);
			addAnimation("child", [2]);
			addAnimation("punk", [3]);
			
			type = "man";
		}
		
		public function set type(str:String):void{
			_type = str;
			play(_type);
		}
		
		public function get type():String{
			return _type;
		}
	}
}
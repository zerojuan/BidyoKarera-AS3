package
{
	import flash.events.Event;
	
	import org.flixel.FlxGame;
	[SWF(width="760", height="480", backgroundColor="#ffffff")]
	public class KareraFacebook extends FlxGame
	{
		public static var FACEBOOK:FacebookAPI;
		
		public static var player:Player;
		
		public function KareraFacebook(){
			super(760/2, 240, MenuState);
			player = new Player();
		}
	}
}
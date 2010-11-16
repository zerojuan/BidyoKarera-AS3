package
{
	import com.facebook.graph.Facebook;
	
	import events.FacebookAPIEvent;
	
	import flash.events.Event;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class MenuState extends FlxState
	{
		[Embed(source="../lib/soon_to.png")]
		private var SoonImg:Class;
		
		[Embed(source="../lib/head.png")]
		private var HeadImg:Class;
		
		[Embed(source="../lib/talking.png")]
		private var TalkinImg:Class;
		
		private var _welcomeTxt:FlxText;
		private var _startButton:FlxButton;	
		
		private var _sendStatusButton:FlxButton;
		private var _headSprite:FlxSprite;
		private var _mouthSprite:FlxSprite;
		
		public function MenuState(){			
			//KareraFacebook.FACEBOOK = new FacebookAPI();
			
			FlxG.mouse.show();
			
			
			
			_startButton = new FlxButton(30,50, onStartButton);
			add(_startButton);
			
			_sendStatusButton = new FlxButton(40,30, onSendStatus);
			var sendStatSpr:FlxSprite = new FlxSprite(0,0, SoonImg);
			var sendStatSpr2:FlxSprite = new FlxSprite(0,0, SoonImg);
			sendStatSpr.color = 0xcccccc;
			_sendStatusButton.loadGraphic(sendStatSpr, sendStatSpr2);
			add(_sendStatusButton);
			
			_headSprite = new FlxSprite(210, 20, HeadImg);
			add(_headSprite);
			
			_mouthSprite = new FlxSprite(295, 150, TalkinImg);
			_mouthSprite.loadGraphic(TalkinImg, true, false, 37, 56);
			_mouthSprite.addAnimation("talking", [0], 16);
			_mouthSprite.play("talking");
			add(_mouthSprite);
			
			_welcomeTxt = new FlxText(300,220, 900, "Ooops. You caught us at a bad time. We are still busy breeding do.. err.. horses. Yes. Come back again on Oct 13th. Meanwhile click the poster to find out who viewed your profile..");
			add(_welcomeTxt);
			_welcomeTxt.velocity.x = -65;
			//Get server connection
			//KareraFacebook.FACEBOOK.addEventListener(FacebookAPIEvent.USER_READY, onUserReady);
				//if can't connect
					//show can't connect
				//else
					//show time left
					//if time left is <= 0
						//show start game button
					//else
						//show timer
		}
		
		private function onSendStatus():void{
			
		}
		
		private function onUserReady(e:Event):void{
			KareraFacebook.player.username =  KareraFacebook.FACEBOOK.user.first_name;
			FlxG.log("User "+KareraFacebook.player.username +" in!");
		}
		
		override public function update():void{
			super.update();
			if(!_welcomeTxt.onScreen()){
				_welcomeTxt.x = 300;
			}
		}
		
		private function onStartButton():void{
			_welcomeTxt.text = "Start it!";
			FlxG.state = new GameState();
		}
	}
}
package
{
	import com.facebook.graph.Facebook;
	
	import events.FacebookAPIEvent;
	
	import flash.events.Event;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
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
		
		[Embed(source="../lib/foreground.png")]
		private var ForegroundImg:Class;
		
		[Embed(source="../lib/background.png")]
		private var BackgroundImg:Class;
		
		[Embed(source="../lib/close1.png")]
		private var CloseAnnouncementImg:Class;
		
		[Embed(source="../lib/close2.png")]
		private var CloseBulletinImg:Class;
		
		private var _welcomeTxt:FlxText;
		private var _startButton:FlxButton;	
		
		private var _sendStatusButton:FlxButton;
		private var _closeBulletingButton:FlxButton;
		private var _closeAnnouncementButton:FlxButton;
		private var _headSprite:FlxSprite;
		private var _mouthSprite:FlxSprite;
		
		private var _foregroundSprite:FlxSprite;
		private var _backgroundSprite:FlxSprite;
		
		private var _spectatorGroup:FlxGroup;
		
		public function MenuState(){			
			//KareraFacebook.FACEBOOK = new FacebookAPI();
			
			FlxG.mouse.show();
			
			var skyColor:FlxSprite = new FlxSprite(0,0);
			skyColor.createGraphic(400, 100, 0xfffff8f0);
			
			add(skyColor);
			
			_backgroundSprite = new FlxSprite(0,0);
			_backgroundSprite.loadGraphic(BackgroundImg);
			
			add(_backgroundSprite);
			
			_foregroundSprite = new FlxSprite(0,0);
			_foregroundSprite.loadGraphic(ForegroundImg);
			
			add(_foregroundSprite);
			
			_startButton = new FlxButton(30,50, onStartButton);
			add(_startButton);
			
			_sendStatusButton = new FlxButton(300,115, onSendStatus);
			var sendStatSpr:FlxSprite = new FlxSprite(0,0, SoonImg);
			var sendStatSpr2:FlxSprite = new FlxSprite(0,0, SoonImg);
			sendStatSpr.color = 0xcccccc;
			_sendStatusButton.loadGraphic(sendStatSpr, sendStatSpr2);
			add(_sendStatusButton);
			
			_closeBulletingButton = new FlxButton(130, 120, onCloseBulletin);
			var closeBulletinSpr:FlxSprite = new FlxSprite(0,0, CloseBulletinImg);
			var closeBulletinSpr2:FlxSprite = new FlxSprite(0,0, CloseBulletinImg);
			closeBulletinSpr.color = 0xcccccc;
			_closeBulletingButton.loadGraphic(closeBulletinSpr, closeBulletinSpr2);
			add(_closeBulletingButton);
			
			_closeAnnouncementButton = new FlxButton(50, 120, onCloseAnnouncement);
			var closeAnnouncementSpr:FlxSprite = new FlxSprite(0,0, CloseAnnouncementImg);
			var closeAnnouncementSpr2:FlxSprite = new FlxSprite(0,0, CloseAnnouncementImg);
			closeAnnouncementSpr.color = 0xcccccc;
			_closeAnnouncementButton.loadGraphic(closeAnnouncementSpr, closeAnnouncementSpr2);
			add(_closeAnnouncementButton);
			
			_headSprite = new FlxSprite(210, 20, HeadImg);
			//add(_headSprite);
			
			_spectatorGroup = new FlxGroup();
			var spectator:Spectator = new Spectator(210, 150);
			spectator.type = "woman";
			
			
			_spectatorGroup.add(spectator);
			add(_spectatorGroup);
			
			_mouthSprite = new FlxSprite(295, 150, TalkinImg);
			_mouthSprite.loadGraphic(TalkinImg, true, false, 37, 56);
			_mouthSprite.addAnimation("talking", [0], 16);
			_mouthSprite.play("talking");
			//add(_mouthSprite);
			
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
		
		private function onCloseBulletin():void{
			
		}
		
		private function onCloseAnnouncement():void{
			
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
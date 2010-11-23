package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class DialogScreen extends FlxGroup
	{
		public static const SHOWN:int = 0;
		public static const SHOWING:int = 1;
		public static const HIDING:int = 2;
		public static const HIDDEN:int = 3;
		
		private var _slideSpeed:int = 2000;
		
		private var _spectatorHead:SpectatorHead;
		private var _screen:FlxSprite;
		
		private var _textBoxBackground:FlxSprite;
		private var _textBoxForeground:FlxSprite;
		
		private var _textBoxGroup:FlxGroup;
		
		private var _dialogText:FlxText;	
		
		private var _state:int;
		
		public function DialogScreen()
		{
			super();
			
			_screen = new FlxSprite(0,0);
			_screen.createGraphic(380, 240, 0xcc000000);
			
			add(_screen);
			
			
			_textBoxGroup = new FlxGroup();
			_textBoxBackground = new FlxSprite();
			_textBoxBackground.createGraphic(280, 56, 0xff6fd16c);
			_textBoxForeground = new FlxSprite(2,2);
			_textBoxForeground.createGraphic(276, 52, 0xffd9fcd8);
			
			_dialogText = new FlxText(10,10, 250, "This is a text dialog");
			_dialogText.color = 0x000000;
			_dialogText.antialiasing = true;
			_dialogText.size = 8;
						
			_textBoxGroup.add(_textBoxBackground);
			_textBoxGroup.add(_textBoxForeground);
			_textBoxGroup.add(_dialogText);
			add(_textBoxGroup);
			
			
			
			_textBoxGroup.x = 20;
			_textBoxGroup.y = 180;
			
			
			_spectatorHead = new SpectatorHead(280,115);
			add(_spectatorHead);
			
			hideFromScreen();
		}
		
		override public function update():void{
			super.update();
			if(_state == SHOWING){
				if(_screen.y >= 0){
					stopSliding();										
					_state = SHOWN;
				}
			}else if(_state == HIDING){
				if(_screen.y <= -240){
					stopSliding();										
					_state = HIDDEN;					
					visible = false;
				}
			}else if(_state == SHOWN){
				showAtScreen();
			}else if(_state == HIDDEN){
				hideFromScreen();
			}
		}
		
		public function showDialog(type:String, dialog:String):void{
			visible = true;
			_state = SHOWING;
			_textBoxGroup.velocity.y = -_slideSpeed/2;
			_spectatorHead.velocity.x = -_slideSpeed/2;
			_screen.velocity.y = _slideSpeed;
			_dialogText.text = dialog;
			_spectatorHead.type = type;			
		}
				
		public function hideDialog():void{
			_state = HIDING;
			_screen.velocity.y = -_slideSpeed;					
			_spectatorHead.velocity.x = _slideSpeed/2;
			_textBoxGroup.velocity.y = _slideSpeed/2;
		}
		
		private function hideFromScreen():void{
			_textBoxGroup.y = 250;
			_spectatorHead.x = 340;
			_screen.y = -240;
		}
		
		private function showAtScreen():void{
			_spectatorHead.x = 280;
			_textBoxGroup.y = 180;
			_textBoxForeground.y = 182;
			_textBoxBackground.y = 180;
			_dialogText.y = 190;
			_screen.y = 0;
		}
		
		private function stopSliding():void{
			_screen.velocity.y = 0;					
			_spectatorHead.velocity.x = 0;
			_textBoxGroup.velocity.y = 0;
		}
	}
}
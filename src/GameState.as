package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxU;

	public class GameState extends FlxState{
		[Embed(source="../lib/fence.png")]
		private var FenceImg:Class;
		
		[Embed(source="../lib/finish.png")]
		private var FinishImg:Class;
		
		[Embed(source="../lib/track.png")]
		private var TrackImg:Class;
		
		[Embed(source="../lib/horse.png")]
		private var HorseImg:Class;
		
		[Embed(source="../lib/jockey.png")]
		private var JockeyImg:Class;
		
		[Embed(source="../lib/grass.png")]
		private var GrassImg:Class;
		
		private var _topFence:FlxSprite;
		private var _topFence2:FlxSprite;
		private var _lowerFence:FlxSprite;
		private var _lowerFence2:FlxSprite;
		private var _track:FlxSprite;
		private var _finish:FlxSprite;
		
		private var _flowersAndSpectator:FlxGroup;
		private var _flowers:FlxTileblock;
		
		private var _bottomPanel:FlxGroup;		
		
		private var _horseGroup:FlxGroup;
		
		private var _horses:Vector.<Horse>;
		
		private var _startButton:FlxButton;
		
		private var _raceDone:Boolean = false;
		
		public static var WINNER:int;
		
		private var _timeToNextSwitch:Number = 0;
		private var _lapsLeft:Number = 3;
		
		private var _state:String = "betting";
		
		private var _dialogText:FlxText;
		
		public function GameState(){
			FlxG.mouse.show();
			
			_topFence = new FlxSprite(0, 70, FenceImg);
			_topFence2 = new FlxSprite(370, 70, FenceImg);
			_lowerFence = new FlxSprite(0, 185, FenceImg);
			_lowerFence2 = new FlxSprite(370, 185, FenceImg);
			_track = new FlxSprite(0, 80, TrackImg);
			_finish = new FlxSprite(500, 43, FinishImg);
			
			var skyColor:FlxSprite = new FlxSprite(0,0);
			skyColor.createGraphic(400, 100, 0xfffff8f0);
			
			add(skyColor);
			
			var grassColor:FlxSprite = new FlxSprite(0,40);			
			grassColor.createGraphic(400, 250, 0xffb2e19f);
			
			_flowers = new FlxTileblock(0, 40, 400, 20);
			_flowers.loadGraphic(GrassImg, 5);
			
			_flowersAndSpectator = new FlxGroup();
			_flowersAndSpectator.add(grassColor);
			_flowersAndSpectator.add(_flowers);
			
			add(_flowersAndSpectator);
			
			var panelBorder:FlxSprite = new FlxSprite(0, 192);
			panelBorder.createGraphic(250, 120, 0xffb6fef6);
			var panelInside:FlxSprite = new FlxSprite(3, 194);
			panelInside.createGraphic(245, 118, 0xffffffff);
			
			_bottomPanel = new FlxGroup();
			_bottomPanel.add(panelBorder);
			_bottomPanel.add(panelInside);
			
			_dialogText = new FlxText(10, 200, 300, "Welcome to racing");
			
			_horseGroup = new FlxGroup();
			
			_horses = new Vector.<Horse>();
			var result:Array = ServerConnect.instance.result;
			for(var i:int = 0; i < 7; i++){
				var _horse:Horse = new Horse(5,35 + (7 * i), HorseImg, JockeyImg);
				_horses[i] = _horse;
				_horse.place = result[i];
				_horse.maxVelocity.x = 30;
				_horseGroup.add(_horse);
			}
			
			
			_startButton = new FlxButton(0,0, onStartClicked);
			
			add(_topFence);
			add(_topFence2);
			add(_track);
			add(_finish);
			add(_horseGroup);
			add(_lowerFence);
			add(_lowerFence2);
			add(_bottomPanel);
			add(_startButton);
			
			add(_dialogText);
			
		}
		
		override public function update():void{
			super.update();
			checkFences();
			getMouseInput();
			if(_state == "betting"){
				
			}else if(_state == "racing"){
				_timeToNextSwitch -= 100 * FlxG.elapsed;
				onFinishCrossed();
				if(_timeToNextSwitch <= 0){
					switchToPosition();
					_timeToNextSwitch = 1000;
					_lapsLeft--;
				}
				if(_lapsLeft <= 0){				
					showFinished();
				}
			}else if(_state == "done"){
				
			}			
		}
		
		private function getMouseInput():void{
				var isOnHorse:Boolean = false;
				for(var i:int = 0; i < 7; i++){
					if(_horses[i].overlapsPoint(FlxG.mouse.x, FlxG.mouse.y, true)){
						if(FlxG.mouse.justPressed())
							FlxG.log("Pressed Horse["+i+"]");
						else{
							showDialog(i);							
						}					
						isOnHorse = true;
					}
				}
				if(!isOnHorse){
					hideDialog();
				}
		}
		
		private function hideDialog():void{
			_dialogText.visible = false;
		}
		
		private function showDialog(horseId:int):void{
			_dialogText.visible = true;
			_dialogText.text = _horses[horseId].dialog;
		}
		
		private function switchToPosition():void{
			var arr:Array = PositionGenerator.generatePosition(3, 3, (_lapsLeft <= 0));
			for(var i:int = 0; i < 7; i++){
				_horses[i].goto(arr[i]);
			}
		}
		
		private function onFinishCrossed():void{
			for(var i:int = 0; i < 7; i++){
				if(_horses[i].x >= _finish.x){
					_raceDone = true;
					_horses[i].stop();
					WINNER = i;
					_state = "done";
					break;
				}
			}
		}
		
		private function checkFences():void{
			if(!_topFence.onScreen()){
				_topFence.x = _topFence2.x + 370;
			}
			if(!_topFence2.onScreen()){
				_topFence2.x = _topFence.x + 370;
			}
			if(!_lowerFence.onScreen()){
				_lowerFence.x = _lowerFence2.x + 370;
			}
			if(!_lowerFence2.onScreen()){
				_lowerFence2.x = _lowerFence.x + 370;
			}
		}
		
		private function startRace():void{
			_topFence.velocity.x = -65;
			_topFence2.velocity.x = -65;
			_lowerFence.velocity.x = -65;
			_lowerFence2.velocity.x = -65;			
			startHorses();
			_state = "racing";
		}
		
		private function showFinished():void{
			_finish.velocity.x = - 65;
		}
		
		private function endRace():void{
			_topFence.velocity.x = 0;
			_topFence2.velocity.x = 0;
			_lowerFence.velocity.x = 0;
			_lowerFence2.velocity.x = 0;
		}
		
		private function startHorses():void{
			for(var i:int = 0; i < 7; i++){
				_horses[i].start();
			}
		}
		
		private function onStartClicked():void{
			startRace();
		}
	}
}
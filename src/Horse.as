package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;

	public class Horse extends FlxGroup
	{
		public var horseSprite:FlxSprite;
		public var jockeySprite:FlxSprite;
		
		private var running:Boolean = false;
		
		private var destX:int = 140;
		
		public var place:int = 0;
		
		public function Horse(X:int, Y:int, HorseImg:Class, JockeyImg:Class)
		{
			x = X;
			y = Y;						
			
			horseSprite = new FlxSprite(x, y, HorseImg);
			horseSprite.loadGraphic(HorseImg, true, false, 32,32,false);
			jockeySprite = new FlxSprite(x+4,y-5, JockeyImg);
			jockeySprite.loadGraphic(JockeyImg, true, false, 32,32,false);
			jockeySprite.color = 0xcc1200;
			horseSprite.color = 0xcccccc;
			add(horseSprite);
			add(jockeySprite);
			
			horseSprite.addAnimation("idle", [0]);
			horseSprite.addAnimation("running", [0,1,2], 16);
			
			jockeySprite.addAnimation("idle", [0]);
			jockeySprite.addAnimation("running", [0,1,2], 13);
			jockeySprite.addAnimation("win", [3,4], 2);
						
		}
		
		override public function overlapsPoint(X:Number, Y:Number, PerPixel:Boolean=false):Boolean{
			return (horseSprite.overlapsPoint(X,Y,PerPixel) || jockeySprite.overlapsPoint(X,Y,PerPixel));
		}
		
		override public function update():void{
			if(velocity.x > 0 && x >= destX){
				acceleration.x = 0;
				velocity.x = 0;				
			}
			
			if(velocity.x < 0 && x <= destX){
				acceleration.x = 0;
				velocity.x = 0;
			}
			super.update();
		}
		
		public function goto(X:Number):void{
			if(X >= destX){
				velocity.x = 30;
			}else{
				velocity.x = -30;
			}
			destX = X;
		}
		
		public function start():void{
			running = true;
			acceleration.x = 30;
			horseSprite.play("running");
			jockeySprite.play("running");
		}
		
		public function stop():void{
			running = false;
			horseSprite.play("running");
			jockeySprite.play("win");
		}
		
		public function get dialog():String{
			return "I will be " + (place+1) + "th place";
		}
	}
}
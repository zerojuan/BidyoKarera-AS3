package
{
	public class PositionGenerator
	{
		public function PositionGenerator()
		{
		}
		
		public static function generatePosition(winner:int, playersBet:int, isFinal:Boolean):Array{
			var retArr:Array = [];
			var highestNum:Number;
			highestNum = (Math.random() * 30) + 140;
			retArr[winner] = highestNum;			
			
			for(var i:int = 0; i < 7; i++){
				if(isFinal){
					if(i != winner){
						retArr[i] = (Math.random() * highestNum) - 4;
					}
				}else{
					retArr[i] = (Math.random() * highestNum) - 4;
				}
			}
			
			return retArr;
		}
	}
}
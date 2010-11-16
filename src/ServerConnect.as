package
{
	public class ServerConnect
	{
		private static var _instance:ServerConnect;				
		
		private var _result:Array;
		
		private var _money:Number;
		
		public function ServerConnect(){
			//TODO: Make instantiation check here for singleton
			onReady();
		}
		
		public static function get instance():ServerConnect{
			if(!_instance){
				_instance = new ServerConnect();				
			}
			return _instance;
		}
		
		public function get result():Array{
			return _result;
		}
		
		public function get money():Number{
			return _money;
		}			
		
		public function onReady():void{
			_result = [];
			_result = [2, 3, 4, 5, 6, 0, 1];
			
			_money = 20000;
		}
	}
}
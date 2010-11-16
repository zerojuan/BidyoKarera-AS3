package
{
	import com.facebook.graph.Facebook;
	
	import events.FacebookAPIEvent;
	
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	public class FacebookAPI extends EventDispatcher
	{
		private var _user:Object;
		
		protected var topURL:String = ExternalInterface.call('top.location.toString');
		
		public function FacebookAPI()
		{
			Facebook.init("108813289182666", onLogin);
			Facebook.addJSEventListener('auth.sessionChange', onSessionChange);
		}
		
		public function onLogin(success:Object, fail:Object):void{
			if(success){
				Facebook.api("me", getMeHandler);
				Facebook.api("me/picture", onPictureLoad);
			}else if(!success && !topURL){
				ExternalInterface.call("redirect", 
					"108813289182666",
					"",
					"http://apps.facebook.com/bidyokarera/");
			}
		}
		
		public function onSessionChange(result:Object):void{
			
		}
		
		public function get user():Object{
			return _user;
		}
		
		public function onPictureLoad(result:Object, fail:Object):void{
			//Empty bug on bulkloader's part
		}
		
		public function getMeHandler(result:Object, fail:Object):void{
			if (result) {
				_user = result;
				var evt:FacebookAPIEvent = new FacebookAPIEvent(FacebookAPIEvent.USER_READY);
				dispatchEvent(evt);
			}else{
				var evt2:FacebookAPIEvent = new FacebookAPIEvent(FacebookAPIEvent.USER_FAILED);
				dispatchEvent(evt2);
			}
		}
	}
}
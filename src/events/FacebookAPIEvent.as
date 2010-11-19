package events {
	import flash.events.Event;

	public class FacebookAPIEvent extends Event {
		public static const USER_READY:String = "userReady";
		public static const USER_FAILED:String = "userFailed";
		public static const FRIEND_READY:String = "friendReady";
		
		public function FacebookAPIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}
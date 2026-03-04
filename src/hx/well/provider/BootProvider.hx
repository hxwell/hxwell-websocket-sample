package hx.well.provider;
import hx.well.route.Route;
import hx.well.handler.SocketIOChatHandler;
import hx.well.handler.WebSocketEchoHandler;
class BootProvider extends AbstractProvider {
    public function boot():Void {
        Route.websocket("/socket.io")
			.handler(new SocketIOChatHandler());

        Route.websocket("/echo")
            .handler(new WebSocketEchoHandler());
    }
}

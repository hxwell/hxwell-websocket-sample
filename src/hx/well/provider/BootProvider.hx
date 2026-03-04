package hx.well.provider;
import hx.well.route.Route;
import hx.well.handler.AbortHandler;
import hx.well.handler.SocketIOSample;
import hx.well.handler.WebSocketSample;
class BootProvider extends AbstractProvider {
    public function boot():Void {
        Route.websocket("/socket.io")
			.handler(new SocketIOSample());

        Route.websocket("/ws")
            .handler(new WebSocketSample());
    }
}

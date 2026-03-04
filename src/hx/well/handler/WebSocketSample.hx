package hx.well.handler;
import hx.well.websocket.AbstractWebSocketHandler;
import hx.well.websocket.WebSocketSession;
import haxe.io.Bytes;
import haxe.Exception;
class WebSocketSample extends AbstractWebSocketHandler {
    public function onOpen(session:WebSocketSession):Void {
        trace("WebSocket connection opened: " + session.id);
    }

    public function onMessage(session:WebSocketSession, message:String):Void {
        trace("Received message from " + session.id + ": " + message);
        // Echo the message back to the client
        session.send("Echo: " + message);
    }

    public function onBinary(session:WebSocketSession, data:Bytes):Void {
        trace("Received binary message from " + session.id + ": " + data.length + " bytes");
        // Echo the binary data back to the client
        session.sendBinary(data);
    }

    public function onClose(session:WebSocketSession, code:Int, reason:String):Void {
        trace("WebSocket connection closed: " + session.id + " (code: " + code + ", reason: " + reason + ")");
    }

    public function onError(session:WebSocketSession, error:Exception):Void {
        trace("WebSocket error on session " + session.id + ": " + error);
    }
}

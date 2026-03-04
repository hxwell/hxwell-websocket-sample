package hx.well.handler;

import hx.well.websocket.socketio.SocketIOHandler;
import hx.well.websocket.socketio.SocketIOSession;

class SocketIOSample extends SocketIOHandler {
    var _rooms:Array<String> = ["General", "Test"];

    public function onConnection(socket:SocketIOSession):Void {
        var username = 'User_${socket.id.substring(0, 4)}';
        socket.setAttribute("username", username);
        
        trace('$username bağlandı.');

        socket.emit("update_rooms", _rooms);
        emitAll("update_users", getAllUsernames());

        socket.join(_rooms[0]);
        socket.setAttribute("currentRoom", _rooms[0]);
        
        socket.to(_rooms[0]).emit("receive_message", {
            sender: "System",
            text: '$username joined room.'
        });

        socket.on("join_room", (newRoom) -> {
            var currentRoom:String = socket.getAttribute("currentRoom");
            var username:String = socket.getAttribute("username");
            
            socket.leave(currentRoom);
            
            toRoom(currentRoom).emit("receive_message", {
                sender: "System",
                text: '$username left room.'
            });
            
            socket.join(newRoom);
            socket.setAttribute("currentRoom", newRoom);

            socket.to(newRoom).emit("receive_message", {
                sender: "System",
                text: '$username joined room.'
            });
        });

        socket.on("send_message", (message) -> {
            var currentRoom:String = socket.getAttribute("currentRoom");
            var username:String = socket.getAttribute("username");
            
            toRoom(currentRoom).emit("receive_message", {
                sender: username,
                text: message
            });
        });
    }

    public function onDisconnect(socket:SocketIOSession):Void {
        var username:String = socket.getAttribute("username");
        var currentRoom:String = socket.getAttribute("currentRoom");
        
        if (currentRoom != null) {
            toRoom(currentRoom).emit("receive_message", {
                sender: "System",
                text: '$username left room.'
            });
        }
        
        trace('$username ayrıldı.');
        emitAll("update_users", getAllUsernames());
    }

    private function getAllUsernames():Array<String> {
        return [for (s in getSockets()) s.getAttribute("username")];
    }
}
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();
const port = process.env.port || 3000;
const dbLink = process.env.dbLink;
var server = http.createServer(app);

const Room = require('./models/room');
var io = require("socket.io")(server, {
  cors: {
    origin: '*',
    methods: ['GET', 'POST'],
  },
  pingInterval: 25000,
  pingTimeout: 60000,
  upgradeTimeout: 30000,
});

//Middle Ware
app.use(express.json());

io.on('connection', (socket) => {
    console.log('Io Connected!', socket.id);
    

    socket.on('createRoom', async ({nickname}) => {
        console.log(nickname);
        let room = new Room();
        try{
            let player = {
            nickname,
            socketID: socket.id,
            playerType: 'X',
            };

            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room); // Printing room data after creating room
            const roomId = room._id.toString();
            socket.join(roomId);
            io.to(roomId).emit("createRoomSuccess", room);
        } catch(e) {
            console.log(e);
        }
    });

    socket.on('joinRoom', async ({nickname, roomId}) => {
        try {
            if(!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('errorOccured', 'Please enter a valid room ID.');
                return;
            }
            let room = await Room.findById(roomId);
            
            if(room.isJoin){
                let player = {
                nickname,
                socketID: socket.id,
                playerType: "O",
                };

                socket.join(roomId);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();
                io.to(roomId).emit("joinRoomSuccess", room);
                io.to(roomId).emit("updatePlayer", room.players);
                io.to(roomId).emit("updateRoom", room);
            }else {
                socket.emit('errorOccured', 'Game is in Progress, try after some time');
            } 
        } catch (error) {
            console.log(error);
        }
    });

    socket.on('tap', async ({index, roomId}) => {
        try {
            let room =  await Room.findById(roomId);
            let choice = room.turn.playerType;
            if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;
            } else {
                room.turn = room.players[0];
                room.turnIndex = 0;
            }
            room = await room.save();
            io.to(roomId).emit("tapped", {
                index,
                choice,
                room,
            });
        } catch (error) {
            console.log(error);
        }
    });

    socket.on('winner', async ({winnerSocketId, roomId}) => {
        try {
            let room = await Room.findById(roomId);
            let player = room.players.find((playerr) => playerr.socketID == winnerSocketId);
            player.points += 1;
            room = await room.save();

            // Emit updated players to all clients
            io.to(roomId).emit("updatePlayer", room.players);

            if(player.points >= room.maxRounds){
                io.to(roomId).emit('endGame', player);
            } else {
                io.to(roomId).emit('increasePoint', player);
            }
        } catch (error) {
            console.log(error);
        }
        
    });

    socket.on('disconnect', (reason) => {
      console.log('Socket disconnected:', reason);
    });
});

mongoose.connect(dbLink).then(() => {
    console.log('Connected Successfully!')
}).catch((e) => {console.log(e)});


server.listen(port, '0.0.0.0', () => {
    console.log('Server running on port ' + port);
})

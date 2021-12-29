const express = require('express');
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);
const port = process.env.PORT || 3000;

app.use(express.static(__dirname + '/public'));

function onConnection(socket){
  socket.on('drawing', (data) => socket.broadcast.emit('drawing', data));
  console.log("connected")
}

io.on('connection', onConnection);
console.log("success")
http.listen(port, () => console.log('listening on port ' + port));

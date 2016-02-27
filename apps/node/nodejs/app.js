var http = require('http');
var path    = require('path');
var express = require('express');
var routes  = require('./routes');

var PORT = 3000;

var app = express();

app.set('port', process.env.PORT || PORT);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', routes.index);

app.listen(app.get("port"), function() {
  return console.log(("Express server listening on port " + app.settings.port) + (" in " + app.settings.env + " mode"));
});

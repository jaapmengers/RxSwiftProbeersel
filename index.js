var express = require('express')

var app = express()

app.get('/slow', function (req, res) {
  setTimeout(x => {
    res.send('slow');
  }, 20000);
})

app.get('/quick', function (req, res) {
  res.send('quick')
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})

var levelup = require('levelup')
var mongodown = require('mongodown')

// MongoDB Collection name defaults to 'mongodown'
var db = levelup(mongodown('localhost:27017/test?retryWrites=true'))
//var db = levelup(mongodown('mongodb+srv://cogdbuser:4chfMt6rrwyKJFq@cluster0-eq8xt.mongodb.net/cogdbuser?retryWrites=true', {collection:'TestTable'}))
// var db = levelup(mongodown('cogdbuser:4chfMt6rrwyKJFq@cluster0-eq8xt.mongodb.net/test'))

// OR pass custom MongoDB collection name
// db = levelup(mongodown('localhost/my-database'), { collection:'People_C' })

console.log(db)

db.put('name', 'Bozo')
db.put('dob', '29 February 2119')
db.put('occupation', 'Clown')
db.put('location', 'Tinseltown')

db.readStream()
  .on('data', console.log)
    .on('close', function () { console.log('Show\'s over folks!') })


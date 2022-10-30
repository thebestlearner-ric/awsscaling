//initialising a variable name data

var data = 0;
const dbName = 'mysql'
const dbUser = 'root'
const dbPassword = ''
const dbHost = ''
//printing default value of data that is 0 in h2 tag
document.getElementById("counting").innerText = data;

//creation of increment function
function increment() {
	data = data + 1;
	document.getElementById("counting").innerText = data;
}
//creation of decrement function
function decrement() {
	data = data - 1;
	document.getElementById("counting").innerText = data;
}

var mysql = require(dbName);

var con = mysql.createConnection({
  host: dbHost,
  user: dbUser,
  password: dbPassword
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});
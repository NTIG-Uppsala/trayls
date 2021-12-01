//states variables
const mariadb = require('mariadb');
const pool = mariadb.createPool({
    host: 'localhost',
	user: 'task_user',
	password: 'test',
	database: 'trayls'
});

//database function
async function asyncFunction() {
	let conn;
    const task_id = 2;

//open database port and get task_id
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT * FROM tasks WHERE task_id = ${task_id}`);
		removeMeta(rows);
        console.log(removeMeta(rows));

//it just works
	} catch (err) {
		throw err;
//it just works
	} finally {
		if (conn) {
			return conn.end();
		}
	}
}

//data parsing and data to be parsed
function removeMeta(parsedJson) {
    delete parsedJson['meta'];
	return parsedJson;
}

asyncFunction()
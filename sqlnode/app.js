const mariadb = require('mariadb');
const pool = mariadb.createPool({
    host: 'localhost',
	user: 'task_user',
	password: 'Hej123hej',
	database: 'trayls'
});
async function getTaskFromDb(table, task_id) {
	let conn;
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT * FROM ${table} traylsdb WHERE task_id = ${task_id}`);
		removeMeta(rows);
        console.log(removeMeta(rows));

	} catch (err) {
		console.log('ERROR!!!')
		throw err;
	} finally {
		if (conn) {
			return conn.end();
		}
	}
}

function removeMeta(parsedJson) {
    delete parsedJson['meta'];
	return parsedJson;
}

let value = 10;
getTaskFromDb('traylsdb', value);
getTaskFromDb('taskvalues', value);
const mariadb = require('mariadb');
const pool = mariadb.createPool({
    host: 'localhost',
	user: 'task_user',
	password: 'test',
	database: 'trayls'
});
async function asyncFunction() {
	let conn;
    const task_id = 2;
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT * FROM tasks WHERE task_id = ${task_id}`);
		removeMeta(rows);
        console.log(removeMeta(rows));

	} catch (err) {
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

asyncFunction()
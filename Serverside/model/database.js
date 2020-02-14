const {Pool} = require('pg');

const pool = new Pool();


function get_user_by_uuid(uuid) {
	return pool.query("SELECT * FROM Users WHERE UUID=$1;",[uuid]);
}

function get_item(iid) {
    return pool.query("SELECT * FROM Items WHERE IID=$1;",[iid]);
}

function get_items(lid) {
    return pool.query("SELECT * FROM Items WHERE LID=$1;",[lid]);
}

async function authenticate(lid, uuid) {
    return pool.query("SELECT Permission FROM Auth2 WHERE LID=$1 AND UUID=$2;",[lid, uuid]).then(response => response.rows);
}

function check_read(permission_array) {
    return ((permission_array.length > 0) && permission_array[0]['permission'][1] == '1');
}

function check_write(permission_array) {
    return ((permission_array.length > 0) && permission_array[0]['permission'][2] == '1');
}

function check_modify(permission_array) {
    return ((permission_array.length > 0) && permission_array[0]['permission'][3] == '1');
}

function check_admin(permission_array) {
    return ((permission_array.length > 0) && permission_array[0]['permission'][0] == '1');
}

function get_list_by_lid(response, lid) {
	pool.query("SELECT * FROM Lists WHERE LID=$1;",[lid]).then(ret => {
		if (ret.rows) {
			response.status(200).json(ret.rows[0]);
		} else {
			response.status(404);
		}
	}).catch(e => {
		console.error(e.stack);
        response.status(500);
	});
}


function create_list(response, uuid, lid, lname, rbg) {
	// insert the new lists into Lists
	var currentDate= new Date();
	// currentDate upon creation creates the current date
	// which can be used to determine its modification date
	pool.query("INSERT INTO Lists (LID, listname, Colour, Modified) VALUES ($1, $2, $3, $4);",[lid,lname,rbg,currentDate]).then(ret => {
	response.status(200).json();
	}).catch(e => {
		console.error(e.stack);
        response.status(500);
	});
}

function add_permission(response, uuid, lid) {
	// insert the new list's user's permissions into Auth
	// as this only occurs when the user is creating a list, they are the admin
	// so they have full permissions
	pool.query("INSERT INTO Auth (UUID, LID, Permission) VALUES ($1, $2, E'\\F')",[uuid,lid]).then(ret => {
	response.status(200).json();
	}).catch(e => {
		console.error(e.stack);
		response.status(500);
	});
}


module.exports = {
	db_pool: pool,
    get_user: get_user_by_uuid,
    get_item: get_item,
    get_items: get_items,
    authenticate_list: authenticate,
    can_read: check_read,
	  get_list: get_list_by_lid,
	  create_new_list: create_list,
	  get_auth: get_auth_by_id,
	  create_auth: add_permission
}
const express = require('express');
const dbclient = require('../model/database.js');

const router = express.Router();
/* GET a single item. */
async function getHandler(body) {
    const output = {};
    if ('IID' in body && 'UUID' in body) {
        const ret = await dbclient.get_item(body.IID);
        if (ret.rows) {
            const permission = await dbclient.authenticate_list(ret.rows[0].lid, body.UUID);
            if (dbclient.can_read(permission)) {
                output.status = 200;
                [output.json] = [ret.rows[0]];
            } else {
                output.status = 401;
            }
        } else {
            output.status = 404;
        }
    } else {
        output.status = 400;
    }
    return output;
}

router.get('/', async (req, res) => {
    const output = await getHandler(req.body);
    if ('json' in output) {
        res.status(output.status).json(output.json);
    } else {
        res.status(output.status).end();
    }
});

/* PUT a single item. */
async function putHandler(body) {
    const output = {};
    if ('LID' in body && 'UUID' in body && 'Name' in body) {
        const permission = await dbclient.authenticate_list(body.LID, body.UUID);
        if (dbclient.can_write(permission)) {
            await dbclient.add_item(body);
            output.status = 200;
        } else {
            output.status = 401;
        }
    } else {
        output.status = 400;
    }
    return output;
}

router.put('/', async (req, res) => {
    const output = await putHandler(req.body);
    res.status(output.status).end();
});

async function patchHandle(body) {
    const output = {};
    if ('LID' in body && 'UUID' in body) {
        const permission = await dbclient.authenticate_list(body.LID, body.UUID);
        if (dbclient.can_write(permission)) {
            await dbclient.update_item(body);
            output.status = 200;
        } else {
            output.status = 401;
        }
    } else {
        output.status = 400;
    }
    return output;
}

router.patch('/', async (req, res) => {
    const output = await patchHandle(req.body);
    res.status(output.status).end();
});

async function getCompletedHandler(body) {
    const output = {};
    if ('IID' in body) {
        const ret = await dbclient.get_completed(body.IID);
        if (ret.rows) {
            output.status = 200;
            [output.json] = [ret.rows[0]];
        } else {
            output.status = 404;
        }
    } else {
        output.status = 400;
    }
    return output;
}

router.get('/completed', async (req, res) => {
    const output = await getCompletedHandler(req.body);
    if ('json' in output) {
        res.status(output.status).json(output.json);
    } else {
        res.status(output.status).end();
    }
});

async function postCompletedHandler(body) {
    const output = {};
    if ('LID' in body && 'UUID' in body && 'Completed' in body) {
        const permission = await dbclient.authenticate_list(body.LID, body.UUID);
        if (dbclient.can_write(permission)) {
            await dbclient.set_completed(body.Completed);
            output.status = 200;
        } else {
            output.status = 401;
        }
    } else {
        output.status = 400;
    }
    return output;
}

router.post('/completed', async (req, res) => {
    const output = await postCompletedHandler(req.body);
    res.status(output.status).end();
});

// GET all items from a list.

async function getItemsHandler(body) {
    const output = {};
    if ('LID' in body && 'UUID' in body) {
        const permission = await dbclient.authenticate_list(body.LID, body.UUID);
        if (dbclient.can_read(permission)) {
            const ret = await dbclient.get_items(body.LID);
            if (ret.rows) {
                output.status = 200;
                [output.json] = [ret.rows];
            } else {
                output.status = 404;
            }
        } else {
            output.status = 401;
        }
    } else {
        output.status = 400;
    }
    return output;
}

router.get('/many', async (req, res) => {
    const output = await getItemsHandler(req.body);
    if ('json' in output) {
        res.status(output.status).json(output.json);
    } else {
        res.status(output.status).end();
    }
});

module.exports = router;

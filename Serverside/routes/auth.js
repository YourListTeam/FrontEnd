const express = require('express');

const router = express.Router();
const dbclient = require('../model/database.js');

/* GET auth listing. */
router.get('/', async (req, res) => {
    if (('UUID' in req.body) && ('LID' in req.body)) {
        const result = await dbclient.authenticate_list(req.body.LID, req.body.UUID);
        if (result) {
            res.json(result[0]);
        } else {
            res.status(404).end();
        }
    } else {
        res.status(400).end();
    }
});

/* POST auth for a given list and user. */
router.post('/admin', async (req, res) => {
    if (('UUID' in req.body) && ('LID' in req.body)) {
        await dbclient.add_user(req.body.UUID, req.body.LID, 1111);
        res.status(200).end();
    } else {
        res.status(400).end();
    }
});

/* POST user for a given list and user. */
router.post('/user', async (req, res) => {
    if (('UUID' in req.body) && ('LID' in req.body) && ('OUUID' in req.body) && ('Permission' in req.body)) {
        // only a user with admin permissions can add another user as admin
        const userPermission = await dbclient.authenticate_list(req.body.LID, req.body.UUID);
        if (dbclient.is_admin(userPermission)) {
            // string must consist of only 1s and 0s
            if (req.body.Permission.match(/^[10]+$/)) {
                if (parseInt(req.body.Permission, 2) > 0
                && parseInt(req.body.Permission, 2) <= 15) {
                    await dbclient.add_user(req.body.OUUID,
                        req.body.LID, req.body.Permission);
                    res.status(200).end();
                } else {
                    res.status(400).end();
                }
            } else {
                res.status(400).end();
            }
        } else {
            res.status(400).end();
        }
    } else {
        res.status(400).end();
    }
});

module.exports = router;

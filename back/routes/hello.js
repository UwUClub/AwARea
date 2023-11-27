import express from 'express'
const router = express.Router()

/**
 * @swagger
 * /:
 *   get:
 *     description: Returns the homepage
 *     responses:
 *       200:
 *         description: hello world
 */
router.get('/', (req, res) => {
    res.send('Hello World!')
})

export default router

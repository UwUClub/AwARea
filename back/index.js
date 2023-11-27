const express = require('express')
import{runCron} from './cron.ts'
const app = express()
const port = 8080

app.get('/', (req, res) => {res.send('Hello World!')})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
    runCron()
})

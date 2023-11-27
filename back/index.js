const swaggerJSDoc = require('swagger-jsdoc')
const swaggerUi = require('swagger-ui-express')
const express = require('express')

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

const swaggerDefinition = {
    openapi: '3.0.0',
    info: {
        title: 'Express API for JSONPlaceholder',
        version: '1.0.0',
    },
};

const options = {
    swaggerDefinition,
    // Paths to files containing OpenAPI definitions
    apis: ['./routes/*.js'],
};

const swaggerSpec = swaggerJSDoc(options)

var app = express()

const port = 8080

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec))

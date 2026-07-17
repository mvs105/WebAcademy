const express = require('express')
const calculadoraController = require('./controllers/CalculadoraController')

const app = express();

app.use(express.json())

app.post(
    '/calculadora/dividir',
    calculadoraController.dividir
)

module.exports = app
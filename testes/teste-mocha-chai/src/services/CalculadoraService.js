const calculadora = require("../models/Calculadora");

function dividir(a, b){
    if( b === 0 ){
        throw new Error("O divisor não pode ser zero");
    }
    return calculadora.dividir(a, b);
}

module.exports = {
    dividir
}
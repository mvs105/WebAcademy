const { expect } = require("chai");
const { somar, subtrair, dividir } = require("../src/models/Calculadora");

describe('Testes da calculadora', () => {

    it('Deve somar dois números', () => {
        const resultado = somar(2, 6);
        
        expect(resultado).to.equal(8);
    });

    it('Deve subtrair dois números', () => {
        const resultado = subtrair(6, 2);
        
        expect(resultado).to.equal(4);
    });

    it('Deve dividir dois números', () => {
        const resultado = dividir(2, 0.6);
        
        expect(resultado).to.equal(20/6);
    });
});
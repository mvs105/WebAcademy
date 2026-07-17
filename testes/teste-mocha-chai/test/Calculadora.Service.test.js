const { expect } = require("chai");
const { dividir } = require("../src/services/CalculadoraService");
const calculadora = require("../src/models/Calculadora");
const sinon = require("sinon");

describe('Testes da calculadoraService', () => {
    afterEach(() => {
        sinon.restore();
    });
    
    it('Deve dividir com dois números', () => {
        const stub = sinon.stub(calculadora, 'dividir');
        stub.returns(5);
        const resultado = dividir(10, 2);
        
        sinon.assert.calledOnce(stub);
        sinon.assert.calledOnceWithExactly(stub, 10, 2);
        
        expect(resultado).to.equal(5);
    });
    
    it('Deve lançar exceção', () => {      
        const stub = sinon.stub(calculadora, 'dividir');
        
        expect(() => dividir(10, 0)).to.Throw(Error);

        sinon.assert.notCalled(stub);
    });
});
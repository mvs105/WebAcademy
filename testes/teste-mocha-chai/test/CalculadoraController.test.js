const request = require('supertest');
const { expect } = require('chai');
const app = require('../src/app');
const expectCookies = require('supertest/lib/cookies');
const sinon = require('sinon')
const calculadoraService = require('../src/services/CalculadoraService');

describe('Teste API Calculadora', () => {
    afterEach(() => {
        sinon.restore();
    });
    it( 'Calculadora deve retornar status 200 sem Mock', async () => {

        const resposta = await request(app)
            .post('/calculadora/dividir')
            .send({
                a: 10,
                b: 2
            });

            expect(resposta.status).to.equal(200);
            expect(resposta.body.resultado).to.equal(5);
    });

    it( 'Calculadora deve retornar status 200 com Mock', async () => {

        const stub = sinon.stub(calculadoraService, 'dividir');
        stub.returns(5);

        const resposta = await request(app)
            .post('/calculadora/dividir')
            .send({
                a: 10,
                b: 2
            });

            expect(resposta.status).to.equal(200);
            expect(resposta.body.resultado).to.equal(5);
    })
})
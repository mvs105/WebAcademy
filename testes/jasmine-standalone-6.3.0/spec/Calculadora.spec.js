describe('Testando a calculadora', ()=>{
    
    let calc = new Calculadora();
    
    beforeEach(()=> calc = new Calculadora());
    
    it('deve somar', ()=>{
        expect(calc.somar(5,3)).toBe(8);
    });

    it('deve subtrair', ()=>{
        expect(calc.substrair(5,1)).toBe(4);
    });

    it('deve multiplicar', ()=>{
        expect(calc.multiplicar(5,2)).toBe(10);
    });
    
    it('deve dividir', ()=>{
        expect(calc.dividir(10,2)).toBe(5);
    });

    it('deve lançar exceção quando dividir por zero', ()=>{
        expect(()=> calc.dividir(10,0))
            .toThrowError('O divisor não pode ser zero');
    });
});
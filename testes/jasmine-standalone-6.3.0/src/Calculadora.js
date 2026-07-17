class Calculadora{
    somar(a,b){ 
        return a + b;
    }

    substrair(a,b){
        return a - b;
    }

    multiplicar(a,b){
        return a * b;
    }

    dividir(a,b){
        if (b === 0) {
            throw new Error('O divisor não pode ser zero');
        }
        return a / b;
    }
}
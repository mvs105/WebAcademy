const calculadoraService = require("../services/CalculadoraService")

function dividir(req, res){
    const { a, b } = req.body;

    try {
        const resultado = calculadoraService.dividir(a, b);
        return res.status(200).json({resultado});
    } catch (error) {
        return res.status(400).json({
            erro: error.message
        })
    }
}

module.exports = {
    dividir
};
package com.example.demo.repo;


import com.example.demo.models.Produto;
import net.bytebuddy.asm.Advice;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.data.jpa.test.autoconfigure.DataJpaTest;

import java.time.LocalDate;

@DataJpaTest
public class ProdutoRepo {

    @Autowired
    ProdutoRepo produtoRepo;

    @Test
    public void deveSalvarProduto(){
        Produto produto = new Produto();
        produto.setDataVencimento(new Date(2026-10-15));
        produto.setNome("Omo");
        produto.setGetQuantidadeEstoque(20);
    }
}

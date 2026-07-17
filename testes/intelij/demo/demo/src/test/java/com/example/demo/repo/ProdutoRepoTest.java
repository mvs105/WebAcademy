package com.example.demo.repo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;

class ProdutoRepoTest {

    @Test
    void deveInstanciarRepositorio() {
        ProdutoRepo produtoRepo = new ProdutoRepo();

        assertNotNull(produtoRepo);
    }
}

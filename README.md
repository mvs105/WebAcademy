# WebAcademy

Acervo de disciplinas, oficinas, exercícios, materiais de apoio e projetos desenvolvidos durante o curso WebAcademy.

## Organização do acervo

| Área | Conteúdo principal |
| --- | --- |
| [`computacao-em-nuvem/`](computacao-em-nuvem/) | Atividades de computação em nuvem |
| [`frameworks-back-end/`](frameworks-back-end/) | Aulas, atividades e projetos de frameworks back-end |
| [`frameworks-front-end/`](frameworks-front-end/) | Aulas, revisões e projetos de frameworks front-end |
| [`fundamentos-de-programação-back-end/`](fundamentos-de-programação-back-end/) | Exercícios de Java, banco de dados e aplicações web |
| [`fundamentos-de-programação-front-end/`](fundamentos-de-programação-front-end/) | Exercícios de HTML, CSS e JavaScript e projetos da disciplina |
| [`integracao-continua/`](integracao-continua/) | Atividades e projetos de integração contínua |
| [`oficina-banco-de-dados/`](oficina-banco-de-dados/) | Scripts SQL, diagramas, exercícios e materiais da oficina |
| [`programacao-avancada-back-end/`](programacao-avancada-back-end/) | Aulas, documentação e projeto de Programação Avançada Back-End |
| [`testes/`](testes/) | Exercícios, projetos e materiais sobre testes automatizados |
| [`topicos-fundamentais/`](topicos-fundamentais/) | Materiais e atividades de tópicos fundamentais |
| [`ux-e-design-thinking/`](ux-e-design-thinking/) | Área reservada para UX e Design Thinking |

## Projetos independentes

Algumas atividades possuem repositório Git próprio e são mantidas aqui como submódulos. Dessa forma, o histórico e o código de cada projeto permanecem independentes, enquanto este repositório registra a versão utilizada no acervo.

Para clonar todo o conteúdo de uma vez:

```bash
git clone --recurse-submodules <URL_DO_REPOSITORIO>
```

Se o repositório já tiver sido clonado:

```bash
git submodule update --init --recursive
```

Alterações em um submódulo devem ser commitadas primeiro dentro do próprio projeto. Depois, o novo ponteiro pode ser registrado neste repositório em um commit separado.

## Convenções de organização

- Usar uma pasta de primeiro nível para cada disciplina ou oficina.
- Preferir nomes em minúsculas e separados por hífen para novas pastas gerais.
- Preservar os nomes originais de atividades, materiais recebidos e repositórios independentes.
- Não versionar dependências, caches, configurações locais nem saídas de compilação; as regras gerais estão no [`.gitignore`](.gitignore).
- Fazer commits pequenos e descritivos, sem misturar alterações de disciplinas diferentes.

## Registros iniciais

### Fundamentos de Programação Front-End

- 18/05/2026 — Primeiros passos com HTML
- 19/05/2026 — Primeiros passos com CSS
- 22/05/2026 — Primeiros passos com JavaScript

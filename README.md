# App Shiny para Predição de Quadrigramas: Classificação de Comentários Turísticos por Domínios de Experiência

Este projeto visa desenvolver um aplicativo Shiny que utiliza um modelo de inteligência artificial para classificação de quadrigramas em comentários turísticos, definindo-os dentro dos quatro domínios da experiência turística. Para isso, utiliza-se um modelo Random Forest, gerado pelo script bash `start_app.sh`, e a utilização do modelo em projeto R/Shiny, disponível na pasta `scr/`.

O projeto foi desenvolvido como parte de Iniciação Científica (IC) na Universidade Federal do Paraná (UFPR) pela aluna Melissa Silva de Oliveira, do curso de Tecnologia em Análise e Desenvolvimento de Sistemas, em colaboração com professores e alunos da Especialização em Inteligência Artificial Aplicada e do curso de graduação em Turismo da mesma instituição.

### Estrutura do Repositório

- **`start_app.sh`**: Script bash na raiz do projeto que automatiza a criação do modelo Random Forest.
- **`scr/`**: Contém o código do projeto em R para execução do aplicativo Shiny.

## Execução Local

Para rodar o projeto em sua máquina local, siga as etapas abaixo:

1. **Permitir a Execução do Script Bash:**  
   No terminal, navegue até a pasta raiz do projeto e torne o script `start_app.sh` executável com o comando:
   ```bash
   chmod +x start_app.sh
   ```

2. **Executar o Script Bash:**  
   Em seguida, execute o script para iniciar o processo de geração do modelo de classificação, usando:
   ```bash
   ./start_app.sh
   ```

3. **Executar o App Shiny Localmente:**  
   Após o processo de inicialização, abra o projeto R localizado na pasta `./src/` usando o RStudio. Em seguida, execute o app Shiny localmente para visualizar os resultados.

## Acesso Online

Alternativamente, você pode acessar o aplicativo Shiny por meio do seguinte link: [Acessar o App Shiny](https://melissa-oliveira.shinyapps.io/shiny-quadrigram-predictor-R/).

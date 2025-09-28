# Sistema Especialista para Recomendação de Trilha Acadêmica

## Aluna
Natália Moritani Trevisol

## Instituição
- Pontifícia Universidade Católica do Paraná (PUCPR)
- Disciplina: Programação Lógica e Funcional
- Professor: Frank Coelho de Alcantara
  
## Resumo
Sistema especialista em Prolog que recomenda trilhas acadêmicas de especialização (ex.: `inteligencia_artificial`, `ciencia_de_dados`, `gestao_de_ti`, `computacao_em_nuvem`, `ciberseguranca`) com base nos interesses e afinidades do aluno. O sistema faz um questionário dinâmico, armazena respostas com `assertz/1`, calcula compatibilidade por pesos das características das trilhas nos perfis e exibe justificativas.

## Como executar

### Arquivos
* Baixar os arquivos/diretórios em sua máquina.
- sistema.pl: código principal e base de conhecimento
- testes/: 3 arquivos de perfil para testes (`src/testes/perfil_teste_1.pl`, `perfil_teste_2.pl`, `perfil_teste_3.pl`) contendo fatos (`resposta(Id, s/n)`).

### Requisitos
- SWI-Prolog (recomenda-se a versão estável mais recente)
- ou SWISH online (https://swish.swi-prolog.org).

### Instalação (Windows)
1. Baixe o instalador em: página oficial de downloads do SWI-Prolog (https://www.swi-prolog.org/download/devel).  
2. Execute o instalador e marque a opção de adicionar ao `PATH`.  
3. Abra `PowerShell` e rode `swipl` para confirmar a instalação.  

### macOS
```bash
brew install swi-prolog 
```
### ubuntu/debian
```bash
sudo add-apt-repository ppa:swi-prolog/stable
sudo apt update
sudo apt install swi-prolog
```
### Modo interativo
1. Abra o SWI-Prolog na pasta src
```bash
cd trilha_academica
swipl
```
2. ?- consult('sistema.pl').
3. ?- iniciar.
4. Responder às perguntas com "s" ou "n".
5. As trilhas/justificativas serão mostradas.

### Modo de teste (automático)
1. Abra o SWI-Prolog na pasta src
```bash
cd trilha_academica
swipl
```
2. ?- consult('sistema.pl').
3. ?- consult('testes/perfil_teste_1.pl'). 
ou ?- consult('testes/perfil_teste_2.pl').
ou ?- consult('testes/perfil_teste_3.pl').
4. ?- iniciar_test.
5. As trilhas/justificativas serão mostradas.

### Rodar online (sem instalar nada)

Também é possível testar o sistema diretamente no navegador via **SWISH**:

1. Acesse [SWISH](https://swish.swi-prolog.org).
2. Crie um novo programa (New → Program).
3. Copie e cole o conteúdo de `sistema.pl`.
   - Para rodar em modo de teste, cole também o conteúdo de `testes/perfil_teste_X.pl`, logo depois do código de `sistema.pl`.
4. Clique em **Run!** ou execute no console:
   ```prolog
   ?- iniciar.
   ```
   ou para o modo teste:
   ```prolog
   ?- iniciar_test.
   ```
5. No modo interativo responda às perguntas com "s" ou "n" e clique em "Send".
   
## Observações
- Cada trilha (5 no total) e perfil foi definido em conformidade com o enunciado.
- Foram retirados acentos gráficos do código (partes de impressão na tela) para melhor limpeza e visualização.

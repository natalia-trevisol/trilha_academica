# Sistema Especialista para Recomendação de Trilha Acadêmica

## Aluna
Natália Moritani Trevisol

## Instituição
- Pontifícia Universidade Católica do Paraná
- Disciplina: Programação Lógica e Funcional
- Professor: Frank Coelho de Alcântara
  
## Resumo
Sistema especialista em Prolog que recomenda trilhas acadêmicas de especialização (ex.: `inteligencia_artificial`, `ciencia_de_dados`, `gestao_de_ti`, `computacao_em_nuvem`, `ciberseguranca`) com base nos interesses e afinidades do aluno. O sistema faz um questionário dinâmico, armazena respostas com `assertz/1`, calcula compatibilidade por pesos das características das trilhas nos perfis e exibe justificativas.

## Como executar

### Requisitos
- SWI-Prolog (recomenda-se a versão estável mais recente)

### Instalação (Windows)
1. Baixe o instalador em: página oficial de downloads do SWI-Prolog.  
2. Execute o instalador e marque a opção de adicionar ao `PATH` (se disponível).  
3. Abra `PowerShell` e rode `swipl` para confirmar a instalação.  
(Para instruções detalhadas e downloads oficiais consulte a página de download do SWI-Prolog). :contentReference[oaicite:6]{index=6}

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
2. ?- consult('sistema.pl').
3. ?- iniciar.

### Modo de teste (automático)
1. ?- consult('sistema.pl').
2. ?- consult('testes/perfil_teste_1.pl').
3. ?- iniciar_test.

## Arquivos
- sistema.pl: código principal e base de conhecimento
- testes/: 3 arquivos de perfil para testes (`src/testes/perfil_teste_1.pl`, `perfil_teste_2.pl`, `perfil_teste_3.pl`) contendo fatos (`resposta(Id, s/n)`).


## Observações
- Cada trilha e perfil foi definido em conformidade com o enunciado.

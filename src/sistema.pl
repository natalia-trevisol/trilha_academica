% ============== sistema.pl ==============
% Sistema Especialista para Recomendação de Trilha Acadêmica
% Predicado obrigatório: iniciar/0.
% O programa utiliza assertz/1 para armazenar respostas dinamicamente.
% Para carregar testes, existe o predicado carregar_test/1 que usa consult/1.

% Fatos dinâmicos (pode alterar predicado durante execução)
:- dynamic resposta/2.
:- dynamic respondido/1.

% ---------------------------
% Base de conhecimento
% ---------------------------
% trilha(Nome, Descrição).
trilha(inteligencia_artificial, 'IA: Aprendizado de maquina, redes neurais e visao computacional.').
trilha(ciencia_de_dados, 'Ciencia de Dados: analise de dados, estatistica e visualizacao.').
trilha(gestao_de_ti, 'Gestao de TI: planejamento e gerenciamento de projetos tecnologicos.').
trilha(computacao_em_nuvem, 'Computacao em Nuvem: gestao de infraestruturas e servicos na nuvem.').
trilha(ciberseguranca,'Ciberseguranca: protecao de sistemas e dados.').

% perfil(Trilha, Caracteristica, Peso).
% peso: 1 (baixo) .. 5 (alto)
perfil(inteligencia_artificial, matematica_estatistica, 5).
perfil(inteligencia_artificial, programacao_python, 4).
perfil(inteligencia_artificial, aprendizado_maquina, 5).
perfil(inteligencia_artificial, processamento_dados, 4).
perfil(inteligencia_artificial, robotica, 4).

perfil(ciencia_de_dados, matematica_estatistica, 5).
perfil(ciencia_de_dados, manipulacao_dados, 5).
perfil(ciencia_de_dados, visualizacao, 4).
perfil(ciencia_de_dados, processamento_dados, 5).
perfil(ciencia_de_dados, aprendizado_maquina, 3).
perfil(ciencia_de_dados, negocios, 4).
perfil(ciencia_de_dados, programacao_python, 3).
perfil(ciencia_de_dados, performance, 3).

perfil(gestao_de_ti, lideranca, 5).
perfil(gestao_de_ti, planejamento_estrategico, 5).
perfil(gestao_de_ti, consultoria, 4).
perfil(gestao_de_ti, infraestrutura, 3).
perfil(gestao_de_ti, negocios, 3).
perfil(gestao_de_ti, visualizacao, 3).
perfil(gestao_de_ti, comunicacao, 3).

perfil(computacao_em_nuvem, infraestrutura, 5).
perfil(computacao_em_nuvem, planejamento_estrategico, 3).
perfil(computacao_em_nuvem, manipulacao_dados, 2).
perfil(computacao_em_nuvem, redes, 4).
perfil(computacao_em_nuvem, performance, 3).
perfil(computacao_em_nuvem, protecao_dados, 3).

perfil(ciberseguranca, redes, 5).
perfil(ciberseguranca, performance, 2).
perfil(ciberseguranca, protecao_dados, 5).
perfil(ciberseguranca, infraestrutura, 3).
perfil(ciberseguranca, manipulacao_dados, 3).
perfil(ciberseguranca, consultoria, 3).

% pergunta(Id, TextoPergunta, CaracteristicaRelacionada).
pergunta(1, 'Voce tem afinidade com matematica e estatistica? (s/n)', matematica_estatistica).
pergunta(2, 'Voce gosta de programar em Python? (s/n)', programacao_python).
pergunta(3, 'Interesse em aprendizado de maquina / IA? (s/n)', aprendizado_maquina).
pergunta(4, 'Voce gosta de manipular/limpar grandes conjuntos de dados? (s/n)', manipulacao_dados).
pergunta(5, 'Gosta de criar visualizacoes/graficos de dados? (s/n)', visualizacao).
pergunta(6, 'Interesse em robotica? (s/n)', robotica).
pergunta(7, 'Gosta de modelar/gerenciar infraestruturas? (s/n)', infraestrutura).
pergunta(8, 'Voce gosta de manipular/configurar redes? (s/n)', redes).
pergunta(9, 'Voce tem interesse voltado para negocios? (s/n)', negocios).
pergunta(10, 'Voce tem afinidade com planejamento e organizacao? (s/n)', planejamento_estrategico).
pergunta(11, 'Voce se interessa em melhorar a performance/eficiencia de sistemas? (s/n)', performance).
pergunta(12, 'Interesse em seguranca e protecao de dados? (s/n)', protecao_dados).
pergunta(13, 'Voce tem interesse em processar e transformar dados em solucoes? (s/n)', processamento_dados).
pergunta(14, 'Gosta de trabalhar com o cliente e prestar consultoria? (s/n)', consultoria).
pergunta(15, 'Gosta de ser lider de equipes e tomar decisoes? (s/n)', lideranca).
pergunta(16, 'Tem boas habilidades comunicativas? (s/n)', comunicacao).

% ---------------------------
% Predicado principal que inicia a interação
% ---------------------------
iniciar :-
    retractall(resposta(_, _)),  % limpa respostas antigas
    retractall(respondido(_)),  % limpa marcações de respondido
    writeln('--- Sistema de Recomendacao de Trilha Academica de Especializacao ---'),
    writeln('Responda as perguntas com s ou n.'),
    perguntar,                 % conduz o questionário interativo (dispara perguntas)
    calcular_pontuacoes(Scores),
    ordenar_exibir(Scores).

% ---------------------------
% Fluxo de perguntas (interativo)
% ---------------------------
perguntar :-
    findall(Id, pergunta(Id, _, _), Ids),  % monta lista de ids das perguntas
    perguntar_lista(Ids).

perguntar_lista([]).      % predicado recursivo, processa cada id
perguntar_lista([Id|T]) :-
    pergunta(Id, Texto, Carac),  %recupera texto e caracteristica
    fazer_pergunta(Id, Texto, Carac),   %mostra a pergunta, le e armazena resposta
    perguntar_lista(T).

fazer_pergunta(Id, Texto, _) :-
    ( resposta(Id, _) -> true  %pula perguntas já respondidas (arquivo de teste ou resposta anterior)
    ;
      format('\n~w\n', [Texto]), %mostra a pergunta formatada
      ler_resposta(R),    % le resposta e armazena em R
      ( R = s -> assertz(resposta(Id, s)), assertz(respondido(Id))   %se sim; assertz(resposta()) insere o predicado no banco dinamico
      ; R = n -> assertz(resposta(Id, n)), assertz(respondido(Id))   %se não; assertz(respondido()) marca se a pergunta foi respondida
      ; writeln('Resposta invalida. Digite s (sim) ou n (nao).'), fazer_pergunta(Id, Texto, _)
      )
    ).

ler_resposta(R) :-
    read_line_to_codes(user_input, Codes),   % le linha de entrada como codigos numericos
    atom_codes(A, Codes),   % transforma os Codes em atomos A
    ( (A = 's'; A = 'S') -> R = s    %clausula normaliza 
    ; (A = 'n'; A = 'N') -> R = n
    ; R = invalid
    ).

% ---------------------------
% Cálculo de pontuações
% ---------------------------
% calcular_pontuacoes(-Scores) onde Scores é lista [Trilha-Pont|...]
calcular_pontuacoes(Scores) :-
    findall(Trilha, trilha(Trilha, _), Trilhas),  %lista de trilhas
    maplist(pontuacao_trilha, Trilhas, Scores). %aplica pontuacao_trilha a cada trilha produzindo lista Scores
                                               % cada elemento de Scores é trilha-pont

% pontuacao_trilha(+Trilha, -Trilha-Pontuacao)
pontuacao_trilha(Trilha, Trilha-Pont) :-
    findall(Peso*Carac, perfil(Trilha, Carac, Peso), Lista), %para uma trilha, coleta todos os perfil()
    % monta Lista, formato Peso*Carac
    calcular_soma_respostas(Lista, 0, Pont).  %soma peso das carac que user repondeu "s"

% calcular_soma_respostas(+ListaPesoCarac, +Acumulador, -Total); recursivo
calcular_soma_respostas([], Acc, Acc). %lista vazia
calcular_soma_respostas([Peso*Carac | T], Acc, Total) :-
    % Procura resposta dada para a pergunta que mapeia essa caracteristica
    % Encontra qual pergunta tem esse Carac.
    ( pergunta(Id, _, Carac),  %busca id da pergunta com a carac
      resposta(Id, s) ->      %se user respondeu "s" adiciona peso ao acc
        NewAcc is Acc + Peso
    ; NewAcc = Acc   %nenhuma adicao, else
    ),
    calcular_soma_respostas(T, NewAcc, Total).

% ---------------------------
% Ordenar e exibir ranking
% ---------------------------
% Ordena por pontuacao decrescente usando predsort/3 (sort customizado, definir como 2 elementos sao comparados)
ordenar_exibir(Scores) :-
    predsort(compare_scores_desc, Scores, Sorted),  %ordena lista Scores, vira Sorted
    format('\n=== Recomendacoes (ordem decrescente) ===\n', []),
    exibir_sorted(Sorted), %percorre Sorted com trilha, pontuacao e descricao
    format('\n=== Justificativas ===\n', []),
    exibir_justificativas(Sorted). %quais perguntas (cada trilha) contribuiram p/ pontuacao

% comparador para predsort: com a maior pontuacao primeiro
compare_scores_desc(Order, _T1-S1, _T2-S2) :-  %trilha1-pontuacao1
    ( S1 > S2 -> Order = '<'  %se pont do 1 maior que 2, vai antes na lista
    ; S1 < S2 -> Order = '>'  %contrario
    ; Order = '=' ). %else, pontuacoes iguais qualquer ordem

% exibir_sorted(+Lista)
exibir_sorted([]).  %percorre lista e imprime Trilha: pontos - descricao
exibir_sorted([Trilha-P|T]) :-
    trilha(Trilha, Desc),  %busca descricao
    format('~w: ~w pontos - ~w~n', [Trilha, P, Desc]),
    exibir_sorted(T).

% para cada trilha exibe quais caracteristicas (perguntas com s)
exibir_justificativas([]).
exibir_justificativas([Trilha-_|T]) :-  
    format('~nJustificativa para ~w:~n', [Trilha]),
    findall((Q,Carac), (pergunta(Q, Perg, Carac), resposta(Q, s)), Pairs),
    % Filtrar Pairs para apenas aquelas que aparecem no perfil da trilha (perguntas que receberam s)
    forall(member((Q,Carac), Pairs),
           ( perfil(Trilha, Carac, Peso) ->   %verifica se carac ta no perfil
               pergunta(Q, Texto, _),   %se sim busca texto da pergunta
               format(' - Pergunta ~w (~w) contribuiu com peso ~w~n', [Q, Texto, Peso])
           ; true
           )),  %quais perguntas com 's' contribuíram p/ pontuação de cada trilha e com qual peso
    exibir_justificativas(T). 
	
% ---------------------------
% Modo de teste automático
% Carrega respostas do arquivo de teste (resposta/2 facts) e roda apenas o cálculo
% ---------------------------
carregar_test(Arquivo) :-
    retractall(resposta(_, _)),  %remove respostas antigas
    retractall(respondido(_)),   %remove marcacoes
    consult(Arquivo),   %carrega o arquivo (deve conter fatos resposta(id, s/n))
    % marcar respondido para cada resposta carregada
    forall(resposta(Id, _), assertz(respondido(Id))).
	% para cada resposta, marca pergunta respondida (coerencia com modelo interativo)

iniciar_test :-
    findall(Id, resposta(Id, _), Ids),
    length(Ids, N),
    format('--- Modo de Teste ---~nRespostas carregadas: ~w~n', [N]),
    ( N =:= 0 ->
        writeln('Aviso: nenhuma resposta carregada. Execute carregar_test/1 primeiro.')
    ; calcular_pontuacoes(Scores),
      ordenar_exibir(Scores)
    ).
% ---------------------
% FIM sistema.pl

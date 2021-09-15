cesta(amarela).
cesta(azul).
cesta(branca).
cesta(verde).
cesta(vermelha).

ovo(amargo).
ovo(ao_leite).
ovo(branco).
ovo(crocante).
ovo(recheado).

peso(125).
peso(150).
peso(175).
peso(200).
peso(225).

mae(debora).
mae(erica).
mae(leticia).
mae(natalia).
mae(maria).

filho(diego).
filho(everton).
filho(jonas).
filho(leonardo).
filho(murilo).

profissao(editora).
profissao(florista).
profissao(massagista).
profissao(pesquisadora).
profissao(secretaria).

% X está entre Y e Z (em qualquer posição no meio)
entre(X,Y,Z,Lista) :- aEsquerda(X,Z,Lista), aDireita(X,Y,Lista).

% X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X),
                        nth0(IndexY,Lista,Y),
                        IndexX < IndexY.

% X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista).

% X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).

% X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

% Verifica se todos os elementos da lista sao diferentes
todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).                    

solucao(ListaSolucao) :- 
    ListaSolucao = [
        mae(Cesta1, Ovo1, Peso1, Mae1, Filho1, Profissao1),
        mae(Cesta2, Ovo2, Peso2, Mae2, Filho2, Profissao2),
        mae(Cesta3, Ovo3, Peso3, Mae3, Filho3, Profissao3),
        mae(Cesta4, Ovo4, Peso4, Mae4, Filho4, Profissao4),
        mae(Cesta5, Ovo5, Peso5, Mae5, Filho5, Profissao5)
    ],

    % Estrutura: (_, _, _, _, _, _)    
    %A Florista está na segunda posição. 
    Profissao2 = florista,

    %Leonardo vai ganhar um ovo de 200 g.
    member(mae(_, _, 200, _, leonardo, _), ListaSolucao),

    %Em uma das pontas está a mãe que está comprando o menor ovo.
    noCanto(mae(_, _, 125, _, _, _), ListaSolucao),    

    %A mãe da cesta Verde está ao lado da mãe da cesta Amarela.
    aoLado(mae(verde, _, _, _, _, _), mae(amarela, _, _, _, _, _), ListaSolucao),

    %Na quinta posição está a Secretária.
    Profissao5 = secretaria,

    %Natália está exatamente à direita da mãe que está comprando o ovo Recheado.
    aoLado(mae(_, _, _, natalia, _, _), mae(_, recheado, _, _, _, _), ListaSolucao),
    aDireita(mae(_, _, _, natalia, _, _), mae(_, recheado, _, _, _, _), ListaSolucao),

    %A mãe da cesta Amarela está em algum lugar entre a que está comprando o ovo mais pesado e a Érica, nessa ordem.
    entre(mae(amarela, _, _, _, _, _), mae(_, _, 225, _, _, _), mae(_, _, _, erica, _, _), ListaSolucao),

    %A Massagista está comprando o ovo Branco.
    member(mae(_, branco, _, _, _, massagista), ListaSolucao),

    %A mãe do Diego está ao lado de Débora.
    aoLado(mae(_, _, _, _, diego, _), mae(_, _, _, debora, _, _), ListaSolucao),

    %Na quinta posição está a mãe da cesta Branca.
    Cesta5 = branca,

    %A Editora está ao lado da mãe do Murilo.
    aoLado(mae(_, _, _, _, _, editora), mae(_, _, _, _, murilo, _), ListaSolucao),

    %Na segunda posição está a mãe que está comprando o ovo Crocante.
    Ovo2 = crocante,

    %A mãe de Leonardo está em algum lugar entre a mãe da cesta Verde e a mãe de Jonas, nessa ordem.
    entre(mae(_, _, _, _, leonardo, _), mae(verde, _, _, _, _, _), mae(_, _, _, _, jonas, _), ListaSolucao),

    %A Massagista está exatamente à esquerda da Érica.
    aoLado(mae(_, _, _, _, _, massagista), mae(_, _, _, erica, _, _), ListaSolucao),
    aEsquerda(mae(_, _, _, _, _, massagista), mae(_, _, _, erica, _, _), ListaSolucao),

    %Éverton vai ganhar um ovo de 125 g.
    member(mae(_, _, 125, _, everton, _), ListaSolucao),

    %Letícia está em algum lugar entre a Pesquisadora e a mãe que vai comprar o ovo de 175 g, nessa ordem.
    entre(mae(_, _, _, leticia, _, _), mae(_, _, _, _, _, pesquisadora), mae(_, _, 175, _, _, _), ListaSolucao),

    %A Editora está exatamente à direita da Florista.
    aoLado(mae(_, _, _, _, _, editora), mae(_, _, _, _, _, florista), ListaSolucao),
    aDireita(mae(_, _, _, _, _, editora), mae(_, _, _, _, _, florista), ListaSolucao),

    %A mãe do Leonardo está na terceira posição.
    Filho3 = leonardo,

    %A mãe da cesta Azul está ao lado da mãe que vai comprar o ovo de 200 g.
    aoLado(mae(azul, _, _, _, _, _), mae(_, _, 200, _, _, _), ListaSolucao),

    %A mãe da cesta Vermelha está comprando o ovo de 200 g.
    member(mae(vermelha, _, 200, _, _, _), ListaSolucao),

    %Débora está ao lado da mãe que está comprando o ovo ao Leite.
    aoLado(mae(_, _, _, debora, _, _), mae(_, ao_leite, _, _, _, _), ListaSolucao),

    %Testa todas as possibilidades...
    cesta(Cesta1), cesta(Cesta2), cesta(Cesta3), cesta(Cesta4), cesta(Cesta5),
    todosDiferentes([Cesta1, Cesta2, Cesta3, Cesta4, Cesta5]),
    
    ovo(Ovo1), ovo(Ovo2), ovo(Ovo3), ovo(Ovo4), ovo(Ovo5),
    todosDiferentes([Ovo1, Ovo2, Ovo3, Ovo4, Ovo5]),
    
    peso(Peso1), peso(Peso2), peso(Peso3), peso(Peso4), peso(Peso5),
    todosDiferentes([Peso1, Peso2, Peso3, Peso4, Peso5]),
    
    mae(Mae1), mae(Mae2), mae(Mae3), mae(Mae4), mae(Mae5),
    todosDiferentes([Mae1, Mae2, Mae3, Mae4, Mae5]),
    
    filho(Filho1), filho(Filho2), filho(Filho3), filho(Filho4), filho(Filho5),
    todosDiferentes([Filho1, Filho2, Filho3, Filho4, Filho5]),
    
    profissao(Profissao1), profissao(Profissao2), profissao(Profissao3), profissao(Profissao4), profissao(Profissao5),
    todosDiferentes([Profissao1, Profissao2, Profissao3, Profissao4, Profissao5]).
:- op(20,xfy,?=).

% Prédicats d'affichage fournis

% set_echo: ce prédicat active l'affichage par le prédicat echo
set_echo :- assert(echo_on).

% clr_echo: ce prédicat inhibe l'affichage par le prédicat echo
clr_echo :- retractall(echo_on).

% echo(T): si le flag echo_on est positionné, echo(T) affiche le terme T
%          sinon, echo(T) réussit simplement en ne faisant rien.

echo(T) :- echo_on, !, write(T).
echo(_).


regle(X?=T,rename):- var(X),var(T).


regle(X?=T,simplify) :- var(X),atomic(T).


regle(X?=T,expand):- compound(T),var(X),not(occur_check(X,T)).

regle(X?=T,check):- not(X==T),occur_check(X,T).


regle(X?=T,orient):- nonvar(X),var(T).

regle(X?=T,decompose):- compound(X),compound(T),functor(X,Y,Z),functor(T,Y2,Z2),Y==Y2,Z==Z2.

regle(X?=T,clash):- compound(X),compound(T),functor(X,Y,Z),functor(T,Y2,Z2),not(Z==Z2),not(Y==Y2).



occur_check(V,T):- var(V),compound(T),arg(_,T,TT),occur_check(V,TT).
occur_check(V,T):- var(T),V==T.

:- op(20,xfy,?=).

% Pr�dicats d'affichage fournis

% set_echo: ce pr�dicat active l'affichage par le pr�dicat echo
set_echo :- assert(echo_on).

% clr_echo: ce pr�dicat inhibe l'affichage par le pr�dicat echo
clr_echo :- retractall(echo_on).

% echo(T): si le flag echo_on est positionn�, echo(T) affiche le terme T
%          sinon, echo(T) r�ussit simplement en ne faisant rien.

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

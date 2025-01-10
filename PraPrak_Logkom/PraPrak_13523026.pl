/* BAGIAN 1 */

/* Deklarasi Fakta */
pria(qika).
pria(panji).
pria(shelby).
pria(barok).
pria(aqua).
pria(eriq).
pria(francesco).
wanita(hinatsuru).
wanita(makio).
wanita(suma).
wanita(frieren).
wanita(yennefer).
wanita(roxy).
wanita(ruby).
wanita(suzy).
wanita(aihoshino).
wanita(eve).
usia(hinatsuru,105).
usia(qika,109).
usia(makio,96).
usia(suma,86).
usia(panji,124).
usia(frieren,90).
usia(shelby,42).
usia(yennefer,61).
usia(barok,59).
usia(roxy,70).
usia(aqua,66).
usia(ruby,63).
usia(eriq,69).
usia(aihoshino,48).
usia(suzy,23).
usia(francesco,25).
usia(eve,5).
menikah(hinatsuru,qika).
menikah(qika,hinatsuru).
menikah(qika,makio).
menikah(makio,qika).
menikah(qika,suma).
menikah(suma,qika).
menikah(panji,frieren).
menikah(frieren,panji).
menikah(barok,roxy).
menikah(roxy,barok).
menikah(ruby,eriq).
menikah(eriq,ruby).
menikah(suzy,francesco).
menikah(francesco,suzy).
anak(shelby,hinatsuru).
anak(shelby,qika).
anak(yennefer,hinatsuru).
anak(yennefer,qika).
anak(barok,qika).
anak(barok,makio).
anak(aqua,panji).
anak(aqua,frieren).
anak(ruby,panji).
anak(ruby,frieren).
anak(suzy,barok).
anak(suzy,roxy).
anak(aihoshino,ruby).
anak(aihoshino,eriq).
anak(eve,suzy).
anak(eve,francesco).

/* deklarasi Rules */
saudara(X,Y) :- anak(X,Z),anak(Y,Z),X\=Y.
saudaratiri(X,Y) :- anak(X,Z),anak(Y,W),menikah(Z,V),menikah(W,V),Z\=W.
kakak(X,Y) :- saudara(X,Y),usia(X,Z),usia(Y,W),Z>W.
keponakan(X,Y) :- anak(X,Z),saudara(Y,Z).
mertua(X,Y) :- menikah(Y,Z),anak(Z,X).
nenek(X,Y) :- wanita(X),anak(Y,Z),anak(Z,X).
keturunan(X,Y) :- anak(X,Z),anak(Z,W),anak(W,Y).
lajang(X) :- (pria(X) ; wanita(X)), \+ menikah(X,_).
anakbungsu(X) :- anak(X,Y),\+ (anak(Z,Y),usia(X,W),usia(Z,V),W>V).
anaksulung(X) :- anak(X,Y),\+ (anak(Z,Y),usia(X,W),usia(Z,V),W<V).
yatimpiatu(X) :- (pria(X) ; wanita(X)), \+ anak(X,_).

/****************************************************************************************/
/* BAGIAN 2 */

/* exponent(A, B, X). */
exponent(_,0,1).
exponent(A,B,X) :- B>0,B1 is B-1,exponent(A,B1,X1),X is A*X1.


/* growth(I,G,H,T,X). */
factor(X,Y) :- Y * Y =< X, X mod Y =:= 0.
factor(X,Y) :- Y * Y =< X, Y1 is Y + 1, factor(X,Y1).

prima(2).
prima(X) :- X > 2, \+ factor(X,2).

factor1(X,Y) :- Y*Y =< X, (X mod Y =:= 0; Y1 is Y + 1, factor1(X,Y1)).

growth(I,_,_,T,X) :- T =:= 0, X = I.
growth(I,G,H,T,X) :- T>0, 
    (prima(T) -> T1 is T-1, I1 is I+G, growth(I1,G,H,T1,X)
    ;           T1 is T-1, I1 is I-H, growth(I1,G,H,T1,X)
    ).

/* harvestFruits(N, Fruits, TreeNumber, FinalFruits) */
harvestFruits(_,Fruits,_,FinalFruits) :- Fruits =< 0, FinalFruits is 0, write('Si Imut pulang sambil menangis :('), !.

harvestFruits(N,Fruits,TreeNumber,FinalFruits) :- TreeNumber > N,FinalFruits is Fruits,!.

harvestFruits(N,Fruits,TreeNumber,FinalFruits) :- 
    TreeNumber =< N,
    Fruits>0,
    (TreeNumber mod 3 =:= 0 -> Fruits1 is Fruits + 2; Fruits1 is Fruits), 
    (TreeNumber mod 4 =:= 0 -> Fruits2 is Fruits1 - 5; Fruits2 is Fruits1),
    (TreeNumber mod 5 =:= 0 -> Fruits3 is Fruits2 + 3; Fruits3 is Fruits2),
    (prima(TreeNumber) -> Fruits4 is Fruits3 - 10; Fruits4 is Fruits3),
    TreeNumber1 is TreeNumber + 1, 
    harvestFruits(N,Fruits4,TreeNumber1,FinalFruits).


/* kpk(A,B,X) */
fpb(A,B,A) :- A =:= B.
fpb(A,B,X) :- A>B, A1 is A-B,fpb(A1,B,X).
fpb(A,B,X) :- A<B, B1 is B-A,fpb(A,B1,X).
kpk(A,B,X) :- fpb(A,B,X1), X is (A*B)//X1.


/* factorial(N,X) */
factorial(0,1).
factorial(N,X) :- N>0,N1 is N-1,factorial(N1,X1),X is N*X1.


/* Make Pattern */
printRow(N,Row,Col) :-
    Col =< N,
    Top is Row,
    Left is Col,
    Bottom is N - Row + 1,
    Right is N - Col + 1,
    (
        Top =< Left,
        Top =< Bottom,
        Top =< Right -> D = Top;
        Left =< Top,
        Left =< Bottom,
        Left =< Right -> D = Left;
        Bottom =< Top,
        Bottom =< Left,
        Bottom =< Right -> D = Bottom;
        D = Right
    ),
    write(D),
    write(' '),
    NextCol is Col + 1,
    printRow(N,Row,NextCol).

printRow(N,_,Col) :-
    Col > N.
    
makeRow(N,Row) :-
    Row =< N,
    printRow(N,Row,1),
    nl,
    NextRow is Row + 1,
    makeRow(N,NextRow).

makeRow(N,Row) :-
    Row > N.

makePattern(N) :-
    makeRow(N,1).

/****************************************************************************************/
/* BAGIAN 3 */

/* List Statistic */
min([X],X).
min([H|T],Min) :- min(T,Tail),(H<Tail -> Min = H; Min = Tail).

max([X],X).
max([H|T],Max) :- max(T,Tail),(H>Tail -> Max=H ; Max = Tail).

range(List,Range) :- min(List,Min), max(List,Max), Range is Max-Min.

count([],0).
count([_|T],Count) :-
    count(T,Count1),
    Count is Count1 + 1.

sum([],0).
sum([H|T],Total) :-
    sum(T,Tail),
    Total is Tail + H.


/* List Manipulation */
/* mergeSort */
mergeSort([],ListB,ListB).
mergeSort(ListA,[],ListA).
mergeSort([H1|T1],[H2|T2],[H1|T3]) :- H1=<H2,mergeSort(T1,[H2|T2],T3).
mergeSort([H1|T1],[H2|T2],[H2|T3]) :- H1>H2,mergeSort([H1|T1],T2,T3).


/* filterArray */
filterArray([],_,_,[]).
filterArray([H|T],Element1,Element2,[H|Result]) :- H>Element1, 0 is H mod Element2, filterArray(T,Element1,Element2,Result).
filterArray([_|T],Element1,Element2,Result) :- filterArray(T,Element1,Element2,Result).


/* reverse */
reverse1([],[]).
reverse1([H|T],Reverse) :- reverse1(T,Tail),append(Tail,[H],Reverse).


/* cekPalindrom */
cekPalindrom(List) :- reverse1(List,Reverse), List = Reverse.


/* rotate */
putar(List,0,List).
putar([H|T],N,Result) :-
    N > 0,
    N1 is N - 1,
    putar(T,N1,Tail),
    add(Tail,H,Result).

add([],A,[A]).
add([H|T],A,[H|Result]) :- add(T,A,Result).

abs1(X,AbsX) :- X>=0,AbsX is X.
abs1(X,AbsX) :- X<0,AbsX is -X.

rotate([],_,[]).
rotate(List,N,Result) :-
    N >= 0,
    count(List,Count),
    N1 is N mod Count,
    putar(List,N1,Result).

rotate(List,N,Result) :-
    N < 0,
    count(List,Count),
    abs1(N,AbsN),
    N1 is Count-(AbsN mod Count),
    putar(List,N1,Result).


/* mapping */
grades(Nilai,'A') :- Nilai >= 80.
grades(Nilai,'B') :- Nilai >= 70, Nilai < 80.
grades(Nilai,'C') :- Nilai >= 60, Nilai < 70.
grades(Nilai,'D') :- Nilai >= 50, Nilai < 60.
grades(Nilai,'E') :- Nilai < 50.

rata(List,Rata2) :-
    sum(List,Total),
    count(List,Count),
    Count > 0,
    Rata2 is Total/Count.

konversi([],[]).
konversi([H|T],[H1|T1]) :-
    grades(H,H1),
    konversi(T,T1).

prosesMahasiswa(Name,Grades,Result) :-
    konversi(Grades,Huruf),
    rata(Grades,Rata2),
    (Rata2 >= 80 -> Status = 'Pass'; Status = 'Fail'),
    Result = [Name, Huruf, Rata2, Status].
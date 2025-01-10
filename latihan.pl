/* ibu(X,Y) artinya X adalah ibu dari Y */
ibu(emy,charles).
ibu(emy,david).
ibu(emy,randy).
ibu(maria,fara).

/* saudara_kandung1(X,Y) artinya X adalah saudara kandung dari Y */
saudara_kandung1(Anak1,Anak2) :- ibu(Ibu,Anak1), ibu(Ibu,Anak2).
saudara_kandung2(Anak1,Anak2) :- ibu(Ibu,Anak1), ibu(Ibu,Anak2), Anak1 \== Anak2.
/* perhatikan bahwa =\= hanya bisa digunakan untuk aritmetik */
saudara_kandung3(Anak1,Anak2) :- ibu(Ibu,Anak1), ibu(Ibu,Anak2), Anak1 =\= Anak2.
/* query
saudara_kandung1(charles,david).
saudara_kandung1(charles,fara).
saudara_kandung1(Siapa1,Siapa2).
saudara_kandung2(Siapa1,Siapa2).
saudara_kandung3(Siapa1,Siapa2).
*/


/* max2(X,Y,Z) artinya Z adalah nilai maksimum dari X dan Y */
/* berbeda jika memberikan cut pada akhir rules max2(X,Y,X) dimana max2(X,Y,Y) tidak akan dicari solusinya*/
max2(X,Y,X) :- X >= Y.
max2(X,Y,Y) :- X < Y.
/* query
max2(3,5,Z).
max2(5,3,4).
max2(7,3,7).
max2(3,7,7).
*/



/* suksesor(X,Y) artinya Y adalah suksesor dari X */
suksesor(0,1).
suksesor(1,2).
suksesor(2,3).
suksesor(3,4).

/* plus(X,Y,Z) artinya Z adalah penjumlahan dari X dan Y */
plus(0,X,X).
plus(X,Y,Z) :- suksesor(X1,X), plus(X1,Y,Z1), suksesor(Z1,Z).
/* query
plus(3,5,Z).
*/



/* grade(Mark,Grade) artinya Grade adalah nilai huruf dari Mark */
grade(Mark,a) :- Mark >= 70.
grade(Mark,b) :- Mark >= 63, Mark < 70.
grade(Mark,c) :- Mark >= 55, Mark < 63.
grade(Mark,d) :- Mark >= 50, Mark < 55.
grade(Mark,e) :- Mark >= 40, Mark < 50.
grade(Mark,f) :- Mark < 40.
/* untuk efisiensi digunakan cut (!) */
grade1(Mark,a) :- Mark >= 70, !.
grade1(Mark,b) :- Mark >= 63, Mark < 70, !.
grade1(Mark,c) :- Mark >= 55, Mark < 63, !.
grade1(Mark,d) :- Mark >= 50, Mark < 55, !.
grade1(Mark,e) :- Mark >= 40, Mark < 50, !.
grade1(Mark,f) :- Mark < 40.
/* query
grade(80,X).
grade(73,a).
grade(30,e).

grade1(68,X).
grade1(73,a).
grade1(60,e).
*/



/* holiday(X,Y) artinya libur tanggal Y adalah hari X */
holiday(friday,may1).

/* weather(X,Y) artinya cuaca hari Y adalah X */
weather(friday,fair).
weather(saturday,fair).
weather(sunday,fair).

/* weekend(X) artinya hari X adalah hari libur akhir pekan */
weekend(saturday).
weekend(sunday).

/* picnic(Day) artinya hari Day adalah hari piknik */
/* menghasilkan fri, sat, sun */
picnic(Day) :- weather(Day,fair), weekend(Day).
picnic(Day) :- holiday(Day, may1).
/* percobaan cut 1 : tidak menghasilkan apapun karena sudah melewati  */
picnic1(Day) :- weather(Day,fair), !, weekend(Day).
picnic1(Day) :- holiday(Day, may1).
/* percobaan cut 2 : sudah masuk ke weekend(saturday) sehingga berhenti backtrack dan tidak mencari kemungkinan lain untuk weather
                     tidak bertemu ! saat friday karena fail */
picnic2(Day) :- weather(Day,fair), weekend(Day), !.
picnic2(Day) :- holiday(Day, may1).
/* percobaan cut 3 : tidak akan mengecek holiday krn sudah di cut di awal */
picnic3(Day) :- !, weather(Day,fair), weekend(Day).
picnic3(Day) :- holiday(Day, may1).
/* query
picnic(When).
picnic(friday).
picnic(saturday).

picnic1(When).
picnic2(When).
picnic3(When).
*/



/* car(Model,Color,Price) artinya mobil dengan model Model, warna Color, dan harga Price */
car(maserati,green,25000).
car(corvette,black,24000).
car(corvette,red,26000).
car(corvette,red,23000).
car(porsche,red,24000).

/* colors(Color,Type) artinya warna Color adalah warna Type */
colors(red,sexy).
colors(black,mean).
colors(green,preppy).

/* buy_car(Model,Color) artinya mobil dengan model Model dan warna Color bisa dibeli dengan harga kurang dari 25000 */
/* akan berhenti backtrack setelah colors(X,Y) true */
/* rules di bawah hanya akan menghasilkan satu solusi */
/* kalau g ada cut, akan menghasilkan semua solusi */
buy_car(Model,Color) :- car(Model,Color,Price),colors(Color,sexy),!,Price < 25000.
/* query
buy_car(Model,Color).
buy_car(corvette,Color).
*/


/* percobaan menggunakan fail */
/* di bawah ini akan bertanya kepada user apakah ingin melanjutkan atau tidak */
/* perhatikan penggunaan fail akan menghasilkan false */
z :- a.
a :- write('ini masuk ke bawah').
a :- weekend(saturday), write('jalan ini'),nl,fail.

/* di bawah ini akan langsung mengeksekusi write('ini masuk ke bawah') karena penggunaan fail 
   artiannya dengan fail akan mencoba untuk mencari solusi lain */
/* jika weekend(saturday) true, maka akan mencetak write('jalan ini'). Jika false, akan mencari rules lain
   (bukan karena predikat fail tapi karena backtrack) */
z1 :- a1.
a1 :- weekend(saturday), write('jalan ini'),nl, fail.
a1 :- write('ini masuk ke bawah').



/* percobaan stop statement */
/* ostrich tidak bisa terbang */
bird(sparrow).
bird(eagle).
bird(duck).
bird(crow).
bird(ostrich).
bird(puffin).
bird(swan).
bird(albatross).
bird(starling).
bird(owl).
bird(kingfisher).
bird(thrush).

can_fly(ostrich):-!,fail.
can_fly(X):-bird(X).
/* query
can_fly(duck).
can_fly(ostrich).
*/

/* percobaan oprator dasar */
coba1(X) :- Y = 1, format('X = ~w', [X]),nl, format('Y = ~w', [Y]), X =:= Y.

coba2 :- X = 2, Y = 10, Z is X mod Y, format('~w', [Z]).
coba3 :- X is 2, Y is 10, Z = X mod Y, format('~w', [Z]).

coba4 :- X = 4, Y = 3, Z is X/Y, format('~w', [Z]).
coba5 :- X is 4, Y is 3, Z is X//Y, format('~w', [Z]).


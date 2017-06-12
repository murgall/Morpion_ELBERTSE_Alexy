{ALGORITHME : Jeu_du_morpion
BUT : cet algorithme recrée le jeu du morpion avec deux joueur.
ENTREE : placement du pion par un joueur
SORTIE : grille de jeu

CONST
	MAXLIGNE:3
	MAXCOLONNE:3
	MAXPION_ALIGN_WIN:3

TYPE
	grille: TABLEAU[1..MAXLIGNE,1..MAXCOLONNE] de CARACTERE


PROCEDURE init_grille(VAR tabgrille:grille;lign,col: ENTIER)
DEBUT
	POUR lign ALLANT de 1 A MAXLIGNE FAIRE
	DEBUT
		POUR col ALLANT de 1 A MAXCOLONNE FAIRE
		DEBUT
			tabgrille[lign,col]<='_'
		FINPOUR
	FINPOUR
FINPROCEDURE

PROCEDURE affich_grille(tabgrille:grille)
DEBUT
	ECRIRE(tabgrille[1,1] & "," & tabgrille[1,2] & "," & tabgrille[1,3])
	ECRIRE(tabgrille[2,1] & "," & tabgrille[2,2] & "," & tabgrille[2,3])
	ECRIRE(tabgrille[3,1] & "," & tabgrille[3,2] & "," & tabgrille[3,3])
FINPROCEDURE


PROCEDURE debut_tour(tour_j:integer)
DEBUT
	SI tour_j=1 ALORS
		DEBUT
			ECRIRE("Le joueur 1 commence."")
			joueur<=1
		FIN
	SINON
		DEBUT
			ECRIRE("Le joueur 2 commence")
			joueur<=2
		FIN
FINPROCEDURE




PROCEDURE change (var j : CARACTERE);
DEBUT
	SI j = "X" ALORS j := "O"
	SINON j <= "X"
FINPROCEDURE




PROCEDURE valide (var tabgrille : grille; j : CARACTERE)
var x,y : ENTIER
	verif : BOOLEEN
debut
	verif <= FAUX
	REPETER
		ECRIRE("Numero ligne et colonne :")
		LIRE(x,y)
		SI tabgrille[x,y] = '_' ALORS
		DEBUT
			tabgrille[x,y] <= j;
			verif <= VRAI
		end
		SINON ECRIRE("Coup non valide !"")
	JUSQU'A (verif)
FINPROCEDURE




VAR
	resultatquicommence: ENTIER
	tabgrille : grille
	j : CARACTERE


DEBUT
	Randomize
	init_grille(tabgrille)
	affich_grille(tabgrille)
	j <= 'O'
	resultatquicommence<=ALEATOIRE(2)
	debut_tour(resultatquicommence)
	TANT QUE ...... FAIRE
	DEBUT
		change(j);
		valide(tabgrille,j)
		affich_grille(tabgrille)
	FINTANTQUE

FIN.}


PROGRAM Jeu_morpion;

USES crt;

CONST
	MAXLIGNE=3;
	MAXCOLONNE=3;
	NB_COUP=9;
	NB_MANCHE=3;

TYPE
	grille = array[1..MAXLIGNE,1..MAXCOLONNE] of CHAR;
	TabManche = array[1..2] of integer;

VAR
	joueur,lign,col,tour_j,coup,manche: INTEGER;
	tabgrille: grille;
	Tmanche:TabManche;
	j : CHAR;


PROCEDURE init_grille;
BEGIN
	FOR lign:=1 TO 3 DO
	BEGIN
		FOR col:=1 TO 3 DO
		BEGIN
			tabgrille[lign,col]:='_';
		END
	END
END;

PROCEDURE affich_grille;
BEGIN
	writeln(tabgrille[1,1] , ',' , tabgrille[1,2] , ',' , tabgrille[1,3]);
	writeln(tabgrille[2,1] , ',' , tabgrille[2,2] , ',' , tabgrille[2,3]);
	writeln(tabgrille[3,1] , ',' , tabgrille[3,2] , ',' , tabgrille[3,3]);
END;


PROCEDURE debut_tour;		// selectionne aleatoirement le joueur qui commence
BEGIN
	IF tour_j=1 THEN
		BEGIN
			writeln('Le joueur 1 commence.');
			joueur:=1;
		END
	ELSE
	If tour_j=2 THEN
		BEGIN
			writeln('Le joueur 2 commence');
			joueur:=2;
		END;
END;

PROCEDURE tour_joueur;			// défini le tour du joueur
	BEGIN
		if joueur=1 then
		BEGIN
			joueur:=joueur+1;
			writeln('c''est au tour du joueur 2');
		END
		ELSE
		if joueur=2 then
		BEGIN
			joueur:=joueur-1;
			writeln('c''est au tour du joueur 1');
		end;
	end;




PROCEDURE change;			// permet de changer le rond en croix et inversement
BEGIN
	IF j = 'X' THEN
	j := 'O'
	ELSE
	IF j = 'O' THEN  
	j := 'X';
END;




PROCEDURE valide;				// Permet de verifier si une case est occupé ou non, et place une croix ou un rond
var x,y : INTEGER;
	verif : BOOLEAN;
BEGIN
	verif := FALSE;
	REPEAT
		writeln('Numero colonne(1ere valeur) et ligne(2eme) :');
		repeat
			readln(x,y);
			if (x<1) or (x>3) or (y<1) or (y>3) THEN
				writeln('Veuillez ressaisir une valeur entière compris entre 1 et 3');
		until (x>=1) and (x<=3) and (y>=1) and (y<=3);
		IF (tabgrille[x,y] = '_') THEN
		BEGIN
			tabgrille[x,y] := j;
			verif := TRUE;
		end
		ELSE
		if (tabgrille[x,y] = 'X') or (tabgrille[x,y] = 'O') then
		BEGIN
			writeln('Coup non valide !');
		end;
	UNTIL verif=TRUE;
END;


FUNCTION align_horizontal: BOOLEAN;

BEGIN
	align_horizontal:=FALSE;
	if ((tabgrille[1,1]='O') and (tabgrille[2,1]='O') and (tabgrille[3,1]='O')) or ((tabgrille[1,1]='X') and (tabgrille[2,1]='X') and (tabgrille[3,1]='X')) then
	align_horizontal:=TRUE
	ELSE
	if ((tabgrille[1,2]='O') and (tabgrille[2,2]='O') and (tabgrille[3,2]='O')) or ((tabgrille[1,2]='X') and (tabgrille[2,2]='X') and (tabgrille[3,2]='X')) then
	align_horizontal:=TRUE
	ELSE
	if ((tabgrille[1,3]='O') and (tabgrille[2,3]='O') and (tabgrille[3,3]='O')) or ((tabgrille[1,3]='X') and (tabgrille[2,3]='X') and (tabgrille[3,3]='X')) then
	align_horizontal:=TRUE;
END;

FUNCTION align_vertical: BOOLEAN;

BEGIN
	align_vertical:=FALSE;
	if ((tabgrille[1,1]='O') and (tabgrille[1,2]='O') and (tabgrille[1,3]='O')) or ((tabgrille[1,1]='X') and (tabgrille[1,2]='X') and (tabgrille[1,3]='X')) then
	align_vertical:=TRUE
	ELSE
	if ((tabgrille[2,1]='O') and (tabgrille[2,2]='O') and (tabgrille[2,3]='O')) or ((tabgrille[2,1]='X') and (tabgrille[2,2]='X') and (tabgrille[2,3]='X')) then
	align_vertical:=TRUE
	ELSE
	if ((tabgrille[3,1]='O') and (tabgrille[3,2]='O') and (tabgrille[3,3]='O')) or ((tabgrille[3,1]='X') and (tabgrille[3,2]='X') and (tabgrille[3,3]='X')) then
	align_vertical:=TRUE;
END;

FUNCTION align_diagonal: BOOLEAN;

BEGIN
	align_diagonal:=FALSE;
	if ((tabgrille[1,1]='O') and (tabgrille[2,2]='O') and (tabgrille[3,3]='O')) or ((tabgrille[1,1]='X') and (tabgrille[2,2]='X') and (tabgrille[3,3]='X')) then
	align_diagonal:=TRUE
	ELSE
	if ((tabgrille[1,3]='O') and (tabgrille[2,2]='O') and (tabgrille[3,1]='O')) or ((tabgrille[1,3]='X') and (tabgrille[2,2]='X') and (tabgrille[3,1]='X')) then
	align_diagonal:=TRUE;
END;







BEGIN
	clrscr;
	Randomize;
	coup:=0;
	manche:=1;
	Tmanche[1]:=0;
	Tmanche[2]:=0;
	init_grille();
	affich_grille();
	j := 'O';
	tour_j:=random(1)+1;
	debut_tour();
	REPEAT
		WHILE (align_horizontal=FALSE) and (align_vertical=FALSE) and (align_diagonal=FALSE) DO
		begin
			change();
			valide();
			clrscr;
			writeln('round ',manche);
			affich_grille();
			if (align_horizontal=FALSE) and (align_vertical=FALSE) and (align_diagonal=FALSE) then
			BEGIN
				coup:=coup+1;
				tour_joueur();
			end;
			IF coup=NB_COUP THEN
			BEGIN
				clrscr;
				writeln('round ',manche);
				init_grille();
				affich_grille();
				coup:=0;
			end;
		END;
		if ((align_horizontal=TRUE) or (align_vertical=TRUE) or (align_diagonal=TRUE)) and (joueur=1)then
		BEGIN
			clrscr;
			writeln('Le joueur 1 remporte la manche ', manche);
			Tmanche[1]:=Tmanche[1]+1;
			manche:=manche+1;
			init_grille();
			affich_grille();
			readln;
		end
		ELSE
		if ((align_horizontal=TRUE) or (align_vertical=TRUE) or (align_diagonal=TRUE)) and (joueur=2)then
		BEGIN
			clrscr;
			writeln('Le joueur 2 remporte la manche ', manche);
			Tmanche[2]:=Tmanche[2]+1;
			manche:=manche+1;
			init_grille();
			affich_grille();
			readln;
		end;

	UNTIL (manche=NB_MANCHE) and ((Tmanche[1]<Tmanche[2]) or (Tmanche[2]<Tmanche[1]));
	if (Tmanche[1]<Tmanche[2]) THEN
		writeln('le joueur 2 a gagner')
	ELSE
	IF (Tmanche[2]<Tmanche[1]) THEN
		writeln('le joueur 1 a gagner');
	readln;

END.






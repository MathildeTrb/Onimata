protocol POnimata {
	
	// init : -> TOnimata
	// retourne le plateau de jeu avec les 10 pièces à leur position initiale : les bleus en bas et les rouges en haut et le maitre au milieu des pions
	init ()

	// aEnReserve : TOnimata -> TCarte 
	// Donne la carte qui est en réserve
	var aEnReserve : PCarte {get set}

	// distributionCarte : TOnimata x TJoueur x TJoueur -> TOnimata
	// Création des 15 cartes de jeu et affectation de manière aléatoire de la carte réserve et des cartes dans les mains de chaque joueur
	// modifie aEnreserve, aPourCarte1 et aPourCarte2 des joueurs
	mutating func distributionCarte (jBleu : PJoueur, jRouge: PJoueur)

	// echangeCarte : TOnimata x TCarte x TCarte x TJoueur -> TOnimata
	// Echange la carte de la réserve avec la carte que le joueur courant vient d'utiliser (ou la carte que le joueur doit défausser si aucun déplacement n'est possible)
	// Pre: le premier paramètre correspond à la carte utilisée (ou défaussée)
	// Pre: le second paramètre correspond à la carte dans la réserve
	mutating func echangeCarte (newRes : PCarte, newMain : PCarte, joueur : PJoueur)

	// affichePlateauAvecPiece : TOnimata x TJoueur x TJoueur -> String 
	// Prends en paramètre les deux joueurs et affiche l'état du plateau actuel
	// Post : retourne une chaîne de caractères affichant le plateau avec les pièces encore en jeu
	func affichePlateauAvecPiece (joueurBleu : PJoueur, joueurRouge : PJoueur) -> String
	
}

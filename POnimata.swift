protocol POnimata {
	
	// init : -> POnimata
	// retourne le plateau de jeu de taille 5x5
	// chaque case du plateau est de type position 
	// avec les 10 pièces à leur position initiale : les bleus en bas et les rouges en haut et le maitre au milieu des pions
	init ()

	// aEnReserve : POnimata -> PCarte 
	// Donne la carte qui est en réserve
	var aEnReserve : PCarte {get set}

	// distributionCarte : POnimata x PJoueur x PJoueur -> POnimata
	// Création des 15 cartes de jeu et affectation de manière aléatoire de la carte réserve et des cartes dans les mains de chaque joueur
	// modifie aEnreserve de POnimata, aPourCarte1 et aPourCarte2 des joueurs ( PJoueur ) 
	mutating func distributionCarte (jBleu : PJoueur, jRouge: PJoueur)

	// echangeCarte : POnimata x PCarte x PCarte x PJoueur -> POnimata
	// Echange la carte de la réserve avec la carte que le joueur courant vient d'utiliser (ou la carte que le joueur doit défausser si aucun déplacement n'est possible)
	// Pre: le premier paramètre correspond à la carte utilisée (ou défaussée)
	// Pre: le second paramètre correspond à la carte dans la réserve
	// Pre: le troisième paramètre correspond au joueurCourant
	mutating func echangeCarte (newRes : PCarte, newMain : PCarte, joueur : PJoueur)

	// choixPremierJoueur : POnimata -> PJoueur
	// Regarde la couleur de la carte en réserve et détermine ainsi le joueur de la même couleur commençant la partie 
	// Post : retourne le joueur jouant le premier tour
	func choixPremierJoueur () -> PJoueur
	
}

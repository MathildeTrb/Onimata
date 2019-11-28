protocol PJoueur {


	// init : String x String x TOnimata
	// Créer un joueur dont le nom est newNom, dont la couleur est newCouleur et qui a en sa possession un maitre et 4 pion de sa couleur (qui peuvent être récupérés directement sur le plateau entré en paramètre)
	// Pre: La couleur du joueur est soit "Rouge" soit "Bleu"
	// Pre: le nom du joueur ne peut être vide
	// Resultat : un joueur avec un nom, une couleur et des pièces associées
	init (newNom : String, newCouleur : String, plateau : TOnimata)

	// aPourNom : TJoueur -> String
	// donne le nom du joueur 
	// Resultat : un string correspondant au nom du joueur
	var aPourNomJ : String {get}

	// aPourCouleurJ : TJoueur -> String 
	// donne la couleur du joueur (la couleur sera "Rouge" ou "Bleu")
	// Resultat : un string correspondant à la couleur du joueur 
	var aPourCouleurJ : String {get}

	// aPourCarte1 : TJoueur -> TCarte 
	// donne la carte 1 du joueur 
	// Resultat : une TCarte qui correspond à la carte1 du joueur 
	var aPourCarte1 : TCarte! {get, set}

	// aPourCarte2 : TJoueur -> TCarte 
	// donne la carte 2 du joueur 
	// Resultat : une TCarte qui correspond à la carte2 du joueur
	var aPourCarte2 : TCarte! {get, set}

	// recupPiece : String -> TPiece
	// Resultat : cette fonction renvoie la pièce correspondant au String ssi elle appartient au joueurCourant (ce qui implique qu'elle n'a pas été éliminée)
	// Pre : le String reçu en paramètre doit correspondre à une pièce que le joueur détient
	// Post : une Pièce correspondant à la chaîne de caractère est retournée
	func recupPiece (pieceSaisie : String) -> TPiece

	// elimine : Tpiece x TJoueur -> TJoueur 
	// Est utilisée lorsqu'une pièce est éliminé de la partie
	// Resultat : enlève au joueur la pièce entrée en paramètre
	mutating func elimine (piece : TPiece)

	// autreJoueur : TJoueur -> TJoueur
	// Resultat : Renvoie le joueur qui n'est pas le joueur courant
	mutating func autreJoueur()

	// peutJouer : TJoueur -> Bool
	// Resultat : Si au moins un déplacement est possible pour l'une des deux cartes ainsi que l'une des pièces du joueur, renvoie True, sinon False
	func peutJouer () -> Bool

}

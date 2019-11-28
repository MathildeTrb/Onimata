protocol PCarte {

	// init : String x String -> PCarte
	// créer une carte contenant une couleur, un nom
	// Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
	// Pre: le nom ne peut être vide
	init (newNom : String, newCouleur: String) 

	// aPourNom : PCarte -> String 
	// Donne le nom de la carte
	var aPourNomC : String {get}

	// aPourCouleurC : PPièce -> String
	// Donne la couleur de la carte 
	// Post: Le nom de la couleur est "Rouge" ou "Bleu"
	var aPourCouleurC : String {get}

	// ajoutPosition : PCarte x PPosition -> TCarte
	// Ajoute une position à la carte comme illustrée sur le sujet
	// Pre: La position doit se localiser sur le plateau
	mutating func ajoutPosition (pos : PPosition) 

	// contient : PCarte x PPosition x PPiece -> Bool 
	// Post: retourne True si la Carte permet à la pièce passé en paramètre de prendre la position passée en paramètre, sinon False
	func contient (pos : PPosition, pieceRef : PPiece) -> Bool

	// afficheCarte : PCarte x Int -> String 
	// Post : retourne une chaîne de caractères contenant :
	// le nom de la carte 
	// une position de référence (ou est placé une pièce fictive qui servira de référence
	// les positions possibles de cette pièce référence
	// le sens est un entier qui a pour valeur soit 1 soit -1
	// si le sens vaut 1 cela concerne le joueur Bleu qui a ses pions en bas du plateau lorsque ce dernier est " affiché "
	// si le sens vaut -1 cela concerne le joueur Rouge qui a ses pions en haut du plateau lorsque ce dernier est "affiché"
	// pour se dernier cas il faut donc pensez que les positions possibles sont inversées
	func afficheCarte (sens : Int) -> String
}

	

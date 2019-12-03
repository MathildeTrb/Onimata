protocol PCarte {

	// init : String x ECouleur -> PCarte
	// créer une carte contenant une couleur, un nom
	// Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
	// Pre: le nom ne peut être vide
	init (newNom : String, newCouleur: ECouleur) 

	// aPourNom : PCarte -> String 
	// Donne le nom de la carte
	var aPourNomC : String {get}

	// aPourCouleurC : PPièce -> ECouleur
	// Donne la couleur de la carte 
	// Post: Le nom de la couleur est "Rouge" ou "Bleu"
	var aPourCouleurC : ECouleur {get}
	
	// aPourPositionReference : PPièce -> PPosition 
	// Donne la position d'une pièce fictive référence (case noire sur le sujet de Projet)
	// Cette position doit être sur le plateau 
	var aPourPositionRef : PPosition {get}

	// ajoutPosition : PCarte x PPosition -> TCarte
	// Ajoute une position à la carte comme illustrée sur le sujet
	// la po
	// Pre: La position doit se localiser sur le plateau
	mutating func ajoutPosition (pos : PPosition) 

	// contient : PCarte x PPosition x PPiece -> Bool 
	// Post: retourne True si la Carte permet à la pièce passé en paramètre de prendre la position passée en paramètre, sinon False
	func contient (pos : PPosition, pieceRef : PPiece) -> Bool

}

	

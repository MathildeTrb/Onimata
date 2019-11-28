protocol PPiece {

	// init: Bool x Sring x TPosition -> TPièce
	// Création d’une pièce avec une couleur, une position et si c'est un maître ou non
	// Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
	// Pre: la position doit se situer sur le plateau
	// newPosition.estOccupePar = piece 
	init (newCouleur : String, newEstMaitre : Bool, newPosition : TPosition)

	// aPourCouleurP : TPièce -> String
	// Donne la couleur de la pièce ("Bleu" ou "Rouge")
	var aPourCouleurP : String {get}
	
	// estMaitre : TPièce -> Bool
	// Renvoie True si la pièce est un maître, False sinon
	var estMaitre : Bool {get}

	// aPourPosition : TPièce -> TPosition
	// Renvoie la position de la pièce 
	var aPourPosition : TPosition {get,set}

	// changerPosition : TPièce x TPosition -> TPièce
	// Change aPourPosition avec la nouvelle position
	// Pre: La nouvelle position doit être sur le plateau
	mutating func changePosition (newPosition : TPosition)

	// estUnDeplacementPossible : TPosition x TCarte x TPièce -> Bool
	// Post: True si correspond à l'un des déplacements proposés par la carte
	// Post: False si la position n'est pas sur le plateau
	// Post: False si la position est déjà occupée par une de ses pièces
	func estUnDeplacementPossible (newPosition : TPosition, carte : TCarte) -> Bool

}

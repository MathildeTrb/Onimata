protocol PPiece {

	// init: Bool x Sring x PPosition -> PPièce
	// Création d’une pièce avec un nom, une couleur, une position et si c'est un maître ou non
	// Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
	// Pre: la position doit se situer sur le plateau
	// newPosition.estOccupePar = la pièce créée piece 
	init (newNom : String, newCouleur : String, newEstMaitre : Bool, newPosition : PPosition)
	
	// aPourNom : PPièce -> String
	// Donne le nom de la pièce 
	// Le nom doît être court car utilisé lors de l'affichage du plateau (exemple PB1 pour pion bleu 1 ou MR pour maitre Rouge)
	var aPourNom : String {get}

	// aPourCouleurP : PPièce -> String
	// Donne la couleur de la pièce ("Bleu" ou "Rouge")
	var aPourCouleurP : String {get}
	
	// estMaitre : PPièce -> Bool
	// Renvoie True si la pièce est un maître, False sinon
	var estMaitre : Bool {get}

	// aPourPosition : PPièce -> PPosition
	// Renvoie la position de la pièce 
	var aPourPosition : PPosition {get set}

	// changerPosition : PPièce x PPosition -> TPièce
	// Change aPourPosition avec la nouvelle position
	// Pre: La nouvelle position doit être sur le plateau
	mutating func changePosition (newPosition : PPosition)

	// estUnDeplacementPossible : PPosition x PCarte x PPièce x Int -> Bool
	// Post: True si correspond à l'un des déplacements proposés par la carte
	// Post: False si la position n'est pas sur le plateau
	// Post: False si la position est déjà occupée par une de ses pièces
	func estUnDeplacementPossible (newPosition : PPosition, carte : PCarte, sens : Int) -> Bool

}

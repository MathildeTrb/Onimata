protocol PPosition {

	// init : Int x Int -> PPosition
	// créer une position avec pour coordonnées un x et un y
	// Pre: x compris entre 0 et 4
	// Pre: y compris entre 0 et 4 	
	init (newX : Int, newY : Int) 

	// positionX : TPosition -> Int
	// Renvoie la coordonnée x de la position
	var positionX : Int {get, set}

	// positionY : TPosition -> Int
	// Renvoie la coordonnée y de la position
	var positionY : Int {get, set}
	
	// estOccupePar : TPosition -> TPiece | Vide 
	// Si une pièce occupe la position, on retourne la pièce sinon retourne Vide 
	var estOccupePar : PPiece? {get, set}

	// estUneArcheAdverse : TPosition x TJoueur -> Bool
	// Post: retourne True si la position correspond à une arche adverse sinon False
	func estUneArcheAdverse (joueur : TJoueur) -> Bool
}

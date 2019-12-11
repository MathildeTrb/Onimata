protocol PJoueur {


	// init : String x ECouleur x POnimata -> PJoueur
	// Créer un joueur dont le nom est newNom, dont la couleur est newCouleur et qui a en sa possession un maitre et 4 pion de sa couleur 
	// (qui peuvent être récupérés directement sur le plateau entré en paramètre, qui est le plateau de jeu courant)
	// Pre: La couleur du joueur est soit "Rouge" soit "Bleu"
	// Pre: le nom du joueur ne peut être vide
	// Resultat : un joueur avec un nom, une couleur et des pièces associées
	init (newNom : String, newCouleur : ECouleur, plateau : POnimata)

	// aPourNom : PJoueur -> String
	// donne le nom du joueur 
	// Resultat : un string correspondant au nom du joueur
	var aPourNomJ : String {get}

	// aPourCouleurJ : PJoueur -> ECouleur
	// donne la couleur du joueur (la couleur sera "Rouge" ou "Bleu")
	// Resultat : un string correspondant à la couleur du joueur 
	var aPourCouleurJ : ECouleur {get}
	
	// aPourPieces : PJoueur -> [PPiece]
	// Donne sous forme de tableau tous les pions encore présent sur le plateau d'un joueur
	// Pre: La couleur de toutes les pièces est la même que celle du joueur
	var aPourPieces : [PPiece] {get set}

	// aPourCarte1 : PJoueur -> PCarte 
	// donne la carte 1 du joueur 
	// Resultat : une PCarte qui correspond à la carte1 du joueur 
	var aPourCarte1 : PCarte! {get set}

	// aPourCarte2 : PJoueur -> PCarte 
	// donne la carte 2 du joueur 
	// Resultat : une PCarte qui correspond à la carte2 du joueur
	var aPourCarte2 : PCarte! {get set}

	// recupPiece : PJoueur x EPiece -> PPiece
	// Resultat : cette fonction renvoie la pièce correspondant au String ssi elle appartient au joueurCourant (ce qui implique qu'elle n'a pas été éliminée)
	// Pre : le String entré en paramètre doit correspondre au nom d'une pièce que le joueur détient
	// Post : une Pièce correspondant à la chaîne de caractère est retournée
	func recupPiece (pieceSaisie : EPiece) -> PPiece

	// elimine : PPiece x PJoueur -> PJoueur 
	// Est utilisée lorsqu'une pièce est éliminé de la partie
	// Resultat : enlève au joueur la pièce entrée en paramètre
	mutating func elimine (piece : PPiece)

	// autreJoueur : PJoueur -> PJoueur
	// Resultat : Renvoie le joueur qui n'est pas le joueur courant
	mutating func autreJoueur()

	// peutJouer : PJoueur -> Bool
	// Resultat : Si au moins une nouvelle position est possible pour l'une des deux cartes ainsi que l'une des pièces du joueur, renvoie True, sinon False
	func peutJouer () -> Bool

}


struct Joueur : PJoueur {
    
    private var _nom : String
    private var _couleur : ECouleur
    private var _plateau : POnimata
    private var _piece : [PPiece] = []
    
    // init : String x ECouleur x POnimata -> PJoueur
    // Créer un joueur dont le nom est newNom, dont la couleur est newCouleur et qui a en sa possession un maitre et 4 pion de sa couleur
    // (qui peuvent être récupérés directement sur le plateau entré en paramètre, qui est le plateau de jeu courant)
    // Pre: La couleur du joueur est soit "Rouge" soit "Bleu"
    // Pre: le nom du joueur ne peut être vide
    // Resultat : un joueur avec un nom, une couleur et des pièces associées
    init (newNom : String, newCouleur : ECouleur, plateau : POnimata){
        self._nom = newNom
        self._couleur = newCouleur
        self._plateau = plateau
        
        //En haut est rouge donc position = 0
        //En bas est bleu donc position = 4
        var position : Int = 4
        if(newCouleur == ECouleur.Rouge){
            position = 0
        }
        
        self._piece.append(Piece(newNom : EPiece.P1, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : 0, newY: position)))
        self._piece[1] = Piece(newNom : EPiece.P2, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : 0, newY: position))
        self._piece[2] = Piece(newNom : EPiece.M1, newCouleur : self._couleur, newEstMaitre : True, newPosition : Position(newX : 0, newY: position))
        self._piece[3] = Piece(newNom : EPiece.P1, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : 0, newY: position))
        self._piece[4] = Piece(newNom : EPiece.P1, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : 0, newY: position))
        
    }
    
    // aPourNom : PJoueur -> String
    // donne le nom du joueur
    // Resultat : un string correspondant au nom du joueur
    var aPourNomJ : String { return self._nom }
    
    // aPourCouleurJ : PJoueur -> ECouleur
    // donne la couleur du joueur (la couleur sera "Rouge" ou "Bleu")
    // Resultat : un string correspondant à la couleur du joueur
    var aPourCouleurJ : ECouleur { return self._couleur }
    
    // aPourPieces : PJoueur -> [PPiece]
    // Donne sous forme de tableau tous les pions encore présent sur le plateau d'un joueur
    // Pre: La couleur de toutes les pièces est la même que celle du joueur
    var aPourPieces : [PPiece] {
        get{
            return self._piece
        }
        
        set{
            
        }
        
    }
    
    // aPourCarte1 : PJoueur -> PCarte
    // donne la carte 1 du joueur
    // Resultat : une PCarte qui correspond à la carte1 du joueur
    var aPourCarte1 : PCarte! {get set}
    
    // aPourCarte2 : PJoueur -> PCarte
    // donne la carte 2 du joueur
    // Resultat : une PCarte qui correspond à la carte2 du joueur
    var aPourCarte2 : PCarte! {get set}
    
    // recupPiece : PJoueur x EPiece -> PPiece
    // Resultat : cette fonction renvoie la pièce correspondant au String ssi elle appartient au joueurCourant (ce qui implique qu'elle n'a pas été éliminée)
    // Pre : le String entré en paramètre doit correspondre au nom d'une pièce que le joueur détient
    // Post : une Pièce correspondant à la chaîne de caractère est retournée
    func recupPiece (pieceSaisie : EPiece) -> PPiece
    
    // elimine : PPiece x PJoueur -> PJoueur
    // Est utilisée lorsqu'une pièce est éliminé de la partie
    // Resultat : enlève au joueur la pièce entrée en paramètre
    mutating func elimine (piece : PPiece)
    
    // autreJoueur : PJoueur -> PJoueur
    // Resultat : Renvoie le joueur qui n'est pas le joueur courant
    mutating func autreJoueur()
    
    // peutJouer : PJoueur -> Bool
    // Resultat : Si au moins une nouvelle position est possible pour l'une des deux cartes ainsi que l'une des pièces du joueur, renvoie True, sinon False
    func peutJouer () -> Bool}

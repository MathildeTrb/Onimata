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

	// peutJouer : PJoueur -> Bool
	// Resultat : Si au moins une nouvelle position est possible pour l'une des deux cartes ainsi que l'une des pièces du joueur, renvoie True, sinon False
	func peutJouer () -> Bool

}


struct Joueur : PJoueur {
    
    private var _nom : String
    private var _couleur : ECouleur
    private var _plateau : POnimata
    private var _piece : [PPiece] = []
    private var _carte : [PCarte] = []
    
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
        
        //Joueur de couleur rouge en haut -> position = 0
        //Joueur de couleur bleu en bas position -> 4
        var position : Int = 4
        if(newCouleur == ECouleur.Rouge){
            position = 0
        }
        
        self._piece.append(Piece(newNom : EPiece.P1, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : position, newY: 0)))
        self._piece.append(Piece(newNom : EPiece.P2, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : position, newY: 1)))
        self._piece.append(Piece(newNom : EPiece.M1, newCouleur : self._couleur, newEstMaitre : True, newPosition : Position(newX : position, newY: 2)))
        self._piece.append(Piece(newNom : EPiece.P3, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : position, newY: 3)))
        self._piece.append(Piece(newNom : EPiece.P4, newCouleur : self._couleur, newEstMaitre : False, newPosition : Position(newX : position, newY: 4)))
        
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
            self._piece = newValue //on refait une collection de PPiece?
        }
    }
    
    // aPourCarte1 : PJoueur -> PCarte
    // donne la carte 1 du joueur
    // Resultat : une PCarte qui correspond à la carte1 du joueur
    var aPourCarte1 : PCarte! {
        get{
            return self._carte[0]
        }
        
        set{
            self._carte[0] = newValue
        }
    }
    
    // aPourCarte2 : PJoueur -> PCarte
    // donne la carte 2 du joueur
    // Resultat : une PCarte qui correspond à la carte2 du joueur
    var aPourCarte2 : PCarte! {
        get{
            return self._carte[1]
        }
        
        set{
            self._carte[1] = newValue
        }
    }
    
    // recherchePiece : PJoueur x EPiece -> Int
    // Resultat : cette fonction renvoie l'indice de la pièce dans la collection de pièce du joueur courant si la pièce est trouvée
    //              sinon -1
    // Utilisé dans les fonctions : recupPiece et elimine
    private func recherchePiece(piece : EPiece) -> Int{
        var i : Int = 0
        
        while(self._piece[i].aPourNom != piece && i < self._piece.count-1){
            i = i + 1
        }
        
        if(self._piece[i].aPourNom != piece){
            i = -1
        }
        
        return i
    }
    
    // recupPiece : PJoueur x EPiece -> PPiece
    // Resultat : cette fonction renvoie la pièce correspondant au String ssi elle appartient au joueurCourant (ce qui implique qu'elle n'a pas été éliminée)
    // Pre : le String entré en paramètre doit correspondre au nom d'une pièce que le joueur détient
    // Post : une Pièce correspondant à la chaîne de caractère est retournée
    func recupPiece (pieceSaisie : EPiece) -> PPiece{
        var i : Int = recherchePiece(piece:pieceSaisie)
        
        if(i != -1){
            return self._piece[i]
        }
        else{
            fatalError("La pièce a déjà été éliminée !")
        }
    }
    
    // elimine : PPiece x PJoueur -> PJoueur
    // Est utilisée lorsqu'une pièce est éliminé de la partie
    // Resultat : enlève au joueur la pièce entrée en paramètre
    mutating func elimine (piece : PPiece){
        var i : Int = recherchePiece(piece:piece.aPourNom)
        
        if(i != -1){
            self._piece.remove(at:i)
        }
    }
    
    
    // peutJouer : PJoueur -> Bool
    // Resultat : Si au moins une nouvelle position est possible pour l'une des deux cartes ainsi que l'une des pièces du joueur, renvoie True, sinon False
    func peutJouer () -> Bool{
        var i : Int = 0
        var j : Int = 0
        var newPositionPossible : Bool = false
        var sensJ : Int = 1
        
        if(self._couleur == ECouleur.Rouge){
            sensJ = -1
        }
        
        var p : [PPiece] = self._piece
        var c : [PCarte] = self._carte
        
        while(!newPositionPossible && i < c.count - 1){
            var pos : [PPosition] = c[i].aPourPositionsPossibles
            
            while(!newPositionPossible && j < p.count - 1){
                
                while(!newPositionPossible && x < pos.count - 1){
                    if(p[j].estUnDeplacementPossible(newPosition:pos[x] , carte:c[i], sens:sensJ)){
                        newPositionPossible = true
                    }
                    x = x + 1
                }
                
                j = j + 1
            }
            
            i = i + 1
        }
        
        return newPositionPossible
        
    }
    
}

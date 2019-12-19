protocol PPosition {
    
    // init : Int x Int -> PPosition
    // créer une position avec pour coordonnées un x et un y
    // Pre: x compris entre 0 et 4
    // Pre: y compris entre 0 et 4     
    init (newX : Int, newY : Int) 
    
    // positionX : PPosition -> Int
    // Renvoie la coordonnée x de la position
    var positionX : Int {get set}
    
    // positionY : PPosition -> Int
    // Renvoie la coordonnée y de la position
    var positionY : Int {get set}
    
    // estOccupePar : PPosition -> PPiece | Vide 
    // Si une pièce occupe la position, on retourne la pièce sinon retourne Vide 
    var estOccupePar : PPiece? {get set}
    
    // estUneArcheDuJoueur : PPosition x PJoueur -> Bool
    // Post: retourne True si la position correspond à l'arche du joueur sinon False
    func estUneArcheDuJoueur (joueur : PJoueur) -> Bool
}

struct Position: PPosition {
    var positionX : Int
    var positionY : Int
    var estOccupePar : PPiece?
    
    init(newX : Int, newY : Int) {
        self.positionX = newX
        self.positionY = newY
        self.estOccupePar = nil
    }
    
    func estUneArcheDuJoueur(joueur : PJoueur) -> Bool {
        if (joueur.aPourCouleurJ == ECouleur.Rouge) {
            return self.positionX == 2 && self.positionY == 4
        }
        else {
            return self.positionX == 2 && self.positionY == 0
        }
    }
}
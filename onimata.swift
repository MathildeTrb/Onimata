enum EPiece : String {
	case P1 = "P1"
	case P2 = "P2"
	case P3 = "P3"
	case P4 = "P4"
	case M1 = "P5"
}

enum ECouleur {
        case Rouge, Bleu
}

protocol PCarte {
	
    // init : String x ECouleur -> PCarte
    // créer une carte contenant une couleur, un nom
    // Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
    // Pre: le nom ne peut être vide
    init (newNom : String, newCouleur: ECouleur) 
    
    // aPourNom : PCarte -> String 
    // Donne le nom de la carte
    var aPourNomC : String {get}
    
    // aPourCouleurC : PCarte -> ECouleur
    // Donne la couleur de la carte 
    // Post: Le nom de la couleur est "Rouge" ou "Bleu"
    var aPourCouleurC : ECouleur {get}
    
    // aPourPositionReference : PCarte -> PPosition 
    // Donne la position d'une pièce fictive référence (case noire sur le sujet de Projet)
    // Cette position doit être sur le plateau 
    var aPourPositionRef : PPosition {get}
    
    // aPourPositionsPossibles : PCarte -> [PPosition]
    // Donne la liste des positions possibles d'une pièce par rapport à la pièce de référence 
    // Cette position doit être sur le plateau 
    var aPourPositionsPossibles : [PPosition] {get set}
    
    // ajoutPosition : PCarte x PPosition -> PCarte
    // Ajoute une position à la carte comme illustrée sur le sujet
    // la po
    // Pre: La position doit se localiser sur le plateau
    mutating func ajoutPosition (pos : PPosition) 
    
    // contient : PCarte x PPosition x PPiece -> Bool 
    // Post: retourne True si la Carte permet à la pièce passé en paramètre de prendre la position passée en paramètre, sinon False
    func contient (pos : PPosition, pieceRef : PPiece) -> Bool
    
}

class Carte : PCarte {
    
    var aPourNomC : String
    var aPourCouleurC : ECouleur
    var aPourPositionRef : PPosition = Position(newX : 2, newY : 2)
    var aPourPositionsPossibles : [PPosition] = []
    
    required init(newNom : String, newCouleur : ECouleur) {
        self.aPourNomC = newNom
        self.aPourCouleurC = newCouleur
    }
    
    func ajoutPosition(pos : PPosition) {
        aPourPositionsPossibles.append(pos)
    }
    
    func contient(pos : PPosition, pieceRef : PPiece) -> Bool {   
        for position in aPourPositionsPossibles {
            var x = 2 - pieceRef.aPourPosition.positionX + pos.positionX
            var y = 2 - pieceRef.aPourPosition.positionY + pos.positionY
            if x == position.positionX && y == position.positionY {
                return true
            }
        }
        return false
    }
}
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
        
        //Joueur de couleur rouge en haut -> position = 4
        //Joueur de couleur bleu en bas position -> 0
        var position : Int = 0
        if(newCouleur == ECouleur.Rouge){
            position = 4
        }
        
        for i in 0 ... 4 {
            if let piece = plateau.getPosition(x : i, y : position).estOccupePar {
                self._piece.append(piece)
            }
        }
        self._carte = [Carte(newNom: "default", newCouleur: self._couleur),Carte(newNom: "default", newCouleur: self._couleur)]
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
        
        while(self._piece[i].aPourNom != piece && i < self._piece.count){
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
        var i : Int = self.recherchePiece(piece : pieceSaisie)
        
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
        var sens : Int = 1
        
        if(self._couleur == ECouleur.Rouge){
            sens = -1
        }
        
        for card in self._carte {
            for p in self._piece {
                for x in 0...4 {
                    for y in 0...4 {
                        if p.estUnDeplacementPossible(newPosition : self._plateau.getPosition(x : x, y : y), carte : card, sens : sens) {
                            return true
                        }
                    }
                }
            }
        }
        
        return false
        
    }
    
}
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
    mutating func distributionCarte (jBleu : inout PJoueur, jRouge: inout PJoueur)
    
    // echangeCarte : POnimata x PCarte x PCarte x PJoueur -> POnimata
    // Echange la carte de la réserve avec la carte que le joueur courant vient d'utiliser (ou la carte que le joueur doit défausser si aucun déplacement n'est possible)
    // Pre: le premier paramètre correspond à la carte utilisée (ou défaussée)
    // Pre: le second paramètre correspond à la carte dans la réserve
    // Pre: le troisième paramètre correspond au joueurCourant
    mutating func echangeCarte (newRes : PCarte, newMain : PCarte, joueur : inout PJoueur)
    
    // choixPremierJoueur : POnimata -> PJoueur
    // Regarde la couleur de la carte en réserve et détermine ainsi le joueur de la même couleur commençant la partie 
    // Post : retourne le joueur jouant le premier tour
    func choixPremierJoueur (jR : PJoueur, jB : PJoueur) -> PJoueur

    func getPosition(x : Int, y : Int) -> PPosition

    mutating func setPosition(position : PPosition)
    
}

struct Onimata : POnimata {
    var aEnReserve : PCarte
    var _grille : [[PPosition]] = [] 
    init() {
        for i in 0 ... 4 {
            var line : [Position] = []
            for j in 0 ... 4 {
                let pos = Position(newX : i, newY : j)
                line.append(pos)
            }
            self._grille.append(line)
        }

        var p1_bleu : PPiece = Piece(newNom : EPiece.P1, newCouleur : ECouleur.Bleu, newEstMaitre : false, newPosition : self._grille[0][0])
        self._grille[0][0].estOccupePar = p1_bleu
        var p2_bleu : PPiece = Piece(newNom : EPiece.P2, newCouleur : ECouleur.Bleu, newEstMaitre : false, newPosition : self._grille[1][0])
        self._grille[1][0].estOccupePar = p2_bleu
        var m1_bleu : PPiece = Piece(newNom : EPiece.M1, newCouleur : ECouleur.Bleu, newEstMaitre : true, newPosition : self._grille[2][0])
        self._grille[2][0].estOccupePar = m1_bleu
        var p3_bleu : PPiece = Piece(newNom : EPiece.P3, newCouleur : ECouleur.Bleu, newEstMaitre : false, newPosition : self._grille[3][0])
        self._grille[3][0].estOccupePar = p3_bleu
        var p4_bleu : PPiece = Piece(newNom : EPiece.P4, newCouleur : ECouleur.Bleu, newEstMaitre : false, newPosition : self._grille[4][0])
        self._grille[4][0].estOccupePar = p4_bleu
        
        var p1_rouge : PPiece = Piece(newNom : EPiece.P1, newCouleur : ECouleur.Rouge, newEstMaitre : false, newPosition : self._grille[4][4])
        self._grille[4][4].estOccupePar = p1_rouge
        var p2_rouge : PPiece = Piece(newNom : EPiece.P2, newCouleur : ECouleur.Rouge, newEstMaitre : false, newPosition : self._grille[3][4])
        self._grille[3][4].estOccupePar = p2_rouge
        var m1_rouge : PPiece = Piece(newNom : EPiece.M1, newCouleur : ECouleur.Rouge, newEstMaitre : true, newPosition : self._grille[2][4])
        self._grille[2][4].estOccupePar = m1_rouge
        var p3_rouge : PPiece = Piece(newNom : EPiece.P3, newCouleur : ECouleur.Rouge, newEstMaitre : false, newPosition : self._grille[1][4])
        self._grille[1][4].estOccupePar = p3_rouge
        var p4_rouge : PPiece = Piece(newNom : EPiece.P4, newCouleur : ECouleur.Rouge, newEstMaitre : false, newPosition : self._grille[0][4])
        self._grille[0][4].estOccupePar = p4_rouge

        self.aEnReserve = Carte(newNom: "default", newCouleur: ECouleur.Bleu)
    }
    private func _create_card() -> [Carte] {
        var tiger = Carte(newNom: "Tiger", newCouleur: ECouleur.Bleu)
        tiger.ajoutPosition(pos: Position(newX: 2, newY: 1))
        tiger.ajoutPosition(pos: Position(newX: 2, newY: 4))
        
        var crab = Carte(newNom: "Crab", newCouleur: ECouleur.Bleu)
        crab.ajoutPosition(pos: Position(newX: 0, newY: 2))
        crab.ajoutPosition(pos: Position(newX: 2, newY: 3))
        crab.ajoutPosition(pos: Position(newX: 4, newY: 2))
        
        var monkey = Carte(newNom: "Monkey", newCouleur: ECouleur.Bleu)
        monkey.ajoutPosition(pos: Position(newX: 1, newY: 1))
        monkey.ajoutPosition(pos: Position(newX: 3, newY: 1))
        monkey.ajoutPosition(pos: Position(newX: 1, newY: 3))
        monkey.ajoutPosition(pos: Position(newX: 3, newY: 3))
        
        var crane = Carte(newNom: "Crane", newCouleur: ECouleur.Bleu)
        crane.ajoutPosition(pos: Position(newX: 1, newY: 1))
        crane.ajoutPosition(pos: Position(newX: 3, newY: 1))
        crane.ajoutPosition(pos: Position(newX: 2, newY: 3))
        
        var dragon = Carte(newNom: "Dragon", newCouleur: ECouleur.Rouge)
        dragon.ajoutPosition(pos: Position(newX: 1, newY: 1))
        dragon.ajoutPosition(pos: Position(newX: 3, newY: 1))
        dragon.ajoutPosition(pos: Position(newX: 0, newY: 3))
        dragon.ajoutPosition(pos: Position(newX: 4, newY: 3))
        
        var elephant = Carte(newNom: "Elephant", newCouleur: ECouleur.Rouge)
        elephant.ajoutPosition(pos: Position(newX: 1, newY: 2))
        elephant.ajoutPosition(pos: Position(newX: 3, newY: 2))
        elephant.ajoutPosition(pos: Position(newX: 1, newY: 3))
        elephant.ajoutPosition(pos: Position(newX: 3, newY: 3))
        
        var mantis = Carte(newNom: "Mantis", newCouleur: ECouleur.Rouge)
        mantis.ajoutPosition(pos: Position(newX: 2, newY: 1))
        mantis.ajoutPosition(pos: Position(newX: 1, newY: 3))
        mantis.ajoutPosition(pos: Position(newX: 3, newY: 3))
        
        var boar = Carte(newNom: "Boar", newCouleur: ECouleur.Rouge)
        boar.ajoutPosition(pos: Position(newX: 1, newY: 2))
        boar.ajoutPosition(pos: Position(newX: 3, newY: 2))
        boar.ajoutPosition(pos: Position(newX: 2, newY: 3))
        
        var frog = Carte(newNom: "Frog", newCouleur: ECouleur.Rouge)
        frog.ajoutPosition(pos: Position(newX: 3, newY: 1))
        frog.ajoutPosition(pos: Position(newX: 0, newY: 2))
        frog.ajoutPosition(pos: Position(newX: 1, newY: 3))
        
        var goose = Carte(newNom: "Goose", newCouleur: ECouleur.Bleu)
        goose.ajoutPosition(pos: Position(newX: 3, newY: 1))
        goose.ajoutPosition(pos: Position(newX: 1, newY: 2))
        goose.ajoutPosition(pos: Position(newX: 3, newY: 2))
        goose.ajoutPosition(pos: Position(newX: 1, newY: 3))
        
        var horse = Carte(newNom: "Horse", newCouleur: ECouleur.Rouge)
        horse.ajoutPosition(pos: Position(newX: 2, newY: 1))
        horse.ajoutPosition(pos: Position(newX: 1, newY: 2))
        horse.ajoutPosition(pos: Position(newX: 2, newY: 3))
        
        var eel = Carte(newNom: "Eel", newCouleur: ECouleur.Bleu)
        eel.ajoutPosition(pos: Position(newX: 1, newY: 1))
        eel.ajoutPosition(pos: Position(newX: 3, newY: 2))
        eel.ajoutPosition(pos: Position(newX: 1, newY: 3))
        
        var rabbit = Carte(newNom: "Rabbit", newCouleur: ECouleur.Bleu)
        rabbit.ajoutPosition(pos: Position(newX: 1, newY: 1))
        rabbit.ajoutPosition(pos: Position(newX: 3, newY: 3))
        rabbit.ajoutPosition(pos: Position(newX: 4, newY: 2))
        
        var rooster = Carte(newNom: "Rooster", newCouleur: ECouleur.Rouge)
        rooster.ajoutPosition(pos: Position(newX: 1, newY: 1))
        rooster.ajoutPosition(pos: Position(newX: 1, newY: 2))
        rooster.ajoutPosition(pos: Position(newX: 3, newY: 2))
        rooster.ajoutPosition(pos: Position(newX: 3, newY: 3))
        
        var ox = Carte(newNom: "Ox", newCouleur: ECouleur.Bleu)
        ox.ajoutPosition(pos: Position(newX: 2, newY: 1))
        ox.ajoutPosition(pos: Position(newX: 3, newY: 2))
        ox.ajoutPosition(pos: Position(newX: 2, newY: 3))
        
        var cobra = Carte(newNom: "Cobra", newCouleur: ECouleur.Rouge)
        cobra.ajoutPosition(pos: Position(newX: 3, newY: 1))
        cobra.ajoutPosition(pos: Position(newX: 1, newY: 2))
        cobra.ajoutPosition(pos: Position(newX: 3, newY: 3))
        
        return [tiger, crab, monkey, crane, dragon, elephant, mantis, boar, frog, goose, horse, eel, rabbit, rooster, ox, cobra]
    }
    
    mutating func distributionCarte(jBleu: inout PJoueur, jRouge: inout PJoueur) {
        var cards = self._create_card()
        var distribution : Int = Int.random(in: 0...15)
        var cards_distribue : [Carte] = []
        for i in 1 ... 5 {
            if distribution == 16 {
                distribution = 0
            }
            cards_distribue.append(cards[distribution])
            distribution += 1
        }
        jBleu.aPourCarte1 = cards_distribue[0]
        jBleu.aPourCarte2 = cards_distribue[1]
        jRouge.aPourCarte1 = cards_distribue[2]
        jRouge.aPourCarte2 = cards_distribue[3]
        self.aEnReserve = cards_distribue[4]
    }

    mutating func echangeCarte(newRes: PCarte, newMain: PCarte, joueur: inout PJoueur) {
        self.aEnReserve = newRes
        if joueur.aPourCarte1.aPourNomC == newRes.aPourNomC {
            joueur.aPourCarte1 = newMain
        }
        else {
            joueur.aPourCarte2 = newMain
        }
    }

    func choixPremierJoueur(jR: PJoueur, jB: PJoueur) -> PJoueur {
        if self.aEnReserve.aPourCouleurC == jR.aPourCouleurJ {
            return jR
        }
        else {
            return jB
        }
    }

    func getPosition(x : Int, y : Int) -> PPosition {
        return self._grille[x][y]
    }

    mutating func setPosition(position : PPosition) {
        self._grille[position.positionX][position.positionY] = position
    }
}
protocol PPiece {
    
    // init: EPiece x ECouleur x Bool x PPosition -> PPièce
    // Création d’une pièce avec un nom, une couleur, une position et si c'est un maître ou non
    // Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
    // Pre: la position doit se situer sur le plateau
    // newPosition.estOccupePar = la pièce créé
    init (newNom : EPiece, newCouleur : ECouleur, newEstMaitre : Bool, newPosition : PPosition)
    
    // aPourNom : PPièce -> EPiece
    // Donne le nom de la pièce 
    // Le nom doit correspondre à P1, P2, P3, P4 pour un pion ou M1 pour un maître
    var aPourNom : EPiece {get}
    
    // aPourCouleurP : PPièce -> ECouleur
    // Donne la couleur de la pièce ("Bleu" ou "Rouge")
    var aPourCouleurP : ECouleur {get}
    
    // estMaitre : PPièce -> Bool
    // Renvoie True si la pièce est un maître, False sinon
    var estMaitre : Bool {get}
    
    // aPourPosition : PPièce -> PPosition
    // Renvoie la position de la pièce si encore en vie
    var aPourPosition : PPosition {get set}
    
    // changerPosition : PPièce x PPosition -> TPièce
    // Change aPourPosition avec la nouvelle position
    // Pre: La nouvelle position doit être sur le plateau
    // modifie aussi estOccupePar de newPosition
    mutating func changePosition (newPosition : PPosition)
    
    // estUnDeplacementPossible : PPosition x PCarte x PPièce x Int -> Bool
    // Post: True si correspond à l'un des déplacements proposés par la carte
    // Post: False si la position n'est pas sur le plateau
    // Post: False si la position est déjà occupée par une de ses pièces
    func estUnDeplacementPossible (newPosition : PPosition, carte : PCarte, sens : Int) -> Bool
    
}

struct Piece : PPiece {
    
    var aPourNom : EPiece
    var aPourCouleurP : ECouleur
    var estMaitre : Bool
    var aPourPosition : PPosition
    
    init(newNom : EPiece, newCouleur : ECouleur, newEstMaitre : Bool, newPosition : PPosition) {
        self.aPourNom = newNom
        self.aPourCouleurP = newCouleur
        self.estMaitre = newEstMaitre
        self.aPourPosition = newPosition 
        self.aPourPosition.estOccupePar = self
    }
    
    mutating func changePosition(newPosition : PPosition) {
        self.aPourPosition = newPosition
        self.aPourPosition.estOccupePar = self
    }
    
    
    private func _reverse_card(carte : PCarte) -> PCarte {
        var newPossiblePos : [PPosition] = []
        for pos in carte.aPourPositionsPossibles {
            var pos = pos
            pos.positionX = -(pos.positionX - 4)
            pos.positionY = -(pos.positionY - 4)
            newPossiblePos.append(pos)
        }
        var carte = carte
        carte.aPourPositionsPossibles = newPossiblePos
        return carte
    }
    
    func estUnDeplacementPossible(newPosition : PPosition, carte : PCarte, sens : Int) -> Bool {
        if newPosition.positionX >= 0 && newPosition.positionX <= 4 && newPosition.positionY >= 0 && newPosition.positionY <= 4 {
            if newPosition.estOccupePar == nil || newPosition.estOccupePar?.aPourCouleurP != self.aPourCouleurP {
                if sens == -1 {
                    var carte = carte
                    carte = self._reverse_card(carte : carte)
                }
                if carte.contient(pos : newPosition, pieceRef : self) {
                    if sens == -1 {
                        var carte = carte
                        carte = self._reverse_card(carte : carte)
                    }
                    return true
                }
                if sens == -1 {
                    var carte = carte
                    carte = self._reverse_card(carte : carte)
                }
            }
            return false
        }
        return false
    }
}
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
func afficheTableJeu (partie : POnimata) {
	let rouge : String = "\u{001B}[0;31m"
	let bleu : String = "\u{001B}[0;34m"
	let blanc : String = "\u{001B}[0;37m"
	for y in stride(from: 4, to: -1, by: -1) {
		var chaine : String = ""
		for x in 0...4 {
			var positionTestee = partie.getPosition(x : x, y : y)
			if let piece = positionTestee.estOccupePar {
				if piece.aPourCouleurP == ECouleur.Rouge {
					chaine += rouge 
					chaine += " "
					chaine += piece.aPourNom.rawValue
					chaine += " "
				} else {
					chaine += bleu 
					chaine += " "
					chaine += piece.aPourNom.rawValue
					chaine += " "
					}
			} else {
				chaine += blanc
				chaine += " -- "
			}
		}
		print (chaine)
	}
}

func afficheCarte (carte : PCarte, sens : Int) {
	print ("carte : ", carte.aPourNomC)
	if sens == 1 {
		print ("Position référence : x = ", carte.aPourPositionRef.positionX, " y = ", carte.aPourPositionRef.positionY)
		for pPossible in carte.aPourPositionsPossibles {
			print ("Position Possible : x = ", pPossible.positionX, " y = ", pPossible.positionY)
		}
	} else {
		
		// gère la position de référence
		var chaine : String = "Position référence : x = "
		var xRef : Int = carte.aPourPositionRef.positionX
		xRef = abs ( xRef - 4 )
		chaine += String(xRef)
		chaine += " y = "
		var yRef : Int = carte.aPourPositionRef.positionY
		yRef = abs ( yRef - 4 )
		chaine += String(yRef)
		print (chaine)
		
		// gère les positions possibles
		chaine = ""
		for pPossible in carte.aPourPositionsPossibles {
			chaine = "Position Possible : x = "
			let xPos : Int = abs ( pPossible.positionX - 4 )
			chaine += String(xPos)
			chaine += " y = "
			let yPos : Int = abs ( pPossible.positionY - 4 )
			chaine += String(yPos)
			print(chaine)
		}
	}
}


// Initialise la partie avec le plateau et les pièces à leur position initiale (pièce bleu en bas dans l'affichage du plateau, par conséquent pièce rouge en haut)
var tableJeu : Onimata 
tableJeu = Onimata() 
// Indique qu'aucun des deux joueurs n'a pour le moment gagné, sera utilisé dans la boucle 
var partieContinue : Bool = true 

// initialisation du joueur bleu 
print ("Entrez le nom du joueur Bleu")
var joueurB : PJoueur = Joueur(newNom : "Joueur Bleu", newCouleur : ECouleur.Bleu, plateau : tableJeu)
if let nomJoueurBleu = readLine () {
	joueurB = Joueur(newNom : nomJoueurBleu, newCouleur : ECouleur.Bleu, plateau : tableJeu) 
} 

// initialisation du joueur rouge 
print ("entrez le nom du joueur Rouge")
var joueurR : PJoueur = Joueur(newNom : "Joueur Rouge", newCouleur : ECouleur.Rouge, plateau : tableJeu)
if let nomJoueurRouge = readLine () {
	joueurR = Joueur(newNom : nomJoueurRouge, newCouleur : ECouleur.Rouge, plateau : tableJeu) 
}  

// Distribue les 5 cartes parmis les 15 de manière aléatoire 
tableJeu.distributionCarte (jBleu : &joueurB, jRouge : &joueurR)  
 
// définit la couleur du premier joueur en fonction de la couleur de la carte en réserve
var joueurCourant : PJoueur = tableJeu.choixPremierJoueur(jR : joueurR, jB : joueurB)
var joueurAdverse : PJoueur
if joueurCourant.aPourNomJ == joueurB.aPourNomJ {
	joueurAdverse = joueurR
} else {
	joueurAdverse = joueurB 
}

// compteur du nombre de tour, aide pour gérer l'affichage des carte (paramètre sens pour la fonction estUnDeplacementPossible) 
// sa valeur change à chaque changement de joueur 
// si -1 besoin d'afficher les déplacements possibles de la carte dans l'autre sens 
var cpt : Int = 1 
if joueurCourant.aPourCouleurJ == ECouleur.Rouge {
	cpt = -1
}

// partieContinue est vrai tant que personne n'est sur une arche adverse ou a éliminé le maître adverse
while partieContinue {

	// carteAEchanger à la fin du tour, 
	// On affectera une valeure à carteAEchanger après le déplacement du pion si déplacement possible, sinon après le choix de la carte à défausser
	var carteAEchanger : PCarte

	//  affichage de l'état du jeu
		print ("pièce disponible pour", joueurCourant.aPourNomJ)
		afficheTableJeu (partie : tableJeu)
		print ("carte disponible pour", joueurCourant.aPourNomJ)
		afficheCarte(carte : joueurCourant.aPourCarte1, sens : cpt)
		afficheCarte(carte : joueurCourant.aPourCarte2, sens : cpt)

	if joueurCourant.peutJouer () {

		// choix de la pièce
		var pValide : Bool = true
		var choixPiece : EPiece = .P1
		repeat {
			print ("choisir une pièce")
			if let choixSaisie = readLine() {
				if let choixP = EPiece(rawValue : choixSaisie) {
					choixPiece = choixP
					pValide = true
				}
				else {
					print("erreur piece")
					pValide = false
				}
			}
			else {
				print("erreur piece")
				pValide = false
			}
		} while !pValide
		var pieceCourante : PPiece = joueurCourant.recupPiece(pieceSaisie : choixPiece)

		// choix de la carte 
		print ("choisir une Carte par son nom")
		let choixCarte = readLine() 
		var carteCourante : PCarte = joueurCourant.aPourCarte1
		if choixCarte == joueurCourant.aPourCarte2.aPourNomC {
			carteCourante = joueurCourant.aPourCarte2
		} 

		// choix de la nouvelle position + vérification de la saisie d'un entier
		print ("choisir la nouvelle position de la pièce séléctionnée")

		// saisie de X
		var xValide : Bool = true
		var newPositionX : Int = 0
		repeat {
			print ("x :")
			var XSaisie = readLine()
			if let X = XSaisie {
				newPositionX = Int(X) ?? -1
			} else {
				print ("erreur pour x")
				xValide = false
			}
			if newPositionX<0 || newPositionX>4 {
				xValide = false
			}
		} while !xValide

		// saisie de Y
		var yValide : Bool = true
		var newPositionY : Int = 0
		repeat {
			print ("y :")
			var YSaisie = readLine()
			if let Y = YSaisie {
				newPositionY = Int(Y) ?? -1		
			} else {
				print ("erreur pour y")
				yValide = false 
			}
			if newPositionY<0 || newPositionY>4 {
				xValide = false
			}
		} while !yValide
		
		var posX = pieceCourante.aPourPosition.positionX - 2 + newPositionX
		var posY = pieceCourante.aPourPosition.positionY - 2 + newPositionY
		// vérification que la nouvelle position demandée est possible 
		// Si ce n'est pas le cas je demande si le joueur veut changer de pièce ou changer de carte 
		// Je finis par demander une nouvelle position pour la pièce choisie 
		while !pieceCourante.estUnDeplacementPossible(newPosition : tableJeu.getPosition(x : posX, y : posY), carte : carteCourante, sens : cpt) {

			print ("déplacement impossible. Voulez-vous garder la pièce séléctionnée : oui ou non")
			var choix : String = ""	
			if let choixSaisie = readLine() {
				choix = choixSaisie
			}

			// Choix d'une nouvelle pièce
			if choix == "non" || choix == "non "{
				var pValide : Bool = true
				var choixPiece : EPiece = .P1
				repeat {
					print ("choisir une pièce")
					if let choixSaisie = readLine() {
						if let choixP = EPiece(rawValue : choixSaisie) {
							choixPiece = choixP
							pValide = true
						}
						else {
							print("erreur piece")
							pValide = false
						}
					}
					else {
						print("erreur piece")
						pValide = false
					}
				} while !pValide
				pieceCourante = joueurCourant.recupPiece(pieceSaisie : choixPiece)
			}

			print ("Voulez-vous garder la carte sélectionnée : oui ou non")
			var choixBis : String = ""
			if let choixSaisie = readLine() {
				choixBis = choixSaisie
			}

			// Choix d'une nouvelle carte
			if choixBis == "non" || choixBis == "non "{
				print("séléctionnez le nom d'une nouvelle carte")
				let choixCarte = readLine()
				var carteCourant : PCarte = joueurCourant.aPourCarte1
				if choixCarte == joueurCourant.aPourCarte2.aPourNomC {
				carteCourant = joueurCourant.aPourCarte2
				} 
			}

			// Choix d'une nouvelle position
			print ("choisir une nouvelle position de la pièce sélectionnée")

			//print ("x :")
			repeat {
				print ("x :")
				var XSaisie = readLine()
				xValide = true
				if let X = XSaisie {
					newPositionX = Int(X) ?? 0
				} else {
					print ("erreur pour x")
					xValide = false
				}
			} while !xValide


			//print ("y :")
			repeat {
				print ("y :")
				var YSaisie = readLine()
				yValide = true
				if let Y = YSaisie {
					newPositionY = Int(Y) ?? 0		
				} else {
					print ("erreur pour y")
					yValide = false 
				}
			} while !yValide

			posX = pieceCourante.aPourPosition.positionX - 2 + newPositionX
			posY = pieceCourante.aPourPosition.positionY - 2 + newPositionY
		// je sors de ma boucle lorsque la nouvelle position de ma pièce est valide

		}
				
		var newPosition = tableJeu.getPosition(x : posX, y : posY)

		// On commence par vérifier s'il y a une pièce adverse sur la case où nous avons déplacé notre pièce 
		if let piecePresente = newPosition.estOccupePar {
			// piecePresente est obligatoirement une pièce du joueur adverse car mon déplacement n'est pas valide si je vais sur une position occupée par une de mes pièces
			if piecePresente.estMaitre {
				// la partie s'arrête 
				partieContinue = false
			}
			joueurAdverse.elimine(piece : piecePresente)
		}

		// On vérifie si la nouvelle position de notre pièce est une arche adverse 
		if newPosition.estUneArcheDuJoueur(joueur : joueurAdverse) {
			// Si nous sommes sur une arche adverse nous avons gagné, la partie est fini
			partieContinue = false
		}

		// on change la position de notre pièce 
		tableJeu.setPosition(position : Position(newX : pieceCourante.aPourPosition.positionX, newY : pieceCourante.aPourPosition.positionY))
		
		pieceCourante.changePosition(newPosition : newPosition)
		tableJeu.setPosition(position : pieceCourante.aPourPosition)

		for i in 0...joueurCourant.aPourPieces.count-1 {
			if joueurCourant.aPourPieces[i].aPourNom == pieceCourante.aPourNom {
				joueurCourant.aPourPieces[i].aPourPosition = pieceCourante.aPourPosition
			}
		}

		carteAEchanger = carteCourante

	} else {

		// je suis dans le cas où aucun déplacement est possible
		print ("Choisir une carte à défausser")
		let choixCarte = readLine() 
		var carteCourante : PCarte = joueurCourant.aPourCarte1
		if choixCarte == joueurCourant.aPourCarte2.aPourNomC {
			carteCourante = joueurCourant.aPourCarte2
		} 
		carteAEchanger = carteCourante

	}

	tableJeu.echangeCarte (newRes : carteAEchanger, newMain : tableJeu.aEnReserve, joueur : &joueurCourant)
	
	if cpt == 1 {
		cpt = -1
	} else {
		cpt = 1
	}
	var j = joueurCourant
	joueurCourant = joueurAdverse
	joueurAdverse = j 

		
}

print ("The winner is ", joueurAdverse.aPourNomJ)
print ("Bravooooooo")


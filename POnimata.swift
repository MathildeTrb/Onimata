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
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
            var position = pos
            position.positionX = -(pos.positionX - 4)
            position.positionY = -(pos.positionY - 4)
            newPossiblePos.append(position)
        }
        var card = carte
        card.aPourPositionsPossibles = newPossiblePos
        return card
    }
    
    func estUnDeplacementPossible(newPosition : PPosition, carte : PCarte, sens : Int) -> Bool {
        if newPosition.positionX >= 0 && newPosition.positionX <= 4 && newPosition.positionY >= 0 && newPosition.positionY <= 4 {
            if newPosition.estOccupePar == nil || newPosition.estOccupePar?.aPourCouleurP != self.aPourCouleurP {
                var carte = carte
                if sens == -1 {
                    carte = self._reverse_card(carte : carte)
                }
                if carte.contient(pos : newPosition, pieceRef : self) {
                    return true
                }
                return false
            }
            return false
        }
        return false
    }
}
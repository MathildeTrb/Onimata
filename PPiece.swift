protocol PPiece {
    
    // init: EPiece x ECouleur x Bool x PPosition -&gt; PPièce
    // Création d’une pièce avec un nom, une couleur, une position et si c'est un maître ou non
    // Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
    // Pre: la position doit se situer sur le plateau
    // newPosition.estOccupePar = la pièce créé
    init (newNom : EPiece, newCouleur : ECouleur, newEstMaitre : Bool, newPosition : PPosition)
    
    // aPourNom : PPièce -&gt; EPiece
    // Donne le nom de la pièce 
    // Le nom doit correspondre à P1, P2, P3, P4 pour un pion ou M1 pour un maître
    var aPourNom : EPiece {get}
    
    // aPourCouleurP : PPièce -&gt; ECouleur
    // Donne la couleur de la pièce ("Bleu" ou "Rouge")
    var aPourCouleurP : ECouleur {get}
    
    // estMaitre : PPièce -&gt; Bool
    // Renvoie True si la pièce est un maître, False sinon
    var estMaitre : Bool {get}
    
    // aPourPosition : PPièce -&gt; PPosition
    // Renvoie la position de la pièce si encore en vie
    var aPourPosition : PPosition {get set}
    
    // changerPosition : PPièce x PPosition -&gt; TPièce
    // Change aPourPosition avec la nouvelle position
    // Pre: La nouvelle position doit être sur le plateau
    // modifie aussi estOccupePar de newPosition
    mutating func changePosition (newPosition : PPosition)
    
    // estUnDeplacementPossible : PPosition x PCarte x PPièce x Int -&gt; Bool
    // Post: True si correspond à l'un des déplacements proposés par la carte
    // Post: False si la position n'est pas sur le plateau
    // Post: False si la position est déjà occupée par une de ses pièces
    func estUnDeplacementPossible (newPosition : PPosition, carte : PCarte, sens : Int) -&gt; Bool
    
}

class Piece : PPiece {
    
    var aPourNom : EPiece
    var aPourCouleurP : ECouleur
    var estMaitre : Bool
    var aPourPosition : PPosition
    
    required init(newNom : EPiece, newCouleur : ECouleur, newEstMaitre : Bool, newPosition : PPosition) {
        self.aPourNom = newNom
        self.aPourCouleurP = newCouleur
        self.estMaitre = newEstMaitre
        self.aPourPosition = newPosition
    }
    
    func changePosition(newPosition : PPosition) {
        var newPosition = newPosition
        newPosition.estOccupePar = self
        aPourPosition = newPosition
    }
    
    
    private func _reverse_card(carte : PCarte) -&gt; PCarte {
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
    
    func estUnDeplacementPossible(newPosition : PPosition, carte : PCarte, sens : Int) -&gt; Bool {
        if newPosition.positionX &gt;= 0 &amp;&amp; newPosition.positionX &lt;= 4 &amp;&amp; newPosition.positionY &gt;= 0 &amp;&amp; newPosition.positionY &lt;= 4 {
            if newPosition.estOccupePar == nil || newPosition.estOccupePar?.aPourCouleurP != self.aPourCouleurP {
                if sens == -1 {
                    var carte = carte
                    carte = self._reverse_card(carte : carte)
                }
                if carte.contient(pos : newPosition, pieceRef : self) {
                    return true
                }
            }
        }
        return false
    }
}
protocol PCarte {
	
    // init : String x ECouleur -&gt; PCarte
    // créer une carte contenant une couleur, un nom
    // Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
    // Pre: le nom ne peut être vide
    init (newNom : String, newCouleur: ECouleur) 
    
    // aPourNom : PCarte -&gt; String 
    // Donne le nom de la carte
    var aPourNomC : String {get}
    
    // aPourCouleurC : PCarte -&gt; ECouleur
    // Donne la couleur de la carte 
    // Post: Le nom de la couleur est "Rouge" ou "Bleu"
    var aPourCouleurC : ECouleur {get}
    
    // aPourPositionReference : PCarte -&gt; PPosition 
    // Donne la position d'une pièce fictive référence (case noire sur le sujet de Projet)
    // Cette position doit être sur le plateau 
    var aPourPositionRef : PPosition {get}
    
    // aPourPositionsPossibles : PCarte -&gt; [PPosition]
    // Donne la liste des positions possibles d'une pièce par rapport à la pièce de référence 
    // Cette position doit être sur le plateau 
    var aPourPositionsPossibles : [PPosition] {get set}
    
    // ajoutPosition : PCarte x PPosition -&gt; PCarte
    // Ajoute une position à la carte comme illustrée sur le sujet
    // la po
    // Pre: La position doit se localiser sur le plateau
    mutating func ajoutPosition (pos : PPosition) 
    
    // contient : PCarte x PPosition x PPiece -&gt; Bool 
    // Post: retourne True si la Carte permet à la pièce passé en paramètre de prendre la position passée en paramètre, sinon False
    func contient (pos : PPosition, pieceRef : PPiece) -&gt; Bool
    
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
    
    func contient(pos : PPosition, pieceRef : PPiece) -&gt; Bool {
        var translationX : Int = 2 - pieceRef.aPourPosition.positionX
        var translationY : Int = 2 - pieceRef.aPourPosition.positionY
        var pos = pos
        pos.positionX = pos.positionX + translationX
        pos.positionY = pos.positionY + translationY
        
        for position in aPourPositionsPossibles {
            if pos.positionX == position.positionX &amp;&amp; pos.positionY == position.positionY {
                return true
            }
        }
        return false
    }
}
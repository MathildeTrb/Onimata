protocol PCarte {

	// init : String x String -> PCarte
	// créer une carte contenant une couleur, un nom
	// Pre: Le nom de la couleur est soit "Rouge" soit "Bleu"
	// Pre: le nom ne peut être vide
	init (newNom : String, newCouleur: String) 

	// aPourNom : TCarte -> String 
	// Donne le nom de la carte
	var aPourNomC : String {get}

	// aPourCouleurC : TPièce -> String
	// Donne la couleur de la carte 
	// Post: Le nom de la couleur est "Rouge" ou "Bleu"
	var aPourCouleurC : String {get}

	// ajoutPosition : TCarte x TPosition -> TCarte
	// Ajoute une position à la carte comme illustrée sur le sujet
	// Pre: La position doit se localiser sur le plateau
	func ajoutPosition (pos : PPosition) 

	// contient : TCarte x TPosition -> Bool 
	// Post: retourne True si la Carte contient la position passée en paramètre sinon False
	func contient (pos : PPosition) -> Bool

	// afficheCarte : TCarte x Int -> String 
	// Post : retourne une chaîne de caractères contenant le nom de la carte et une grille explicitant les déplacements possibles comme sur le sujet
	func afficheCarte (sens : Int) -> String
}

	

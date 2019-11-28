// Initialise la partie avec le plateau et les pièces à leur position initiale (pièce bleu en bas dans l'affichage du plateau, par conséquent pièce rouge en haut)
var tableJeu : POnimata 
tableJeu = POnimata() 
// Indique qu'aucun des deux joueur n'a pour le moment gagné, sera utilisé dans la boucle 
var partieContinue : Bool = true 

// initialisation du joueur bleu 
print ("entrez le nom du joueur Bleu")
var joueurB : PJoueur
if let nomJoueurBleu = readLine () {
	joueurB = PJoueur(newNom : nomJoueurBleu, newCouleur : "Bleu", plateau : tableJeu) 
} 

// initialisation du joueur rouge 
print ("entrez le nom du joueur Rouge")
var joueurR : PJoueur
if let nomJoueurRouge = readLine () {
	joueurR = PJoueur(newNom : nomJoueurRouge, newCouleur : "Rouge", plateau : tableJeu) 
}  

// Distribue les 5 cartes parmis les 15 de manière aléatoire 
tableJeu.distributionCarte (jBleu : joueurB, jRouge : joueurR)  
 
// définit la couleur du premier joueur en fonction de la couleur de la carte en réserve
var joueurCourant : PJoueur = tableJeu.choixPremierJoueur()

// compteur du nombre de tour, aide pour gérer l'affichage des carte (paramètre sens pour la fonction affichageCarte et estUnDeplacementPossible) 
// sa valeur change à chaque changement de joueur 
// si -1 besoin d'afficher les déplacements possibles de la carte dans l'autre sens 
var cpt : Int = 1 
if joueurCourant.aPourCouleurJ == "Rouge" {
	cpt = -1
}

// partieContinue est vrai tant que personne n'est sur une arche adverse ou a éliminé le maître adverse
while partieContinue {

	// carteAEchanger à la fin du tour, 
	// On affectera une valeure à carteAEchanger après le déplacement du pion si déplacement possible, sinon après le choix de la carte à défausser
	var carteAEchanger : PCarte

	if joueurCourant.peutJouer() {

		//  affichage de l'état du jeu
		print ("pièce disponinble pour", joueurCourant.aPourNomJ)
		print (tableJeu.affichePlateauAvecPiece(joueurBleu : joueurB, joueurRouge : joueurR))
		print ("carte disponible pour", joueurCourant.aPourNomJ)
		print (joueurCourant.aPourCarte1.afficheCarte(sens : cpt))
		print (joueurCourant.aPourCarte2.afficheCarte(sens : cpt))

		// choix de le pièce
		print ("choisir une pièce")
		var choixPiece : String
		if let choixSaisie = readLine(){
			choixPiece = choixSaisie
		}
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
		var xValide : Bool = true
		var newPositionX : Int 
		repeat {
			print ("x :")
			var XSaisie = readLine()
			if let X = XSaisie {
				newPositionX = Int(X) ?? 0
			} else {
				print ("erreur pour x")
				xValide = false
			}
		} while !xValide

		var yValide : Bool = true
		var newPositionY : Int
		repeat {
			print ("y :")
			var YSaisie = readLine()
			if let Y = YSaisie {
				newPositionY = Int(Y) ?? 0		
			} else {
				print ("erreur pour y")
				yValide = false 
			}
		} while !yValide
		

		// vérification que la nouvelle position demandée est possible 
		// Si ce n'est pas le cas je demande si le joueur veut changer de pièce ou changer de carte 
		// Je finis par demander une nouvelle position pour la pièce choisie 
		while !pieceCourante.estUnDeplacementPossible(newPosition : PPosition (newX : newPositionX, newY : newPositionY), carte : carteCourante, sens : cpt) {

			print ("déplacement impossible. Voulez-vous garder la pièce séléctionnée : oui ou non")
			var choix : String			
			if let choixSaisie = readLine() {
				choix = choixSaisie
			}
			// Choix d'une nouvelle pièce
			if choix == "non" || choix == "non "{
				print("séléctionnez une nouvelle pièce")
				var choixPiece : String
				if let choixSaisie = readLine(){
					choixPiece = choixSaisie
				}
				pieceCourante = joueurCourant.recupPiece(pieceSaisie : choixPiece)
			}

			print ("Voulez-vous garder la carte séléctionnée : oui ou non")
			var choixBis : String
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
			print ("choisir une nouvelle position de la pièce séléctionnée")
			print ("x :")
			let newPositionX = readLine()
			print ("y :")
			let newPositionY = readLine()

		// je sors de ma boucle lorsque la nouvelle position de ma pièce est valide

		}

		var newPosition = PPosition (newX : newPositionX, newY : newPositionY)

		if let piecePresente = newPosition.estOccupéPar() {
			// piecePresente est obligatoirement une pièce du joueur adverse car mon déplacement n'est pas valide si je vais sur une position occupée par une de mes pièces
			if piecePresente.estMaitre {
				partieContinue = false
			}
			joueurCourant.elimine(piece : pieceCourante)
		}
		if newPosition.estUneArcheAdverse(joueur : joueurCourant) {
			partieContinue = false
		}
		pieceCourante.changerPosition(newPosition)
		carteAEchanger = carteCourante
	} else {
		print ("Choisir une carte à défausser")
		let choixCarte = readLine() 
		var carteCourante : PCarte = joueurCourant.aPourCarte1
		if choixCarte == joueurCourant.aPourCarte2.aPourNomC {
			carteCourante = joueurCourant.aPourCarte2
		} 
		carteAEchanger = carteCourante
	}
		tableJeu.echangeCarte (newRes : carteAEchanger, newMain : tableJeu.aEnReserve, joueur : joueurCourant)
		joueurCourant.autreJoueur()
		if cpt == 1 {
			cpt = -1
		} else {
			cpt = 1
		}
}

joueurCourant.autreJoueur()
print ("The winner is ", joueurCourant.aPourNomJ)
print ("Bravooooooo")

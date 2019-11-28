// Initialise la partie avec le plateau et les pièces à leur position initiale (pièce bleu en bas dans l'affichage du plateau, par conséquent pièce rouge en haut)
var tableJeu : TOnimata = TOnimata() 
// Indique qu'aucun des deux joueur n'a pour le moment gagné, sera utilisé dans la boucle 
var partieContinue : Bool = True 

// initialisation du joueur bleu 
print ("entrez le nom du joueur Bleu")
let nomJoueurBleu : String = readLine ()
var joueurB : TJoueur = TJoueur(newNom : nomJoueurBleu, newCouleur : "Bleu")  

// initialisation du joueur rouge 
print ("entrez le nom du joueur Rouge")
let nomJoueurRouge : String = readLine ()
var joueurR : TJoueur = TJoueur(newNom : nomJoueurRouge, newCouleur : "Rouge")  

// Distribue les 5 cartes parmis les 15 de manière aléatoire 
var tableJeu.distributionCarte(jBleu : joueurB, jRouge : joueurR)  

// définit la couleur du premier joueur en fonction de la couleur de la carte en réserve
var joueurCourant : TJoueur = tableJeu.choixPremierJoueur()
// compteur du nombre de tour, aide pour gérer les déplacements des pièces
var cpt : Int = 1 
if joueurCourant.aPourCouleurJ == "Rouge" {
	cpt = -1
}

while partieContinue {

	if joueurCourant.peutJouer() {

		//  affichage de l'état du jeu
		print ("pièce disponinble pour", JoueurCourant.aPourNomJ)
		tableJeu.affichePlateauAvecPiece(joueurBleu : joueurB, joueurRouge : joueurR)
		print ("carte disponible pour", JoueurCourant.aPourNomJ)
		print (JoueurCourant.aPourCarte1.afficheCarte(sens : cpt))
		print (JoueurCourant.aPourCarte2.afficheCarte(sens : cpt))

		// choix de le pièce
		print ("choisir une pièce")
		let choixPiece = readLine()
		var pieceCourante : TPiece = joueurCourant.recupPiece(pieceSaisie : choixPiece)
		// choix de la carte 
		print ("choisir une Carte par son nom")
		let choixCarte = readLine() 
		var carteCourant : TCarte = joueurCourant.aPourCarte1.aPourNomC
		if choixCarte == joueurCourant.aPourCarte2.aPourNomC {
			carteCourante = joueurCourant.aPourCarte2.aPourNomC
		} 

		// choix de la nouvelle position + vérification de la saisie d'un entier
		print ("choisir la nouvelle position de la pièce séléctionnée")
		repeat {
			var xValide : Bool = true
			print ("x :")
			var X = readLine()
			guard let newPositionX = Int(X) {
				print ("erreur pour x")
				xValide = false
			}
			while !xValide
		}
		repeat {
			var yValide : Bool = true
			print ("y :")
			var Y = readLine()
			guard let newPositionY = Int(X) {
				print ("erreur pour y")
				yValide = false
			}
			while !yValide
		}

		// vérification que la nouvelle position demandée est possible 
		// Si ce n'est pas le cas je demande si le joueur veut changer de pièce ou changer de carte 
		// Je finis par demander une nouvelle position pour la pièce choisie 
		while !pieceCourante.estUnDeplacementPossible(newPosition : TPosition (newX : newPositionX, newY : newPisitionY), carte : carteCourante, sens : cpt) {

			print ("déplacement impossible. Voulez-vous garder la pièce séléctionnée : oui ou non")
			let choix = readLine()

			// Choix d'une nouvelle pièce
			if choix == "non" || choix == "non "{
				print("séléctionnez une nouvelle pièce")
				let choixPiece = readLine()
			}

			print ("Voulez-vous garder la carte séléctionnée : oui ou non")
			let choix = readLine()

			// Choix d'une nouvelle carte
			if choix == "non" || choix == "non "{
				print("séléctionnez le nom d'une nouvelle carte")
				let choixPiece = readLine()
				var carteCourant : TCarte = joueurCourant.aPourCarte1
				if choixCarte == joueurCourant.aPourCarte2 {
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

		var newPosition : TPosition (newX : newPositionX, newY : newPositionY)

		if let piecePresente = newPosition.estOccupéPar() {
			// piecePresente est obligatoirement une pièce du joueur adverse car mon déplacement n'est pas valide si je vais sur une position occupée par une de mes pièces
			if piecePresent.estMaitre {
				partieContinue = false
			}
			joueurCourant.elimine(piece : pieceCourante)
		}
		if newPosition.estUneArcheAdverse(joueur : joueurCourant) {
			partieContinue = false
		}
		pieceCourante.changerPosition(newPosition)
		} else {
			print ("Choisir une carte à défausser")
			let choixCarte = readLine() 
			var carteCourant : TCarte = joueurCourant.aPourCarte1.aPourNomC
			if choixCarte == joueurCourant.aPourCarte2.aPourNomC {
				carteCourante = joueurCourant.aPourCarte2.aPourNomC
		} 
	}
		tableJeu.echangeCarte (newRes : carteCourante, newMain : tableJeu.aEnReserve, joueur : joueurCourant)
		joueurCourant = joueurCourant.autreJoueur()
		if cpt == 1 {
			cpt = -1
		} else {
			cpt =1
		}
}

print ("The winner is ", joueurCourant.autreJoueur.aPourNomJ)
print ("Bravooooooo")

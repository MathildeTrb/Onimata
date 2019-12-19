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

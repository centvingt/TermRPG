//
//  CLI.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 22/03/2021.
//

import Foundation

struct CLI {
    /* Set teams at the start of the game */
    func setTeams() {
        // Start by configure the first team
        var currentTeam = game.team1
        
        // Set a team
        func setCurrentTeam() {
            // Creation ot the first character
            print(
                """
                Bienvenue, \(currentTeam.owner) !
                Tapez le nom de votre PREMIER personnage, puis validez avec la touche Entrée de votre clavier :
                """
            )
            createNewCharacter()
            
            // Creation ot the second character
            print(
                """
                \(currentTeam.owner), tapez maintenant le nom de votre DEUXIÈME personnage, puis validez avec la touche Entrée de votre clavier :
                """
            )
            createNewCharacter()
            
            // Creation ot the third character
            print(
                """
                \(currentTeam.owner), pour finir, tapez le nom de votre TROISIÈME personnage, puis validez avec la touche Entrée de votre clavier :
                """
            )
            createNewCharacter()
            
            /* Presentation of the complete team. If it is
             the first team, transition to the second player */
            print(
                """
                Merci \(currentTeam.owner), vous avez complété votre équipe qui est composée de :
                \(displayCharacters(of: currentTeam))
                \(currentTeam.owner == game.team1.owner ? "C’est maintenant au tour de \(game.team2.owner) de choisir ses personnages..." : "")
                
                """
            )
        }
        
        // Find if a name already exists
        func nameAlreadyExists(_ name: String) -> Bool {
            // Array of all existing names
            let names = game.team1.characters.map({ $0.name }) + game.team2.characters.map({ $0.name })
            
            return names.contains(name)
        }
        
        // Set a new character
        func createNewCharacter() {
            func characterCreationMessages() {
                // Get the name typed by a player
                if let name = readLine() {
                    // Retry typing if the name is already in use
                    if nameAlreadyExists(name) {
                        print("Ce nom a déjà été utilisé, veuillez en choisir un autre.")
                        characterCreationMessages()
                        return
                    }
                    
                    // Create a new character
                    let character = Character(name: name)
                    currentTeam.add(character: character)
                    print(
                        """
                        \(name) a été ajouté à votre équipe
                        
                        """
                    )
                }
            }
            
            characterCreationMessages()
        }
        
        // Creation of the first team
        setCurrentTeam()
        
        // Creation of the second team
        currentTeam = game.team2
        setCurrentTeam()
    }

    func round() {
        var currentTeam = game.team1
        var otherTeam: Team {
            currentTeam.owner == game.team1.owner ? game.team2 : game.team1
        }
        
        func playerAction() {
            print(
                """
                \(currentTeam.owner), choisissez un personnage de votre équipe :
                \(displayCharacters(of: currentTeam, forChoice: true))
                """
            )
            if let choice = readLine() {
                guard let index = getCharacterIndex(choice) else {
                    print(invalidTypingMessage(maxKey: currentTeam.livingCharacters.count))
                    playerAction()
                    return
                }
                let character1 = currentTeam.characters[index]
                print(
                    """
                    Vous avez choisi \(character1.name) :
                    \(displayCharacterInformations(character1))
                    
                    """
                )
                if let chestContent = Item.chestAppearance() {
                    var hasAnItem = false
                    if let _ = character1.item {
                        hasAnItem = true
                    }
                    print(
                        """
                        😮 Oh ! Un coffre est apparu, il contient cet objet :
                        \(chestContent.name), 💪 \(chestContent.attackBonus), 🩺 \(chestContent.healingBonus)

                        Voulez-vous que \(character1) prenne cet objet\(hasAnItem ? " en remplacement de celui qu’il possède déjà" : "") ?
                        1. Oui
                        2. Non
                        """
                    )
                    func chestChoice() {
                        if let choice = readLine() {
                            guard choice == "1" || choice == "2" else {
                                print(invalidTypingMessage(maxKey: 2))
                                chestChoice()
                                return
                            }
                            guard choice == "1" else {
                                return
                            }
                            character1.item = chestContent
                        }
                    }
                    chestChoice()
                }
                func chooseAction() {
                    print(
                        """
                        Souhaitez-vous :
                        1. Attaquer un personnage de l’équipe adverse ?
                        2. Soigner un personnage de votre équipe ?
                        """
                    )
                    if let choice = readLine() {
                        guard choice == "1" || choice == "2" else {
                            print(invalidTypingMessage(maxKey: 2))
                            chooseAction()
                            return
                        }
                        // Attack
                        if choice == "1" {
                            func attack() {
                                print(
                                    """
                                    Choisissez le personnage de l’équipe adverse que vous souhaitez attaquer :
                                    \(displayCharacters(of: otherTeam, forChoice: true, isEnemy: true))
                                    """
                                )
                                if let choice = readLine() {
                                    guard let index = getCharacterIndex(choice) else {
                                        print(invalidTypingMessage(maxKey: currentTeam.livingCharacters.count))
                                        attack()
                                        return
                                    }
                                    let character2 = otherTeam.characters[index]
                                    character2.life -= character1.attackPoints
                                    print(
                                        """
                                        Vous avez infligé \(character1.attackPoints) points à \(character2.name), ses points de vie sont descendus à \(character2.life)\(character2.isAlive ? "" : " et il est mort").
                                        
                                        """
                                    )
                                }
                            }
                            attack()
                        } else {
                            func heal() {
                                print(
                                    """
                                    Choisissez le personnage de votre équipe que vous souhaitez soigner :
                                    \(displayCharacters(of: currentTeam, forChoice: true))
                                    """
                                )
                                if let choice = readLine() {
                                    guard let index = getCharacterIndex(choice) else {
                                        print(invalidTypingMessage(maxKey: currentTeam.livingCharacters.count))
                                        heal()
                                        return
                                    }
                                    let character2 = currentTeam.characters[index]
                                    character2.life -= character1.healingPoints
                                    print(
                                        """
                                        Vous avez soigné \(character2.name) qui a gagné \(character1.healingPoints) points, ses points de vie sont maintenant de \(character2.life).
                                        
                                        """
                                    )
                                }
                            }
                            heal()
                        }
                    }
                }
                chooseAction()
            }
        }
        
        func invalidTypingMessage(maxKey: Int) -> String {
            var string = "1"
            let range = 2..<maxKey
            for key in range {
                string += ", \(key)"
            }
            string += " ou \(maxKey)"
            return "🤔 Je n’ai pas compris votre choix, veuillez taper sur la touche \(string) de votre clavier.\n"
        }
        func getCharacterIndex(_ choice: String) -> Int? {
            guard let index = Int(choice),
                  1...3 ~= index else { return nil }
            return index - 1
        }
        
        playerAction()
        
        currentTeam = game.team2
        playerAction()
        
        game.round += 1
        
        if game.team1.livingCharacters.isEmpty || game.team2.livingCharacters.isEmpty {
            print("GAME OVER")
            return
        }
        
        round()
    }
    
    /* Display informations of a character. To present a enemy's
     character, set 'isEnemy' parameter to change the name's emoji */
    private func displayCharacterInformations(_ character: Character, isEnemy: Bool = false) -> String {
        let name = character.name
        let life = "❤️ \(character.life) points"
        let attack = "💪 \(character.attackPoints) points"
        let healing = "🩺 \(character.healingPoints) points"
        let item = "⚒️ \(character.item?.name ?? "Mains nues")"
        var nameEmoji = "🙂"
        if isEnemy { nameEmoji = "😡" }
        if !character.isAlive { nameEmoji = "☠️" }
        return "\(nameEmoji) \(name) (\(life), \(item), \(attack), \(healing))"
    }
    
    /* Display informations of all characters. In a menu,
     set 'for choice' parameter to present numbers */
    private func displayCharacters(
        of team: Team,
        forChoice: Bool = false,
        isEnemy: Bool = false
    ) -> String {
        var string = ""
        
        /* To display a choice, only present team's living characters */
        let characters = forChoice ? team.livingCharacters : team.characters
        
        characters.enumerated().forEach { (index, character) in
            string += "\(forChoice ? "\(index + 1). " : "")\(displayCharacterInformations(character, isEnemy: isEnemy)) \n"
        }
        return string
    }
}

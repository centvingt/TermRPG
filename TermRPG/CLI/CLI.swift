//
//  CLI.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 22/03/2021.
//

import Foundation

class CLI {
    var game: Game
    
    private var currentTeam: Team
    private var otherTeam: Team {
        currentTeam.owner == game.team1.owner ? game.team2 : game.team1
    }
    
    init(game: Game) {
        self.game = game
        self.currentTeam = game.team1
    }
    
    /* Set teams at the start of the game */
    func setTeams() {
        // Creation of the first team
        setCurrentTeam()
        
        // Creation of the second team
        currentTeam = game.team2
        setCurrentTeam()
    }
    
    func round() {
        var gameIsOver = false
        repeat {
            currentTeam = game.team1
            playerAction()
            
            currentTeam = game.team2
            playerAction()
            
            game.round += 1
            
            if game.team1.livingCharacters.isEmpty || game.team2.livingCharacters.isEmpty {
                gameIsOver = true
                presentStats()
            }
        } while !gameIsOver
    }
    
    // Set a team
    private func setCurrentTeam() {
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
    
    private func playerAction() {
        print(
            """
            \(currentTeam.owner), choisissez un personnage de votre équipe :
            \(displayCharacters(of: currentTeam, forChoice: true))
            """
        )
        var choiceIsDone = false
        repeat {
            if let choice = readLine() {
                guard let index = getCharacterIndex(choice) else {
                    print(invalidTypingMessage(maxKey: currentTeam.livingCharacters.count))
                    continue
                }
                guard let character1 = currentTeam.getLivingCharacter(by: index) else {
                    throwABigChoosingCharacterError(nthCharacter: "premier")
                    return
                }
                
                choiceIsDone = true
                print(
                    """
                    Vous avez choisi \(character1.name) :
                    \(displayCharacterInformations(character1))
                    
                    """
                )
                
                if let chestContent = Item.chestAppearance(excludeItem: character1.item) {
                    var hasAnItem = false
                    if let _ = character1.item {
                        hasAnItem = true
                    }
                    print(
                        """
                        😮 Oh ! Un coffre est apparu, il contient cet objet :
                        \(chestContent.name), 💪 \(chestContent.attackBonus), 🩺 \(chestContent.healingBonus)

                        Voulez-vous que \(character1.name) prenne cet objet\(hasAnItem ? " en remplacement de celui qu’il possède déjà" : "") ?
                        1. Oui
                        2. Non
                        """
                    )
                    var chestChoiceIsDone = false
                    repeat {
                        if let choice = readLine() {
                            guard choice == "1" || choice == "2" else {
                                print(invalidTypingMessage(maxKey: 2))
                                continue
                            }
                            chestChoiceIsDone = true
                            guard choice == "1" else {
                                continue
                            }
                            character1.item = chestContent
                        }
                    } while !chestChoiceIsDone
                }
                print(
                    """
                    Souhaitez-vous :
                    1. Attaquer un personnage de l’équipe adverse ?
                    2. Soigner un personnage de votre équipe ?
                    """
                )
                var actionIsSelected = false
                repeat {
                    if let actionChoice = readLine() {
                        guard actionChoice == "1" || actionChoice == "2" else {
                            print(invalidTypingMessage(maxKey: 2))
                            continue
                        }
                        actionIsSelected = true
                        if actionChoice == "1" {
                            var character2IsSelected = false
                            repeat {
                                print(
                                    """
                                    Choisissez le personnage de l’équipe adverse que vous souhaitez attaquer :
                                    \(displayCharacters(of: otherTeam, forChoice: true, isEnemy: true))
                                    """
                                )
                                if let choice = readLine() {
                                    guard let index = getCharacterIndex(choice) else {
                                        print(invalidTypingMessage(maxKey: otherTeam.livingCharacters.count))
                                        continue
                                    }
                                    
                                    guard let character2 = otherTeam.getLivingCharacter(by: index) else {
                                        throwABigChoosingCharacterError(nthCharacter: "deuxième")
                                        return
                                    }
                                    
                                    character2IsSelected = true
                                    
                                    character2.life -= character1.attackPoints
                                    print(
                                        """
                                        Vous avez infligé \(character1.attackPoints) points à \(character2.name), ses points de vie sont descendus à \(character2.life)\(character2.isAlive ? "" : " et il est mort 😵").
                                        
                                        """
                                    )
                                }
                            } while !character2IsSelected
                        } else {
                            var character2IsSelected = false
                            repeat {
                                print(
                                    """
                                    Choisissez le personnage de votre équipe que vous souhaitez soigner :
                                    \(displayCharacters(of: currentTeam, forChoice: true))
                                    """
                                )
                                if let choice = readLine() {
                                    guard let index = getCharacterIndex(choice) else {
                                        print(invalidTypingMessage(maxKey: currentTeam.livingCharacters.count))
                                        continue
                                    }
                                    
                                    guard let character2 = currentTeam.getLivingCharacter(by: index) else {
                                        throwABigChoosingCharacterError(nthCharacter: "deuxième")
                                        return
                                    }
                                    
                                    character2IsSelected = true
                                    character2.life += character1.healingPoints
                                    print(
                                        """
                                        Vous avez soigné \(character2.name) qui a gagné \(character1.healingPoints) points, ses points de vie sont maintenant de \(character2.life).
                                        
                                        """
                                    )
                                }
                            } while !character2IsSelected
                        }
                    }
                } while !actionIsSelected
            }
        } while !choiceIsDone
    }
    
    // Set a new character
    private func createNewCharacter() {
        var characterIsCreated = false
        repeat {
            // Get the name typed by a player
            if let name = readLine() {
                // Retry typing if the name is already in use
                if nameAlreadyExists(name) {
                    print("Ce nom a déjà été utilisé, veuillez en choisir un autre.")
                    continue
                }
                
                // Create a new character
                let character = Character(name: name)
                currentTeam.add(character: character)
                print(
                    """
                    \(name) a été ajouté à votre équipe
                    
                    """
                )
                characterIsCreated = true
            }
        } while !characterIsCreated
    }
    
    
    private func invalidTypingMessage(maxKey: Int) -> String {
        var string = "1"
        let range = 2..<maxKey
        for key in range {
            string += ", \(key)"
        }
        string += " ou \(maxKey)"
        return "🤔 Je n’ai pas compris votre choix, veuillez taper sur la touche \(string) de votre clavier.\n"
    }
    private func getCharacterIndex(_ choice: String) -> Int? {
        guard let index = Int(choice),
              1...3 ~= index else { return nil }
        return index - 1
    }
    
    
    // Find if a name already exists
    private func nameAlreadyExists(_ name: String) -> Bool {
        // Array of all existing names
        let names = game.team1.characters.map({ $0.name }) + game.team2.characters.map({ $0.name })
        
        return names.contains(name)
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
    
    private func presentStats() {
        print(
            """
            Bravo \(game.team1.livingCharacters.isEmpty ? game.team1.owner : game.team2.owner), vous avez remporté la partie !
            La partie s’est déroulée en \(game.round).

            La première équipe est dans cet état à la fin de la partie :
            \(displayCharacters(of: game.team1))

            Et voici l’état de la deuxième équipe :
            \(displayCharacters(of: game.team2))

            Tapez RECOMMENCER pour refaire une partie :
            """
        )
        
        var typingIsCorrect = false
        repeat {
            if let choice = readLine() {
                guard choice == "RECOMMENCER" else {
                    print("Je n’ai pas compris ce que vous avez tapé. Écrivez très exactement “RECOMMENCER” en respectant les majuscules pour refaire une partie")
                    continue
                }
                typingIsCorrect = true
                restart()
            }
        } while !typingIsCorrect
    }
    private func throwABigChoosingCharacterError(nthCharacter: String) {
        print("👻 Oups ! Un énorme problème est apparu en choisissant le \(nthCharacter) personnage, le jeu va redémarrer dans quelques instants...")
        restart()
    }
    private func restart() {
        game.reset()
        cli.setTeams()
        cli.round()
    }
}

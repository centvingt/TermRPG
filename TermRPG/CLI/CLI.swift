//
//  CLI.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 22/03/2021.
//

import Foundation

class CLI {    
    /* Team of the active player */
    private var currentTeam = game.team1
    
    /* Opponent's team */
    private var otherTeam: Team {
        currentTeam.owner == game.team1.owner ? game.team2 : game.team1
    }
    
    /* Set teams at the start of the game */
    func setTeams() {
        // Creation of the first team
        setCurrentTeam()
        
        // Creation of the second team
        currentTeam = game.team2
        setCurrentTeam()
    }
    
    /* Starting the game */
    func round() {
        var gameIsOver = false
        while !gameIsOver {
            currentTeam = game.team1
            playerAction()
            
            if game.team2.livingCharacters.isEmpty {
                gameIsOver = true
                gameOver()
            }
            
            currentTeam = game.team2
            playerAction()
            
            game.round += 1
            
            if game.team1.livingCharacters.isEmpty {
                gameIsOver = true
                gameOver()
            }
        }
    }
    
    /* Make a new game */
    private func restart() {
        game = Game()
        currentTeam = game.team1
        cli.setTeams()
        cli.round()
    }

    /* Finish the game */
    private func gameOver() {
        // Display game statistic
        print(
            """
            Bravo \(game.team1.livingCharacters.isEmpty ? game.team1.owner : game.team2.owner), vous avez remporté la partie !
            
            La partie s’est déroulée en \(game.round) tours.
            
            La première équipe est dans cet état à la fin de la partie :
            
            \(displayCharacters(of: game.team1))
            
            Et voici l’état de la deuxième équipe :
            
            \(displayCharacters(of: game.team2))
            
            Tapez RECOMMENCER pour refaire une partie :
            
            """
        )
        
        // Restart game
        var typingIsCorrect = false
        while !typingIsCorrect {
            if let choice = readLine() {
                guard choice == "RECOMMENCER" else {
                    print(
                        """
                        Je n’ai pas compris ce que vous avez tapé. Écrivez très exactement “RECOMMENCER” en respectant les majuscules pour refaire une partie :
                        
                        """
                    )
                    continue
                }
                typingIsCorrect = true
                restart()
            }
        }
    }
    
    /* Initialize the active team */
    private func setCurrentTeam() {
        print(
            """
            Bienvenue, \(currentTeam.owner) !
            
            """
        )
        
        // Create three characters
        let nthStrings = [ "premier", "deuxième", "troisième" ]
        for i in 0...(nthStrings.count - 1) {
            createCharacter(nthString: nthStrings[i])
        }
    }
    
    // Create a character
    private func createCharacter(nthString: String) {
        // Create sample characters for presentations
        let sampleDoctor = Doctor(name: "sample")
        let sampleFireFighter = FireFighter(name: "sample")
        let sampleMechanic = Mechanic(name: "sample")
        
        var characterIsCreated = false
        while !characterIsCreated {
            // Choosing character
            print(
                """
                Souhaitez-vous que votre \(nthString) personnage soit :
                
                1.  \(sampleDoctor.emoji) Un médecin
                    \(sampleDoctor.informations)
                2.  \(sampleFireFighter.emoji) Un pompier
                    \(sampleFireFighter.informations)
                3.  \(sampleMechanic.emoji) Un mécanicien
                    \(sampleMechanic.informations)
                
                """
            )
            guard let characterChoice = getUserChoice(),
                characterChoice <= 3 else {
                print(getInvalidTypingMessage(maxKey: 3))
                continue
            }
            
            // Create character's name
            var nameIsSetted = false
            while !nameIsSetted {
                print(
                    """
                    
                    Tapez le nom que vous souhaitez donner à ce \(nthString) personnage :
                    
                    """
                )
                guard let characterName = readLine() else { continue }
                
                // Find if character's name already exists
                let allNames = game.team1.characters.map({ $0.name }) + game.team2.characters.map({ $0.name })
                guard !allNames.contains(characterName) else {
                    print(
                        """
                        
                        Ce nom a déjà été utilisé, merci d’en choisir un autre.
                        
                        """
                    )
                    continue
                }
                nameIsSetted = true
                
                var character: Character
                switch characterChoice {
                case 1:
                    character = Doctor(name: characterName)
                case 2:
                    character = FireFighter(name: characterName)
                default:
                    character = Mechanic(name: characterName)
                }
                
                currentTeam.characters.append(character)
                characterIsCreated = true
                
                print(
                    """
                    
                    \(character.emoji) \(character.name) a été ajouté à votre équipe.
                    
                    """
                )
            }
        }
    }
    
    // Player's action
    private func playerAction() {
        enum Action { case attack, heal }
        var action: Action
        
        // Choosing character
        var character1ChoiceIsDone = false
        while !character1ChoiceIsDone {
            print(
                """
                \(currentTeam.owner), choisissez un personnage de votre équipe :
                
                \(displayCharacters(of: currentTeam, forChoice: true))
                """
            )
            
            guard let characterChoice = getUserChoice(),
                  characterChoice <= currentTeam.livingCharacters.count else {
                print(getInvalidTypingMessage(maxKey: 3))
                continue
            }
            
            let character1 = currentTeam.livingCharacters[characterChoice - 1]
            character1ChoiceIsDone = true
            
            print(
                """
                
                Vous avez choisi :
                
                    \(character1.emoji) \(character1.name)
                    \(character1.informations))
                
                """
            )
            
            // Random chest appearance
            getChest(character1)
            
            // Choosing attack or heal
            var actionChoiceIsDone = false
            while !actionChoiceIsDone {
                print(
                    """
                    Souhaitez-vous que ce personnage :
                    
                    1.  Attaque un personnage de l’équipe adverse ?
                    2.  Soigne un personnage de votre équipe ?
                    
                    """
                )
                
                // Getting the number typed by user
                guard let actionChoice = getUserChoice(),
                      // The number must not exceed 2
                      actionChoice <= 2 else {
                    print(getInvalidTypingMessage(maxKey: 2))
                    continue
                }
                
                action = actionChoice == 1 ? .attack : .heal
                actionChoiceIsDone = true
                
                // Choose the character to attack or heal
                var team: Team
                var character2ChoiceIsDone = false
                while !character2ChoiceIsDone {
                    switch action {
                    case .attack:
                        team = otherTeam
                        print(
                            """
                            
                            \(currentTeam.owner), choisissez quel joueur de l’équipe adverse vous souhaitez attaquer :
                            
                            """
                        )
                    case .heal:
                        team = currentTeam
                        print(
                            """
                            
                            \(currentTeam.owner), choisissez quel joueur de votre équipe vous souhaitez soigner :
                            
                            """
                        )
                    }
                    
                    print(
                        """
                        \(displayCharacters(of: team, forChoice: true))
                        """
                    )
                    
                    // Getting the number typed by user
                    guard let characterChoice = getUserChoice(),
                          // The number must not exceed the number of living characters
                          characterChoice <= team.livingCharacters.count else {
                        print(getInvalidTypingMessage(maxKey: team.characters.count))
                        continue
                    }
                    
                    let character2 = team.livingCharacters[characterChoice - 1]
                    character2ChoiceIsDone = true
                    
                    // Attack or heal the second character
                    switch action {
                    case .attack:
                        let life = character2.life
                        character1.attack(character2)
                        let loss = life - character2.life
                        print(
                            """
                            
                            Vous avez attaqué \(character2.name) qui a perdu \(loss), ses points de vie sont descendus à \(character2.life)\(character2.isAlive ? "" : " et il est mort 😵").
                            
                            """
                        )
                    case .heal:
                        let life = character2.life
                        character1.heal(character2)
                        let benefit = character2.life - life
                        print(
                            """
                            
                            Vous avez soigné \(character2.name) qui a gagné \(benefit) points, ses points de vie sont maintenant de \(character2.life).
                            
                            """
                        )
                    }
                }
            }
        }
    }
    
    // Randomly spawn a chest
    private func getChest(_ character1: Character) {
        if let chestContent = Item.chestAppearance(excludeItem: character1.item) {
            print(
                """
                    😮 Oh ! Un coffre est apparu, il contient cet objet :
                    
                    \(chestContent.informations)
                    
                    Voulez-vous que \(character1.name) prenne cet objet en remplacement de celui qu’il possède ?
                    
                    1. Oui
                    2. Non
                    
                    """
            )
            
            // Accept or not the object
            var chestChoiceIsDone = false
            while !chestChoiceIsDone {
                // Getting the number typed by user
                guard let chestChoice = getUserChoice(),
                      // The number must not exceed 2
                      chestChoice <= 2 else {
                    print(getInvalidTypingMessage(maxKey: 2))
                    continue
                }
                chestChoiceIsDone = true
                
                guard chestChoice == 1 else {
                    print(
                        """
                            
                        Votre personnage a refusé de prendre cet objet et conserve celui qu’il possédait.
                        
                        """
                    )
                    continue
                }
                
                print(
                    """
                        
                    Votre personnage a pris cet objet à la place de celui qu’il possédait.
                    
                    """
                )
                
                character1.item = chestContent
            }
        }
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
            let emoji = character.isAlive ? "\(character.emoji)" : "☠️"
            string += (
                """
                \(forChoice ? "\(index + 1). " : "") \(emoji) \(character.name)
                    \(character.informations))
                
                """
            )
        }
        return string
    }
    
    // Getting the number typed by user for make a choice
    private func getUserChoice() -> Int? {
        /* Return nil if the choice is not an Int
         or if the choice is a negative number */
        guard let typed = readLine(),
            let choice = Int(typed),
            choice > 0 else { return nil }
        return choice
    }
    
    /* Display an error when the number typed by the user is wrong. */
    private func getInvalidTypingMessage(maxKey: Int) -> String {
        var string = "1"
        
        // Accepted typing range
        let range = 2..<maxKey
        
        for key in range {
            string += ", \(key)"
        }
        string += " ou \(maxKey)"
        
        return "🤔 Je n’ai pas compris votre choix, veuillez taper sur la touche \(string) de votre clavier.\n"
    }
}

//
//  Team.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 21/03/2021.
//

import Foundation

class Team {
    // Player's name
    let owner: String
    
    // Team's characters
    var characters = [Character]() {
        didSet {
            // Team must not have more than three members
            if isComplete {
                characters.removeSubrange(3...)
            }
        }
    }
    
    //Living characters
    var livingCharacters: [Character] {
        characters.filter { (character) -> Bool in
            character.isAlive
        }
    }
    
    // Team is complete when it has 3 members
    private var isComplete: Bool {
        return characters.count > 2
    }
    
    init(owner: String) {
        self.owner = owner
    }
}

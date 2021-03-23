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
    
    var characters = [Character]() {
        didSet {
            // Team must not have more than three members
            if isComplete {
                characters.removeSubrange(3...)
            }
        }
    }
    
    // Team is complete when it has 3 members
    private var isComplete: Bool {
        return characters.count > 2
    }
    
    init(owner: String) {
        self.owner = owner
    }
    
    func add(character: Character) {
        characters.append(character)
    }
}

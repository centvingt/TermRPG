//
//  Character.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class Character {
    let name: String
    
    // At begining life points are at 300
    var life = 150 {
        // Life points cannot drop below 0
        didSet {
            life = life < 0 ? 0 : life
        }
    }
    
    // Character is alive if life points are greather than 0
    var isAlive: Bool {
        life > 0
    }
    
    var item: Item?
    
    init(name: String) {
        self.name = name
    }
    
    var healingPoints: Int {
        /* A character has 2 healing points, plus
         the healing points of his eventual item */
        2 + (item?.healingBonus ?? 0)
    }
    var attackPoints: Int {
        /* A character has 3 attack points, plus
         the attack points of his eventual item */
        3 + (item?.attackBonus ?? 0)
    }
}

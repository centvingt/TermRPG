//
//  Character.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class Character {
    let name: String
    let emoji: String
    var item: Item
    let baseAttack: Int
    let baseHealing: Int
    
    // At begining life points are at 300
    var life: Int {
        // Life points cannot drop below 0
        didSet {
            life = life < 0 ? 0 : life
        }
    }
    
    // Character is alive if life points are greather than 0
    var isAlive: Bool {
        life > 0
    }
    
    init(
        name: String,
        emoji: String,
        item: Item,
        life: Int,
        baseAttack: Int,
        baseHealing: Int
    ) {
        self.name = name
        self.emoji = emoji
        self.item = item
        self.life = life
        self.baseAttack = baseAttack
        self.baseHealing = baseHealing
    }
    
    var healingPoints: Int {
        /* A character has 2 healing points, plus
         the healing points of his eventual item */
        baseHealing + item.healingBonus
    }
    var attackPoints: Int {
        /* A character has 3 attack points, plus
         the attack points of his eventual item */
        baseAttack + item.attackBonus
    }
    
//    static let availableCharacters = [ Doctor, FireFighter, Mechanic ]
    var informations: String {
        """
        ❤️ Points de vie : \(life)
            💪 Points d’attaque : \(baseAttack)
            🩺 Points de soins : \(baseHealing)
            \(self.item.informations)
        """
    }
}


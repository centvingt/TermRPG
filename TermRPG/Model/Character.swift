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
    let maxLife: Int
    
    var life: Int {
        didSet {
            // Life points cannot drop below 0
            if life < 0 { life = 0 }
            
            // Life points cannot exceed maxLife
            if life > maxLife { life = maxLife}
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
        maxLife: Int,
        baseAttack: Int,
        baseHealing: Int
    ) {
        self.name = name
        self.emoji = emoji
        self.item = item
        self.maxLife = maxLife
        self.life = maxLife
        self.baseAttack = baseAttack
        self.baseHealing = baseHealing
    }

    /* Attack points are sum of the character's starting
     attack points plus the attack's bonus of the item */
    var attackPoints: Int {
        baseAttack + item.attackBonus
    }

    /* Healing points are sum to the character's starting
     healing points plus the healing's bonus of the item */
    var healingPoints: Int {
        baseHealing + item.healingBonus
    }
    
    /* Display character's informations */
    var informations: String {
        """
        ❤️ Points de vie : \(life)
            💪 Points d’attaque : \(baseAttack)
            🩺 Points de soins : \(baseHealing)
            \(self.item.informations)
        """
    }
    
    /* Attack another character */
    func attack(_ character: Character) {
        character.life -= attackPoints
    }
    
    /* Heal another character */
    func heal(_ character: Character) {
        character.life += healingPoints
    }
}


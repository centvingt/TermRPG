//
//  Character.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class FireFighter: Character {
    init(name: String) {
        super.init(
            name: name,
            emoji: "👨‍🚒",
            item: Axe(),
            maxLife: 120,
            baseAttack: 10,
            baseHealing: 20
        )
    }
}


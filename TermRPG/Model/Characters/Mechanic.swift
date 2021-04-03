//
//  Character.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class Mechanic: Character {
    init(name: String) {
        super.init(
            name: name,
            emoji: "👨‍🔧",
            item: Wrench(),
            life: 150,
            baseAttack: 40,
            baseHealing: 5
        )
    }
}


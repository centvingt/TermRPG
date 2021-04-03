//
//  Character.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class Doctor: Character {
    init(name: String) {
        super.init(
            name: name,
            emoji: "👩‍⚕️",
            item: Pills(),
            maxLife: 100,
            baseAttack: 5,
            baseHealing: 40
        )
    }
}


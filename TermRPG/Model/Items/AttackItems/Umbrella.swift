//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Umbrella: AttackItem {
    init() {
        super.init(
            name: "🌂 Parapluie",
            attackBonus: 5,
            weightProbality: 10
        )
    }
}

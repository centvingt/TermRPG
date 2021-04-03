//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Wrench: AttackItem {
    init() {
        super.init(
            name: "🔧 Clé anglaise",
            attackBonus: 10,
            weightProbality: 8
        )
    }
}

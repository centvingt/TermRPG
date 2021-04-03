//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class HydroalcoholicGel: HealingItem {
    init() {
        super.init(
            name: "🧴 Gel hydroalcoolique",
            healingBonus: 80,
            weightProbality: 2
        )
    }
}

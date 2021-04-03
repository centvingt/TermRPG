//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class GeneticalTherapy: HealingItem {
    init() {
        super.init(
            name: "🧬 Thérapie génique",
            healingBonus: 40,
            weightProbality: 4
        )
    }
}

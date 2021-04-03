//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Pads: HealingItem {
    init() {
        super.init(
            name: "🩹 Pansements",
            healingBonus: 5,
            weightProbality: 10
        )
    }
}

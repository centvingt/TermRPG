//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Injections: HealingItem {
    init() {
        super.init(
            name: "💉 Injections de boisson énergisante",
            healingBonus: 20,
            weightProbality: 6
        )
    }
}

//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Pills: HealingItem {
    init() {
        super.init(
            name: "💊 Pillules miracle",
            healingBonus: 10,
            weightProbality: 8
        )
    }
}

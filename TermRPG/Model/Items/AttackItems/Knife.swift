//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Knife: AttackItem {
    init() {
        super.init(
            name: "🔪 Couteau",
            attackBonus: 20,
            weightProbality: 6
        )
    }
}

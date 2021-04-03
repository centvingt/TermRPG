//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Dynamite: AttackItem {
    init() {
        super.init(
            name: "🧨 Dynamite",
            attackBonus: 80,
            weightProbality: 2
        )
    }
}

//
//  Umbrella.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 01/04/2021.
//

import Foundation

class Axe: AttackItem {
    init() {
        super.init(
            name: "🪓 Hache",
            attackBonus: 40,
            weightProbality: 4
        )
    }
}

//
//  Item.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class AttackItem: Item {
    init(
        name: String,
        attackBonus: Int,
        weightProbality: Int
    ) {
        super.init(
            name: name,
            attackBonus: attackBonus,
            healingBonus: 0,
            weightProbality: weightProbality
        )
    }
}

//
//  Item.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class HealingItem: Item {
    init(
        name: String,
        healingBonus: Int,
        weightProbality: Int
    ) {
        super.init(
            name: name,
            attackBonus: 0,
            healingBonus: healingBonus,
            weightProbality: weightProbality
        )
    }
}

//
//  Item.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

struct Item {
    let name: String
    let attackBonus: Int
    let healingBonus: Int
    let probability: Float
    
    // Availables items in the game
    static let items = [
        Item(
            name: "🌂 Umbrella",
            attackBonus: 5,
            healingBonus: 0,
            probability: 1
        ),
        Item(
            name: "🔧 Wrench",
            attackBonus: 10,
            healingBonus: 0,
            probability: 1
        ),
        Item(
            name: "🔪 Knife",
            attackBonus: 20,
            healingBonus: 0,
            probability: 1
        ),
        Item(
            name: "🪓 Axe",
            attackBonus: 40,
            healingBonus: 0,
            probability: 1
        ),
        Item(
            name: "🧨 Dynamite",
            attackBonus: 80,
            healingBonus: 0,
            probability: 1
        ),
        Item(
            name: "🩹 Pads",
            attackBonus: 0,
            healingBonus: 5,
            probability: 1
        ),
        Item(
            name: "💊 Pills",
            attackBonus: 0,
            healingBonus: 10,
            probability: 1
        ),
        Item(
            name: "💉 Injections de boisson énergisante",
            attackBonus: 0,
            healingBonus: 20,
            probability: 1
        ),
        Item(
            name: "🧬 Thérapie génique",
            attackBonus: 0,
            healingBonus: 40,
            probability: 1
        ),
        Item(
            name: "🧴 Hydroalcoholic gel",
            attackBonus: 0,
            healingBonus: 80,
            probability: 1
        )
    ]
}

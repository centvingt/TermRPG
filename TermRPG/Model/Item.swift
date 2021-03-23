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
    let weightProbality: Int
    
    // Availables items in the game
    private static let items = [
        Item(
            name: "🌂 Umbrella",
            attackBonus: 5,
            healingBonus: 0,
            weightProbality: 10
        ),
        Item(
            name: "🔧 Wrench",
            attackBonus: 10,
            healingBonus: 0,
            weightProbality: 8
        ),
        Item(
            name: "🔪 Knife",
            attackBonus: 20,
            healingBonus: 0,
            weightProbality: 6
        ),
        Item(
            name: "🪓 Axe",
            attackBonus: 40,
            healingBonus: 0,
            weightProbality: 4
        ),
        Item(
            name: "🧨 Dynamite",
            attackBonus: 80,
            healingBonus: 0,
            weightProbality: 2
        ),
        Item(
            name: "🩹 Pads",
            attackBonus: 0,
            healingBonus: 5,
            weightProbality: 10
        ),
        Item(
            name: "💊 Pills",
            attackBonus: 0,
            healingBonus: 10,
            weightProbality: 8
        ),
        Item(
            name: "💉 Injections de boisson énergisante",
            attackBonus: 0,
            healingBonus: 20,
            weightProbality: 6
        ),
        Item(
            name: "🧬 Thérapie génique",
            attackBonus: 0,
            healingBonus: 40,
            weightProbality: 4
        ),
        Item(
            name: "🧴 Gel hydroalcoolique",
            attackBonus: 0,
            healingBonus: 80,
            weightProbality: 2
        )
    ]
    
    static func chestAppearance() -> Item? {
        let appearanceProbability = Int.random(in: 0...10)
        guard appearanceProbability > 4 else {
            return nil
        }
        var weightedItems = [Item]()
        Item.items.forEach { (item) in
            for _ in 0...item.weightProbality {
                weightedItems.append(item)
            }
        }
        return weightedItems.randomElement()
    }
}

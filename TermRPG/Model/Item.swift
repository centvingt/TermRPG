//
//  Item.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class Item {
    let name: String
    let attackBonus: Int
    let healingBonus: Int
    let weightProbality: Int
    
    var informations: String {
        "\(self.name) (\(self is AttackItem ? "💪 +\(self.attackBonus)" : "🩺 +\(self.healingBonus)"))"
    }
    
    init(
        name: String,
        attackBonus: Int,
        healingBonus: Int,
        weightProbality: Int
    ) {
        self.name = name
        self.attackBonus = attackBonus
        self.healingBonus = healingBonus
        self.weightProbality = weightProbality
    }
    
    // Availables items in the game
    private static let availableItems = [
        Umbrella(),
        Wrench(),
        Knife(),
        Axe(),
        Dynamite(),
        Pads(),
        Pills(),
        Injections(),
        GeneticalTherapy(),
        HydroalcoholicGel()
    ]
    
    static func chestAppearance(excludeItem: Item?) -> Item? {
        let appearanceProbability = Int.random(in: 0...10)
        guard appearanceProbability > 3 else {
            return nil
        }
        var weightedItems = [Item]()
        Item.availableItems.forEach { (item) in
            for _ in 0...item.weightProbality {
                weightedItems.append(item)
            }
        }
        if let excludeItem = excludeItem {
            weightedItems = weightedItems.filter { (item) -> Bool in
                item.name != excludeItem.name
            }
        }
        return weightedItems.randomElement()
    }
}

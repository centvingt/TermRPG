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
    
    /* Display item's informations */
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
    
    /* Availables items in the game */
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
    
    /* Random appearance of a chest that offers an item.
     Provide character's item as excludeItem parameters */
    static func chestAppearance(excludeItem: Item) -> Item? {
        /* Random appearance */
        let appearanceProbability = Int.random(in: 0...10)
        guard appearanceProbability > 3 else {
            return nil
        }
        
        /* The more objects have a high weihgtProbability,
         the more they are present in weightedItems */
        var weightedItems = [Item]()
        Item.availableItems.forEach { (item) in
            for _ in 0...item.weightProbality {
                weightedItems.append(item)
            }
        }
        
        /* Character's item deletion from weightedItems array */
        weightedItems = weightedItems.filter { (item) -> Bool in
            item.name != excludeItem.name
        }
        
        /* chestAppearance() return a random item */
        return weightedItems.randomElement()
    }
}

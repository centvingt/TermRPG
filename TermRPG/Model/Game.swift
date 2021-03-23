//
//  Game.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

class Game {
    // Names's players displayed by the application
    private enum Player: String {
        case player1 = "Joueur 1"
        case player2 = "Joueur 2"
    }
    
    var team1 = Team(owner: Player.player1.rawValue)
    var team2 = Team(owner: Player.player2.rawValue)
    var round = 0
    
    func reset() {
        team1 = Team(owner: Player.player1.rawValue)
        team2 = Team(owner: Player.player2.rawValue)
        round = 0
    }
    
    func start() {
        reset()
    }
    
    func add(character: Character, to team: inout Team) {
        team.add(character: character)
    }
}

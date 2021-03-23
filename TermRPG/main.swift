//
//  main.swift
//  TermRPG
//
//  Created by Vincent Caronnet on 20/03/2021.
//

import Foundation

var game = Game()
var cli = CLI()

func presentMenu() {
    cli.setTeams()
    cli.round()
}
while true {
    presentMenu()
}

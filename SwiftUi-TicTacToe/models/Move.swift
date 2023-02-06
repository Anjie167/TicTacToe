//
//  Move.swift
//  SwiftUi-TicTacToe
//
//  Created by FAVOUR ANJOLA on 2/6/23.
//

import Foundation

struct Move{
    let player: Player
    let boardIndex: Int
    
    var indicator: String{
        return player == .human ? "xmark" : "circle"
    }
}

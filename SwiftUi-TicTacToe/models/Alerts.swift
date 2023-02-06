//
//  Alerts.swift
//  SwiftUi-TicTacToe
//
//  Created by FAVOUR ANJOLA on 2/5/23.
//

import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    var title, message, buttonTitle: Text
}

struct AlertContext {
     static let humanWin = AlertItem(
        title: Text("You Win!"),
        message: Text("You are so smart. You Beat your own AI."),
        buttonTitle: Text("Hell Yeah")
    )
    
    static let computerWin = AlertItem(
        title: Text("You Lost!"),
        message: Text("You programmed a super AI"),
        buttonTitle: Text("Rematch")
    )
    
    static let draw = AlertItem(
        title: Text("Draw"),
        message: Text("What a battle of wits we have here..."),
        buttonTitle: Text("Try Again")
    )
}

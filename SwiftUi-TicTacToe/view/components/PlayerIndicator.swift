//
//  PlayerIndicator.swift
//  SwiftUi-TicTacToe
//
//  Created by FAVOUR ANJOLA on 2/6/23.
//

import SwiftUI

struct PlayerIndicator: View {
    
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}


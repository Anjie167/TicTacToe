//
//  GameSquareView.swift
//  SwiftUi-TicTacToe
//
//  Created by FAVOUR ANJOLA on 2/6/23.
//

import SwiftUI

struct GameSquareView: View {
    var proxy: GeometryProxy
    var body: some View {
        
        let size = proxy.size
        Circle()
            .foregroundColor(.red).opacity(0.6)
            .frame(width: size.width/3.5,height: size.width/3.5)
    }
}

//
//  ContentView.swift
//  SwiftUi-TicTacToe
//
//  Created by FAVOUR ANJOLA on 2/5/23.
//

import SwiftUI





struct GameView: View {
    @StateObject private var vM = GameViewModel()

    var body: some View {
        GeometryReader{geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: vM.columns, spacing: 5){
                    ForEach(0..<9){i in
                        ZStack{
                            GameSquareView(proxy: geometry)
                            
                            PlayerIndicator(systemImageName: vM.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            vM.playGame(for: i)
                        }
                       
                    }
                }
                Spacer()
            }
            .disabled(!vM.isHumanTurn)
            .padding()
            .alert(item: $vM.alertItem){alertItem in
                Alert(
                    title: alertItem.title,
                    message: alertItem.message,
                    dismissButton: .default(alertItem.buttonTitle, action: {
                        vM.resetGame()
                    }))
            }
        }
    }
    

}

enum Player{
    case human, computer
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}



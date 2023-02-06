//
//  GameViewModel.swift
//  SwiftUi-TicTacToe
//
//  Created by FAVOUR ANJOLA on 2/6/23.
//

import SwiftUI

final class GameViewModel : ObservableObject{
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published  var isHumanTurn = true
    @Published  var alertItem: AlertItem?
    
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int)-> Bool{
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    
    
    func determineComputerMovePosition(in moves: [Move?])-> Int{
        
        // AI can win, the win
        let winPattern: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let computerMoves = moves.compactMap{$0}.filter{$0.player == .computer}
        
        let computerPositions = Set(computerMoves.map{ $0.boardIndex })
        
        for pattern in winPattern {
            let winPositions = pattern.subtracting(computerPositions)
        
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex:winPositions.first!)
                if isAvailable{
                    return winPositions.first!
                }
            }
        }
        // If AI can't win, then block
        let humanMoves = moves.compactMap{$0}.filter{$0.player == .human}
        
        let humanPositions = Set(humanMoves.map{ $0.boardIndex })
        
        for pattern in winPattern {
            let winPositions = pattern.subtracting(humanPositions)
        
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex:winPositions.first!)
                if isAvailable{
                    return winPositions.first!
                }
            }
        }
        
        //If AI can't block, the take middle square
        
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare){
            return centerSquare
        }
        
        //If AI can't take middle square, take random available square
        
        
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?])-> Bool{
        let winPattern: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap{$0}.filter{$0.player == player}
        
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPattern where pattern.isSubset(of: playerPositions){
            return true
        }
            return false
    }
    
    func checkForDraw(in moves: [Move?])-> Bool{
        return moves.compactMap{$0}.count == 9
    }
    
    func resetGame(){
        isHumanTurn = true
        moves = Array(repeating: nil, count: 9)
    }
    
    func playGame(for i: Int){
        if isSquareOccupied(in: moves, forIndex: i){
            return
        }
            moves[i] = Move(player: .human, boardIndex: i)
        isHumanTurn = false
        if checkWinCondition(for: .human, in: moves){
            alertItem = AlertContext.humanWin
            return
        }
        if checkForDraw(in: moves){
            alertItem = AlertContext.draw
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            if checkWinCondition(for: .computer, in: moves){
                alertItem = AlertContext.computerWin
                return
            }
            if checkForDraw(in: moves){
                alertItem = AlertContext.draw
                return
            }
            isHumanTurn = true

        }
    }
}

//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/20/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import Foundation

class SudokuModel {
    struct cell {
        var pencils: [Bool] = Array(repeating: false, count: 10)
        var number: Int = 0
        var fixed: Bool = false
    }
    
    var board: [[cell]] = Array(repeating: Array(repeating: cell(), count: 9), count: 9)
    var selected = (row : -1, column : -1)
    var pencilOn = false
    
    func importBoard(_ array: [[Int]]) {
        for x in 0...8 {
            for y in 0...8 {
                board[x][y].number = array[x][y]
                if (array[x][y] != 0) {
                    board[x][y].fixed = true
                }
            }
        }
    }
    
    func setPencilAt(row: Int, column: Int, number: Int) {
        board[row][column].pencils[number] = !board[row][column].pencils[number]
    }
    
    func setNumberAt(row: Int, column: Int, number: Int) {
        board[row][column].number = number
    }
    
    func numberAt(row: Int, column: Int) -> Int {
        return board[row][column].number;
    }
    

    func numberIsFixedAt(row : Int, column : Int) -> Bool {
        return board[row][column].fixed
    }
    
    func isConflictingEntryAt(row : Int, column: Int) -> Bool {
        return false
    }
    
    func anyPencilSetAt(row : Int, column : Int) -> Bool {
        for num in board[row][column].pencils {
            if (num) {
                return true
            }
        }
        return false
    }
    
    func isSetPencil(_ n : Int, row : Int, column : Int) -> Bool {
        return board[row][column].pencils[n]
    }
}

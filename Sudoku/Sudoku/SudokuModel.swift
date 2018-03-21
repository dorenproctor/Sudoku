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
    
    func numberAt(row: Int, column: Int) -> Int {
        return board[row][column].number;
    }
    

    func numberIsFixedAt(row : Int, column : Int) -> Bool {
        return board[row][column].fixed
    }
    
    func isConflictingEntryAt(row : Int, column: Int) -> Bool {
        return false;
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

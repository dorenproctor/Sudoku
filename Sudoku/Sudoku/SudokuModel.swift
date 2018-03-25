//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/20/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

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
        return board[row][column].number
    }

    func numberIsFixedAt(row : Int, column : Int) -> Bool {
        return board[row][column].fixed
    }
    
    func isConflictingEntryAt(row : Int, column: Int) -> Bool {
        let num = board[row][column].number
        // check row
        for i in 0...8 {
            if (board[row][i].number == num && i != column) {
                return true
            }
        }
        // check column
        for i in 0...8 {
            if (board[i][column].number == num && i != row) {
                return true
            }
        }
        // check square
        for i in 0...2 {
            for j in 0...2 {
                let currentRow = row + i
                let currentColumn = column + j
                if (board[currentRow][currentColumn].number == num) {
                    if !(currentRow == row && currentColumn == column) {
                        return true
                    }
                }
            }
        }
        
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

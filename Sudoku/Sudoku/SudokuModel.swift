//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/20/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import Foundation

class SudokuModel: Codable {
    struct cell: Codable {
        var number: Int = 0
        var fixed: Bool = false
        var pencils: [Bool] = Array(repeating: false, count: 10)
    }
    
    var board: [[cell]] = Array(repeating: Array(repeating: cell(), count: 9), count: 9)
    var pencilOn = false
    
    func importBoard(_ array: [[Int]]) {
        for x in 0...8 {
            for y in 0...8 {
                board[x][y].fixed = false
                board[x][y].pencils = Array(repeating: false, count: 10)
                board[x][y].number = array[x][y]
                if array[x][y] != 0 {
                    board[x][y].fixed = true
                }
            }
        }
    }
    
    func setPencilAt(row: Int, column: Int, number: Int) {
        if row >= 0 && column >= 0 {
            board[row][column].pencils[number] = !board[row][column].pencils[number]
        }
    }
    
    func setNumberAt(row: Int, column: Int, number: Int) {
        if row >= 0 && column >= 0 {
            board[row][column].number = number
        }
    }
    
    func numberAt(row: Int, column: Int) -> Int {
        if (row >= 0 && column >= 0) {
            return board[row][column].number
        }
        return -1;
    }

    func numberIsFixedAt(row : Int, column : Int) -> Bool {
        if (row >= 0 && column >= 0) {
            return board[row][column].fixed
        }
        return false
    }
    
    func isConflictingEntryAt(row : Int, column: Int) -> Bool {
        if !(row >= 0 && column >= 0) { // invalid entry
            return true
        }
        let num = board[row][column].number
        // check row
        for i in 0...8 {
            if board[row][i].number == num && i != column {
                return true
            }
        }
        // check column
        for i in 0...8 {
            if board[i][column].number == num && i != row {
                return true
            }
        }
        // check square
        let startRow = row - (row%3)
        let startColumn = column - (column%3)
        for i in 0...2 {
            for j in 0...2 {
                let currentRow = startRow + i
                let currentColumn = startColumn + j
                if board[currentRow][currentColumn].number == num {
                    if !(currentRow == row && currentColumn == column) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func anyPencilSetAt(row : Int, column : Int) -> Bool {
        if !(row >= 0 && column >= 0) { // invalid entry
            return false
        }
        for pencil in board[row][column].pencils {
            if pencil {
                return true
            }
        }
        return false
    }
    
    func isSetPencil(_ n : Int, row : Int, column : Int) -> Bool {
        if row >= 0 && column >= 0 {
            return board[row][column].pencils[n]
        }
        return false
    }
    
    func clearAllEntries() {
        for row in 0...8 {
            for column in 0...8 {
                if !board[row][column].fixed {
                    board[row][column].number = 0
                }
            }
        }
    }
    
    func clearAllConflictingEntries() {
        for row in 0...8 {
            for column in 0...8 {
                if isConflictingEntryAt(row: row, column: column) {
                    board[row][column].number = 0
                }
            }
        }
    }
    
    func checkWin() -> Bool {
        for row in 0...8 {
            for column in 0...8 {
                if isConflictingEntryAt(row: row, column: column) {
                    return false
                }
                if numberAt(row: row, column: column) == 0 {
                    return false
                }
            }
        }
        return true
    }
    
    func MakeDataPersistant() -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        return try? encoder.encode(self)
    }
}

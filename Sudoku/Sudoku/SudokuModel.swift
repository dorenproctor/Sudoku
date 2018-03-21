//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/20/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import Foundation

class SudokuModel {
    lazy var simplePuzzles = getPuzzles("simple")
    lazy var hardPuzzles = getPuzzles("hard")
    var board = [[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1]]
    
    func getPuzzles(_ name : String) {//}-> [String] {
        guard let url = Bundle.main.url(forResource: name, withExtension: "plist") else { return [] }
        guard let data = try? Data(contentsOf: url) else {return [] }
        guard let array = try? PropertyListDecoder().decode([String].self, from: data) else { return [] }
        for i in 0...100 {
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            print("\(randomIndex) :: \(array[randomIndex])")
        }
        //return array
    }
    
    func numberAt(row: Int, column: Int) -> Int {
        return board[row][column];
    }
    

    func numberIsFixedAt(row : Int, column : Int) -> Bool {
        return false;
    }
    
    func isConflictingEntryAt(row : Int, column: Int) -> Bool {
        return false;
    }
    
    func anyPencilSetAt(row : Int, column : Int) -> Bool {
        return false;
    }
    
    func isSetPencil(_ n : Int, row : Int, column : Int) -> Bool {
        return false;ƒ
    }
}

//
//  ViewController.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/19/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func easyGame(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let puzzle = appDelegate.sudoku
        let stringArray = getPuzzles("simple")
        let board = createBoard(stringArray)
        puzzle.importBoard(board)
        print(puzzle.board)
    }
    
    func createBoard(_ stringArray: [String]) -> [[Int]] {
        let randomIndex = Int(arc4random_uniform(UInt32(stringArray.count)))
        let string = stringArray[randomIndex]
        var intArray: [Int] = []
        for char in string {
            intArray.append(Int(String(char)) ?? 0)
        }
        var doubleArray = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
        var i = 0
        for x in 0...8 {
            for y in 0...8 {
                doubleArray[x][y] = intArray[i]
                i = i+1
            }
        }
        return doubleArray
    }
    
    func getPuzzles(_ name : String) -> [String] {
        guard let url = Bundle.main.url(forResource: name, withExtension: "plist") else { return [] }
        guard let data = try? Data(contentsOf: url) else {return [] }
        guard let array = try? PropertyListDecoder().decode([String].self, from: data) else { return [] }
        return array
    }
    
}



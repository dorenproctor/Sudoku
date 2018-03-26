//
//  ViewController.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/19/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // last number is a 2
//    let customGame = "29416738578645329113598274686729513495234167834187652942361985767952841351873496."
    let customGame = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame(_ gameType: String){
        if (FileManager().fileExists(atPath: appDelegate.archive.path)) {
            let alert = UIAlertController(title: "There is an existing game", message: "Starting a new game will erase its data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Default action"), style: .`default`, handler: { _ in
                let puzzle = self.appDelegate.sudoku
                let stringArray = self.getPuzzles(gameType)
                let board = self.createBoard(stringArray)
                puzzle.importBoard(board)
                self.performSegue(withIdentifier: "segueToPuzzle", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Secondary action"), style: .`default`, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let puzzle = appDelegate.sudoku
            let stringArray = getPuzzles(gameType)
            let board = createBoard(stringArray)
            puzzle.importBoard(board)
            performSegue(withIdentifier: "segueToPuzzle", sender: self)
        }
    }
    
    @IBAction func easyGame(_ sender: UIButton) {
        startGame("simple")
    }
    
    @IBAction func hardGame(_ sender: UIButton) {
        startGame("hard")
    }
    
    @IBAction func continueGame(_ sender: UIButton) {
        if (FileManager().fileExists(atPath: appDelegate.archive.path)) {
            do {
                let data = try Data(contentsOf: appDelegate.archive)
                let decoder = PropertyListDecoder()
                do {
                    let board = try decoder.decode(SudokuModel.self, from: data)
                    appDelegate.sudoku = board
                    performSegue(withIdentifier: "segueToPuzzle", sender: self)
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
        } else {
            let alert = UIAlertController(title: "No existing game", message: "There is no previous game to load", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .`default`, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func createBoard(_ stringArray: [String]) -> [[Int]] {
        let randomIndex = Int(arc4random_uniform(UInt32(stringArray.count)))
        var string = stringArray[randomIndex]
        if !customGame.isEmpty {
            string = customGame
        }
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



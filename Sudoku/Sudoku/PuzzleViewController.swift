//
//  ViewController.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/19/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    var abandonGame = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var sudokuView: SudokuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leavePuzzle(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Leave", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Leave and discard?", comment: "Default action"), style: .`default`, handler: { _ in
            do {
                if (FileManager().fileExists(atPath: self.appDelegate.archive.path)) {
                    print("AOIJSDFOIJSDOFIJEFOIJ")
                    try FileManager().removeItem(at: self.appDelegate.archive)
                }
            } catch  {
                print(error)
            }
            self.abandonGame = true
            _ = self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Secondary action"), style: .`default`, handler: { _ in
            alert.dismiss(animated: true, completion: {
                
            })
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func numberedButtonPressed(_ sender: UIButton) {
        let puzzle = appDelegate.sudoku
        let row = sudokuView.selected.row
        let column = sudokuView.selected.column
        if puzzle.pencilOn {
            puzzle.setPencilAt(row: row, column: column, number: sender.tag)
        } else {
            puzzle.setNumberAt(row: row, column: column, number: sender.tag)
        }
        sudokuView.setNeedsDisplay()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let puzzle = appDelegate.sudoku
        let row = sudokuView.selected.row
        let column = sudokuView.selected.column
        puzzle.setNumberAt(row: row, column: column, number: 0)
        sudokuView.setNeedsDisplay()

    }
    
    @IBAction func pencilButtonPressed(_ sender: UIButton) {
        let puzzle = appDelegate.sudoku
        puzzle.pencilOn = !puzzle.pencilOn
        sender.isSelected = puzzle.pencilOn
    }
    
    @IBAction func menu(_ sender: Any) {
        let alert = UIAlertController(title: "Options", message: "Select an option", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Clear all conflicting", comment: "Default action"), style: .`default`, handler: { _ in
            self.appDelegate.sudoku.clearAllConflictingEntries()
            self.sudokuView.setNeedsDisplay()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Clear all", comment: "Second action"), style: .`default`, handler: { _ in
            self.appDelegate.sudoku.clearAllEntries()
            self.sudokuView.setNeedsDisplay()
        }))
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Check for win", comment: "Third action") , style: .`default`, handler: { _ in if self.appDelegate.sudoku.checkWin() {
//                print("You win!")
////                let youWin = UIAlertController(title: "You win", message: "", preferredStyle: .alert)
////                youWin.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
////                youWin.present(alert, animated: true, completion: nil)
//            } else {
//                print("Nope")
//            }
//        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (abandonGame) {
            print("a")
            abandonGame = false
            return
        }
        if self.isMovingFromParentViewController {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            do {
                let data = appDelegate.sudoku.MakeDataPersistant()!
                try data.write(to: appDelegate.archive)
            } catch {
                print(error)
            }
        }
    }
}



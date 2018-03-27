//
//  ViewController.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/19/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    var pencilEnabled = false
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
        let alert = UIAlertController(title: "Abandon this game?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Leave and discard game", comment: "Default action"), style: .`default`, handler: { _ in
            do {
                if (FileManager().fileExists(atPath: self.appDelegate.archive.path)) {
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
        let row = sudokuView.selected.row
        let column = sudokuView.selected.column
        let num = sender.tag
        let puzzle = appDelegate.sudoku
        if pencilEnabled {
            if puzzle.numberAt(row: row, column: column) == 0 {
                puzzle.setPencilAt(row: row, column: column, number: num)
            }
        } else if puzzle.numberAt(row: row, column: column) == num {
            puzzle.setNumberAt(row: row, column: column, number: 0)
        } else if puzzle.numberAt(row: row, column: column) == 0  {
            puzzle.setNumberAt(row: row, column: column, number: num)
            if (puzzle.checkWin()) {
                let alert = UIAlertController(title: "You Win!", message: "Good job!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .`default`, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
        
        }
        
        sudokuView.setNeedsDisplay()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let row = sudokuView.selected.row
        let column = sudokuView.selected.column
        let puzzle = appDelegate.sudoku
        puzzle.setNumberAt(row: row, column: column, number: 0)
        puzzle.clearPencilAt(row: row, column: column)
        sudokuView.setNeedsDisplay()
    }
    
    @IBAction func pencilButtonPressed(_ sender: UIButton) {
        pencilEnabled = !pencilEnabled
        sender.isSelected = pencilEnabled
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
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Second action"), style: .`default`, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (abandonGame) {
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



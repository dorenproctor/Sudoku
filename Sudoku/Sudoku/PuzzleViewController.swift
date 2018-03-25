//
//  ViewController.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/19/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
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
        print(row, column)
        puzzle.setNumberAt(row: row, column: column, number: 0)
        sudokuView.setNeedsDisplay()

    }
    
    @IBAction func pencilButtonPressed(_ sender: UIButton) {
        let puzzle = appDelegate.sudoku
        puzzle.pencilOn = !puzzle.pencilOn
        sender.isSelected = puzzle.pencilOn
    }
}



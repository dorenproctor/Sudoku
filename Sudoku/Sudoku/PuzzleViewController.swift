//
//  ViewController.swift
//  Sudoku
//
//  Created by Doren Proctor on 3/19/18.
//  Copyright © 2018 Doren Proctor. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func numberedButtonPressed(_ sender: UIButton) {
//        print("sender: \(sender)")
//        print("tag: \(sender.tag)")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let puzzle = appDelegate.sudoku
        let row = puzzle.selected.row
        let column = puzzle.selected.column
        print("tag: \(sender.tag) row: \(row) col: \(column)")
        
        if puzzle.pencilOn {
            puzzle.setPencilAt(row: row, column: column, number: sender.tag)
        } else {
            puzzle.setNumberAt(row: row, column: column, number: sender.tag)
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let puzzle = appDelegate.sudoku
        let row = puzzle.selected.row
        let column = puzzle.selected.column
        puzzle.setNumberAt(row: row, column: column, number: 0)
    }
    
    @IBAction func pencilButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let puzzle = appDelegate.sudoku
        puzzle.pencilOn = !puzzle.pencilOn
    }
}



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
    
    @IBOutlet weak var sudokuView: SudokuView!
    
    
    
    @IBAction func ButtonOne(_ sender: UIButton) {
//        let row = sudokuView.selected.row
//        let column = sudokuView.selected.column
        print(sudokuView.selected)
    }
}



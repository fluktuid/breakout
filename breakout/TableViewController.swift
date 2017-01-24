//
//  TableViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 17.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var brickRowsStepper: UIStepper!
    @IBOutlet weak var brickRowsStepperLabel: UILabel!
    @IBOutlet weak var brickColumnsStepper: UIStepper!
    @IBOutlet weak var brickColumnsStepperLabel: UILabel!
    @IBOutlet weak var ballSizeStepper: UIStepper!
    @IBOutlet weak var ballSizeStepperLabel: UILabel!
    
    @IBOutlet weak var makeHarderBricksSwitch: UISwitch!
    @IBOutlet weak var gameContinueAfterGameOverSwitch: UISwitch!
    @IBOutlet weak var levelModeSwitch: UISwitch!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        brickRowsStepper.value = Double(AppDelegate.Settings.Brick.Rows)
        brickRowsStepperLabel.text = "\(AppDelegate.Settings.Brick.Rows)"
        brickColumnsStepper.value = Double(AppDelegate.Settings.Brick.Columns)
        brickColumnsStepperLabel.text = "\(AppDelegate.Settings.Brick.Columns)"
        ballSizeStepper.value = Double(AppDelegate.Settings.Ball.Size)
        ballSizeStepperLabel.text = "\(AppDelegate.Settings.Ball.Size)"
        
        gameContinueAfterGameOverSwitch.isOn = AppDelegate.Settings.Game.ContinueAfterGameOver
        makeHarderBricksSwitch.isOn = AppDelegate.Settings.Brick.HarderBricks
        levelModeSwitch.isOn = AppDelegate.Settings.Game.LevelMode
    }
    
    @IBAction func brickRowsValueChanged(_ sender: UIStepper) {
        let numRows = Int(sender.value)
        brickRowsStepperLabel.text = "\(numRows)";
        AppDelegate.Settings.Brick.Rows = numRows;
    }
    
    @IBAction func brickColumnsValueChanged(_ sender: UIStepper) {
        let numColumns = Int(sender.value)
        brickColumnsStepperLabel.text = "\(numColumns)";
        AppDelegate.Settings.Brick.Columns = numColumns;
    }
    
    @IBAction func ballSizeValueChanged(_ sender: UIStepper) {
        let size = Int(sender.value)
        ballSizeStepperLabel.text = "\(size)"
        AppDelegate.Settings.Ball.Size = CGFloat(10 + size * 5)
    }
    @IBAction func generateHarderBricks(_ sender: UISwitch) {
        AppDelegate.Settings.Brick.HarderBricks = sender.isOn
    }
    
    @IBAction func gameContinueAfterGameOverValueChanged(_ sender: UISwitch) {
        AppDelegate.Settings.Game.ContinueAfterGameOver = sender.isOn
    }
    
    @IBAction func LevelModeIsOnValueChanged(_ sender: UISwitch) {
        AppDelegate.Settings.Game.LevelMode = sender.isOn
    }
}

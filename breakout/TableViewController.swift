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
    
    @IBOutlet weak var ballCount: UILabel!
    
    @IBOutlet weak var ballSizeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ballStartAngleSpreadSlider: UISlider!
    struct ballSize {
        static var small = (SegmentIndex: 0, Size: CGFloat(15.0))
        static var medium = (SegmentIndex: 1, Size: CGFloat(25.0))
        static var large = (SegmentIndex: 2, Size: CGFloat(40.0))
    }
    struct ballSpreadAngle {
        static var small = (index: 0, angle: CGFloat(0.04))
        static var medium = (index: 1, angle: CGFloat(0.2))
        static var large = (index: 2, angle: CGFloat(0.43))
    }
    
    @IBOutlet weak var gameContinueAfterGameOverSwitch: UISwitch!
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        brickRowsStepper.value = Double(AppDelegate.Settings.Brick.Rows)
        brickRowsStepperLabel.text = "\(AppDelegate.Settings.Brick.Rows)"
        brickColumnsStepper.value = Double(AppDelegate.Settings.Brick.Columns)
        brickColumnsStepperLabel.text = "\(AppDelegate.Settings.Brick.Columns)"
        
        if AppDelegate.Settings.Ball.Size <= ballSize.small.Size {
            ballSizeSegmentedControl.selectedSegmentIndex = ballSize.small.SegmentIndex
        } else if ballSize.large.Size <= AppDelegate.Settings.Ball.Size {
            ballSizeSegmentedControl.selectedSegmentIndex = ballSize.large.SegmentIndex
        } else {
            ballSizeSegmentedControl.selectedSegmentIndex = ballSize.medium.SegmentIndex
        }
        
        gameContinueAfterGameOverSwitch.isOn = AppDelegate.Settings.Game.ContinueAfterGameOver
    }
    
    // MARK: - Settings value change handling
    @IBAction func brickRowsStepperValueChanged(_ sender: UIStepper) {
        let numRows = Int(sender.value)
        brickRowsStepperLabel.text = "\(numRows)";
        AppDelegate.Settings.Brick.Rows = numRows;
    }
    
    @IBAction func brickColumnsStepperValueChanged(_ sender: UIStepper) {
        let numColumns = Int(sender.value)
        brickColumnsStepperLabel.text = "\(numColumns)";
        AppDelegate.Settings.Brick.Columns = numColumns;
    }
    
    @IBAction func ballCountStepper(_ sender: UIStepper) {
        let balls = Int(sender.value)
        ballCount.text = String(balls)
        AppDelegate.Settings.Ball.CountOfBalls = balls
    }
    
    @IBAction func actionBallSize(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case ballSize.small.SegmentIndex:
            AppDelegate.Settings.Ball.Size = ballSize.small.Size
        case ballSize.medium.SegmentIndex:
            AppDelegate.Settings.Ball.Size = ballSize.medium.Size
        case ballSize.large.SegmentIndex:
            AppDelegate.Settings.Ball.Size = ballSize.large.Size
        default:
            AppDelegate.Settings.Ball.Size = ballSize.medium.Size
        }
    }
    
    @IBAction func actionBallSpreadAngle(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case ballSpreadAngle.small.index:
            AppDelegate.Settings.Ball.StartSpreadAngle = ballSpreadAngle.small.angle
        case ballSpreadAngle.medium.index:
            AppDelegate.Settings.Ball.StartSpreadAngle = ballSpreadAngle.medium.angle
        case ballSpreadAngle.large.index:
            AppDelegate.Settings.Ball.StartSpreadAngle = ballSpreadAngle.large.angle
        default:
            AppDelegate.Settings.Ball.StartSpreadAngle = ballSpreadAngle.medium.angle
        }
    }
    
    
    
    @IBAction func ballStartAngleSpreadSliderValueChanged(_ sender: UISlider) {
        AppDelegate.Settings.Ball.StartSpreadAngle = CGFloat(sender.value)
    }
    
    @IBAction func gameContinueAfterGameOverValueChanged(_ sender: UISwitch) {
        AppDelegate.Settings.Game.ContinueAfterGameOver = sender.isOn
    }
    
}
